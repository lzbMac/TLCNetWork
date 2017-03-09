//
//  TLCNetworkError.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLCNetworkError : NSError

+ (instancetype)networkErrorWithError:(NSError *)error;
+ (instancetype)networkErrorWithDescription:(NSString *)description;

@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorDesc;


@end
