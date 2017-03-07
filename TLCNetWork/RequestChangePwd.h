//
//  RequestChangePwd.h
//  TTLoveCar
//
//  Created by 李正兵 on 2017/3/7.
//  Copyright © 2017年 王洋. All rights reserved.
//

#import "TLCBaseRequest.h"

@interface RequestChangePwd : TLCBaseRequest
@property (copy, nonatomic)NSString * Authorization;
@property (copy, nonatomic)NSString * oPassword;
@property (copy, nonatomic)NSString * nPassword;

@end
