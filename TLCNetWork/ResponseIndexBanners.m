//
//  ResponseIndexBanners.m
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "ResponseIndexBanners.h"
@implementation IndexSubjectLeft
@end

@implementation ResponseIndexBanners
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"branner":[IndexSubjectLeft class]};
}
- (NSDictionary *)replacedElementDictionary{
    return @{@"subjectLeft":@"IndexSubjectLeft",@"branner":@"IndexSubjectLeft"};
}

@end
