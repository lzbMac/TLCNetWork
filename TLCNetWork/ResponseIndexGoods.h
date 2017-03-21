//
//  ResponseIndexGoods.h
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCBaseResponse.h"

@interface IndexGoodInfoObj : NSObject
@property (copy, nonatomic)NSString * gid;
@property (copy, nonatomic)NSString * storeId;
@property (copy, nonatomic)NSString * isLogin;
@property (copy, nonatomic)NSString * path;
@property (copy, nonatomic)NSString * price;
@property (copy, nonatomic)NSString * priceM;
@property (copy, nonatomic)NSString * im;
@property (copy, nonatomic)NSString * name;
@end

@interface ResponseIndexGoods : TLCBaseResponse
@property (copy, nonatomic)NSString * size;
@property (strong, nonatomic)NSMutableArray<IndexGoodInfoObj *> * goodses;
@end
