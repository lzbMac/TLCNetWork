//
//  RequestChangePwd.m
//  TTLoveCar
//
//  Created by 李正兵 on 2017/3/7.
//  Copyright © 2017年 王洋. All rights reserved.
//

#import "RequestChangePwd.h"

@implementation RequestChangePwd
- (instancetype)init{
    self = [super init];
    if (self) {
        self.serviceName = @":8086/api/user/password";
        self.headerAuthorization = @"";
    }
    return self;
}
@end
