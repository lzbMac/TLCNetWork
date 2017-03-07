//
//  RequestIndexGoods.h
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCBaseRequest.h"

@interface RequestIndexGoods : TLCBaseRequest
@property (copy, nonatomic)NSString * equCode;
@property (copy, nonatomic)NSString * pageNum;
@property (copy, nonatomic)NSString * pageSize;
@end
