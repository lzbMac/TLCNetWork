//
//  TLCNetworkError.m
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCNetworkError.h"

static NSString *const kDefaultReason = @"抱歉，网络连接失败~";

@implementation TLCNetworkError

+ (instancetype)networkErrorWithError:(NSError *)error{
    TLCNetworkError *networkError = [TLCNetworkError new];
    networkError.errorDesc = kDefaultReason;
    
    return networkError;
}

+ (instancetype)networkErrorWithDescription:(NSString *)description{
    TLCNetworkError *networkError = [TLCNetworkError new];
    networkError.errorDesc = description;
    
    return networkError;
}

@end
