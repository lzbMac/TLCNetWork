//
//  TLCRequestOperationProtocol.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TLCNetworkError;
typedef void(^TLCRequestSuccess)(id responseObject,NSDictionary *options);
typedef void(^TLCRequestFail)(TLCNetworkError *error,NSDictionary *options);

@protocol TLCRequestOperationProtocol <NSObject>


@property (nonatomic, copy) TLCRequestSuccess success;
@property (nonatomic, copy) TLCRequestFail fail;

- (void)startRequestWithSuccess:(TLCRequestSuccess)success
                           fail:(TLCRequestFail)fail;


@end
