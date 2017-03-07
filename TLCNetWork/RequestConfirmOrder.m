//
//  RequestConfirmOrder.m
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "RequestConfirmOrder.h"
@implementation OrderConfirmDtoObj
@end

@implementation RequestConfirmOrder
- (instancetype)init{
    self = [super init];
    if (self) {
        self.serviceName = @":8086/api/order/confirm";
    }
    return self;
}

@end
