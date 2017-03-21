//
//  TLCNetworkingEngine.m
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCNetworkingEngine.h"
#import "AFHTTPSessionManager.h"
#import "TLCBaseRequest.h"
#import "NSObject+TLCReflection.h"
#import "TLCNetworkError.h"

#define TLCDebugMacro @"TLCDebugMacro"

NSString *const kTLCNetStateCode = @"code";
NSString *const kTLCSuccessFlag = @"success";
NSString *const kTLCOpretionMsg = @"msg";
NSString *const kTLCResonseBody = @"result";
NSString *const kTLCSceneId = @"sceneId";
NSString *const kTLCAuthorization = @"Authorization";

@interface TLCNetworkingEngine ()

@property (nonatomic, strong) NSMutableArray<TLCBaseRequest *> *taskQueue;

@end


@implementation TLCNetworkingEngine

#pragma mark - public method
+ (instancetype)shareManger{
    static TLCNetworkingEngine *engine;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        engine = [TLCNetworkingEngine new];
    });
    
    return engine;
}

- (void)startRequest:(__kindof TLCBaseRequest *)requestObject{
    
    NSAssert(requestObject, @"请求实体不能为空");
    
    [self.taskQueue addObject:requestObject];
    
    NSString *requestUrlString = [NSString stringWithFormat:@"%@%@",requestObject.baseUrlString,requestObject.serviceName];
    NSDictionary *dic = [self requestParams:requestObject];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    if(requestObject.headerAuthorization.length) {
//        [manager.requestSerializer setValue:requestObject.headerAuthorization forHTTPHeaderField:kTLCAuthorization];
//    }
    //请求头设置
    if (requestObject.headers) {
        [requestObject.headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

#ifdef TLCDebugMacro
    NSLog(@"发起请求>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@"Get请求地址：\n%@",requestUrlString);
#endif
    __weak typeof(self)weakSelf = self;
    [manager POST:requestUrlString
      parameters:dic
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#ifdef TLCDebugMacro
             NSLog(@"Get请求地址：%@",requestUrlString);
             NSLog(@"请求结果：\n%@",responseObject[@"msg"]);
             NSLog(@"请求结果：\n%@",responseObject);
             NSLog(@"请求结束<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
#endif
             
             BOOL isError = NO;
             TLCNetworkError *networkError = nil;
             id responseInstance = nil;
             NSDictionary *options = nil;
             
             if (!responseObject) {
                 isError = YES;
             }else{
                 NSString *msg = [responseObject objectForKey:kTLCOpretionMsg];
                 NSString *code = [responseObject objectForKey:kTLCNetStateCode];
                 NSString *sceneId = [responseObject objectForKey:kTLCSceneId];
                 
                 options = @{kTLCNetStateCode:code?code:@"",kTLCOpretionMsg:msg?msg:@"",kTLCSceneId:sceneId?sceneId:@""};
                 
                 NSInteger success = [[responseObject objectForKey:kTLCSuccessFlag] integerValue];
                 if (!success) {
                     isError = YES;
                     networkError = [TLCNetworkError networkErrorWithDescription:msg];
                 }else{
                     id resultDict = [responseObject objectForKey:kTLCResonseBody];
                     NSString *responseName = requestObject.responseName;
                     if ([resultDict isKindOfClass:[NSDictionary class]]) {
//                         responseInstance = [[NSClassFromString(responseName)
//                                              alloc] initWithDict:resultDict className:responseName];
                         responseInstance = [NSClassFromString(responseName) yy_modelWithDictionary:resultDict];
                         
                     }else {
                         NSDictionary * resultBodyDict = @{kTLCResonseBody:resultDict?resultDict:@""};
//                         responseInstance = [[NSClassFromString(responseName)
//                                              alloc] initWithDict:resultBodyDict className:responseName];
                         responseInstance = [NSClassFromString(responseName) yy_modelWithDictionary:resultBodyDict];
                     }
                 }
             }
             
             if (isError) {
                 if (requestObject.fail) {
                     requestObject.fail(networkError, options);
                 }
             }
             else{
                 if (requestObject.success) {
                     requestObject.success(responseInstance,options);
                 }
             }
             
             [weakSelf.taskQueue removeObject:requestObject];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (requestObject.fail) {
                 TLCNetworkError *networkError = [TLCNetworkError networkErrorWithError:error];
                 requestObject.fail(networkError, nil);
             }
             [weakSelf.taskQueue removeObject:requestObject];
         }];
}

#pragma mark - set/get
- (NSMutableArray<TLCBaseRequest *> *)taskQueue{
    if (!_taskQueue) {
        _taskQueue = [NSMutableArray new];
    }
    return _taskQueue;
}

#pragma mark - private method
/*  根据request class获取 接口地址，
 *  requestObj： request 实例
 *
 *  YC custom
 */

-(NSMutableDictionary *)requestParams:(__kindof TLCBaseRequest *)requestObj{
    @autoreleasepool {
        //父类 version 节点赋值
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:requestObj.version forKey:@"version"];
        //子类所有节点
        unsigned int propCount=0;
        objc_property_t *properties = class_copyPropertyList([requestObj class], &propCount);
        for (int j =0 ; j < propCount ;j++) {
            objc_property_t property = properties[j];
            if (property==NULL) {
                break;
            }
            const char *propName = property_getName(property);
            NSString *name =[NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *value=[requestObj valueForKey:name];
            [parameters setValue:value forKey:name];
        }
        free(properties);
        return parameters;
    }
}

-(NSString *)requestAddress:(__kindof TLCBaseRequest *)requestObj
{
    @autoreleasepool {
        __block NSString *stringReturn = requestObj.baseUrlString;
        
        //find serviceName
        {
            NSString *serviceName = (requestObj.serviceName.length > 0) ? requestObj.serviceName : @"";
            stringReturn=[stringReturn stringByAppendingFormat:@"%@%@",serviceName,@"?"];
        }
        
        //find parameters
        {
            NSAssert(![requestObj isMemberOfClass:[TLCBaseRequest class]], @"请求实体类 必须为 TLCBaseRequest 实例！");
            
            //父类 version 节点赋值
            NSString *version = (requestObj.version.length > 0) ? requestObj.version : @"";
            stringReturn=[stringReturn stringByAppendingFormat:@"version=%@",version];

            NSMutableDictionary *parameters = [self requestParams:requestObj];
            //生成 Get 请求地址
            [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
                stringReturn=[stringReturn stringByAppendingFormat:@"&%@=%@",key,[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }];
        }
        
        return stringReturn;
    }
}

@end
