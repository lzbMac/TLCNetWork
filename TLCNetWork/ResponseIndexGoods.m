//
//  ResponseIndexGoods.m
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "ResponseIndexGoods.h"

@implementation IndexGoodInfoObj
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"gid":@"id"};
}
@end


@implementation ResponseIndexGoods
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goodses":@"IndexGoodInfoObj"};
}
- (NSDictionary *)replacedElementDictionary{
    return @{@"goodses":@"IndexGoodInfoObj"};
}
@end
