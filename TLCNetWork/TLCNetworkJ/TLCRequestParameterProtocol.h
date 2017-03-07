//
//  TLCRequestParameterProtocol.h
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLCRequestParameterProtocol <NSObject>

@property (nonatomic, strong) NSString *baseUrlString;
@property (nonatomic, strong) NSString *version;
@property (nonatomic ,strong) NSString *responseName;

@end
