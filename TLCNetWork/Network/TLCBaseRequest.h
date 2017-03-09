//
//  TLCBaseRequest.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//


/**
 以Reuquest为前缀，创建继承TLCBaseRequest的子类，所传参数以property形式赋值，网络请求成功后数据会以respon为前缀的类对象返回在block中，如：RequestIndexBanners，返回数据对象为ResponseIndexBanners类型，Requestxxx与Responsexxx必须一一对应
 */
#import <Foundation/Foundation.h>
#import "TLCNetworkError.h"
#import "TLCRequestOperationProtocol.h"
#import "TLCRequestParameterProtocol.h"

@interface TLCBaseRequest : NSObject
<
TLCRequestOperationProtocol,
TLCRequestParameterProtocol
>

/**
 接口名
 */
@property (nonatomic, strong) NSString *serviceName;
/**
 请求头,以键值对的形式存在,可以在init中赋值，或直接对实例对象赋值
 */
@property (nonatomic, strong)NSDictionary * headers;

/**
 是否需要身份验证,默认不需要，需要身份验证的请求可以在子类的init方法中赋值
 */
//@property (nonatomic, assign)NSString * headerAuthorization;

@end
