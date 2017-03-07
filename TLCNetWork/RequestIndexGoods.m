//
//  RequestIndexGoods.m
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "RequestIndexGoods.h"

@implementation RequestIndexGoods
- (instancetype)init{
    self = [super init];
    if (self) {
        self.serviceName = @":8086/api/visitor/goods";
    }
    return self;
}
@end
