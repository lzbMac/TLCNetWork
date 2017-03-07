//
//  RequestConfirmOrder.h
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCBaseRequest.h"

@interface OrderConfirmDtoObj : NSObject

@property (strong, nonatomic)OrderConfirmDtoObj * goodsOrderDtos;

@property (copy, nonatomic)NSString * count;

@property (copy, nonatomic)NSString * goodsid;

@property (copy, nonatomic)NSString * standardcfg;

@end

@interface RequestConfirmOrder : TLCBaseRequest

@property (strong, nonatomic)NSDictionary * goodsOrderDtos;

@end
