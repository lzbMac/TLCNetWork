//
//  TLCNetworkingEngine.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLCBaseRequest;

extern NSString *const kTLCNetStateCode;
extern NSString *const kTLCSuccessFlag;
extern NSString *const kTLCOpretionMsg;
extern NSString *const kTLCResonseBody;
extern NSString *const kTLCSceneId;
extern NSString *const kTLCAuthorization;
@interface TLCNetworkingEngine : NSObject

+ (instancetype)shareManger;

- (void)startRequest:(__kindof TLCBaseRequest *)requestObject;

@end
