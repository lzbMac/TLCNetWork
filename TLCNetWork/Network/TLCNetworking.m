//
//  TLCNetworking.m
//  TLCNetWork
//
//  Created by lzb on 2017/2/13.
//  Copyright © 2017年 李正兵. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TLCNetworking.h"

@implementation TLCNetworking

+ (void)registerNetworking{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

@end
