//
//  NSObject+TLCReflection.m
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "NSObject+TLCReflection.h"
#import "TLCJSONEntityElementProtocol.h"

@implementation NSObject (TLCReflection)


static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            char *attributeTemp=(char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute)] bytes];
            char *p = strtok(attributeTemp, "\"");
            if(p)
            {
                return (const char*)p;
            }
            p = strtok(NULL, "\"");
            if(p)
                return  (const char*)p;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            char *attributeTemp=(char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute)] bytes];
            char *p = strtok(attributeTemp, "\"");
            if(p)
            {
                return (const char*)p;
            }
            p = strtok(NULL, "\"");
            if(p)
                return  (const char*)p;
        }
        return nil;
    }
    return nil;
}

- (id)initWithDict:(id)dict className:(NSString*)classname{
    self = [self init];
    @synchronized (self) {
        if (!dict)
            return self;
        unsigned int propCount=0;
        Class c = objc_getClass([classname cStringUsingEncoding:NSUTF8StringEncoding]);
        objc_property_t *properties = class_copyPropertyList([c class], &propCount);
        for (int j =0 ; j < propCount ;j++) {
            objc_property_t property = properties[j];
            if (property==NULL) {
                break;
            }
            const char *propType = getPropertyType(property);
            const char *propName = property_getName(property);
            NSString *name =[NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *type =[NSString stringWithCString:propType encoding:NSUTF8StringEncoding];
            if (type==nil) {
                type=[NSString stringWithCString:propType encoding:NSASCIIStringEncoding];
            }
            if(type==nil)
                type=name;
            if(propName) {
                NSString *keyName=name;
                NSString *propertyClassName = nil;
                if ([self respondsToSelector:@selector(replacedElementDictionary)]) {
                    NSDictionary *replacedDictionary = [self performSelector:@selector(replacedElementDictionary)];
                    propertyClassName = [replacedDictionary objectForKey:name];
                    propertyClassName = (propertyClassName.length >0) ? propertyClassName : name;
                }
                
                id obj = [dict objectForKey:keyName];
                if ((!obj) ||
                    [obj isKindOfClass:[NSNull class]])
                    continue;
                if ([type isEqualToString:@"i"] || [type isEqualToString:@"l"] || [type isEqualToString:@"s"]) {
                    [self setValue:[NSNumber numberWithInteger:[obj integerValue]] forKey:name];
                } else if ([type isEqualToString:@"I"] || [type isEqualToString:@"L"] || [type isEqualToString:@"S"]) {
                    [self setValue:[NSNumber numberWithLongLong:[obj longLongValue]] forKey:name];
                } else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
                    [self setValue:[NSNumber numberWithDouble:[obj doubleValue]] forKey:name];
                } else if ([type isEqualToString:@"NSString"]||[type hasPrefix:@"NSString"]) {
                    [self setValue:[NSString stringWithFormat:@"%@",obj] forKey:name];
                } else if ([type isEqualToString:@"c"]) {
                    [self setValue:[NSNumber numberWithChar:[obj charValue]] forKey:name];
                } else if ([type isEqualToString:@"NSMutableArray"]){
                    NSMutableArray *array=[[NSMutableArray alloc] init];
                    if ([(NSMutableArray*)obj count]>0) {
                        for (id adic in obj) {
                            if ([adic  isKindOfClass:[NSString class]]) {
                                [array addObject:adic];
                            }else {
                                Class class = NSClassFromString(propertyClassName);
                                id item=[[class alloc] initWithDict:adic className:propertyClassName];
                                if (item) {
                                    [array addObject:item];
                                }
                            }
                        }
                    }
                    [self setValue:array forKey:name];
                }else {
                    if ([obj isKindOfClass:[NSString class]]) {
                        [self setValue:[NSString stringWithString:obj] forKey:name];
                    }else{
                        id item=[[NSClassFromString(type) alloc] initWithDict:obj className:type];
                        [self setValue:item forKey:name];
                    }
                }
            }
        }
        free(properties);
    }
    return self;
}

-(NSMutableDictionary*)getPropertyValueByObj:(id)obj
{
    NSMutableDictionary *finalDict=nil;
    @synchronized(self){
        NSString *className = NSStringFromClass([obj class]);
        const char *cClassName = [className UTF8String];
        id theClass = objc_getClass(cClassName);
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
        finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *name = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *type = [[NSString alloc] initWithCString:getPropertyType(property) encoding:NSUTF8StringEncoding];
            if (!type) {
                type= [[NSString alloc] initWithCString:getPropertyType(property) encoding:NSASCIIStringEncoding];
            }
            SEL selector = NSSelectorFromString(name);
            
            
#pragma clang diagnostic puTLC
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            id value = [obj performSelector:selector];
#pragma clang diagnostic pop
            
            if ([type isEqualToString:@"i"] || [type isEqualToString:@"l"] || [type isEqualToString:@"s"]) {
                [finalDict setObject:[NSNumber numberWithInteger:[value integerValue]] forKey:name];
            } else if ([type isEqualToString:@"I"] || [type isEqualToString:@"L"] || [type isEqualToString:@"S"]) {
                [finalDict setObject:[NSNumber numberWithLongLong:[value longLongValue]] forKey:name];
            } else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
                [finalDict setObject:[NSNumber numberWithDouble:[value doubleValue]] forKey:name];
            } else if ([type isEqualToString:@"NSString"]) {
                if (value!=nil) {
                    [finalDict setObject:[NSString stringWithFormat:@"%@", value] forKey:name];
                }
            } else if ([type isEqualToString:@"c"]) {
                [finalDict setObject:[NSNumber numberWithChar:[value charValue]] forKey:name];
            } else if ([type isEqualToString:@"NSMutableArray"]) {
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:value];
                NSMutableArray *results = [[NSMutableArray alloc] init];
                for (id onceId in array) {
                    [results addObject:[self getPropertyValueByObj:onceId]];
                }
                [finalDict setObject:results forKey:name];
            } else{
                [finalDict setObject:[self getPropertyValueByObj:value] forKey:name];
            }
        }
        free(properties);
    }
    return finalDict;
}


@end
