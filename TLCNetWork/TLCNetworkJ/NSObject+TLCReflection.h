//
//  NSObject+TLCReflection.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (TLCReflection)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static const char * getPropertyType(objc_property_t property);
#pragma clang diagnostic pop

-(NSMutableDictionary*)getPropertyValueByObj:(id)obj;
-(id)initWithDict:(id) dict className:(NSString*)classname;

@end
