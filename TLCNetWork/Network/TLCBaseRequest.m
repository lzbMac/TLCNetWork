//
//  TLCBaseRequest.m
//  TLCNetWork
//
//  Created by lzb on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCBaseRequest.h"
#import "TLCNetworkingEngine.h"

#ifdef TLCDebugMacro
static NSString *const kBaseURLString = @"http://139.224.1.87";
#else
static NSString *const kBaseURLString = @"http://121.40.100.179";
#endif

static NSString *const kRequestPrefix = @"Request";
static NSString *const kReponsePrefix = @"Response";

@implementation TLCBaseRequest
@synthesize success = _success;
@synthesize fail = _fail;
@synthesize baseUrlString = _baseUrlString;
@synthesize version = _version;
@synthesize responseName = _responseName;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configInit];
    }
    return self;
}
- (void)configInit {
    self.baseUrlString = kBaseURLString;
    self.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - set/get
- (NSString *)responseName{
    if (!_responseName) {
        NSString *requestName = NSStringFromClass([self class]);
        _responseName = [requestName stringByReplacingOccurrencesOfString:kRequestPrefix withString:kReponsePrefix];
    }
    return _responseName;
}

#pragma mark - TLCRequestOperationProtocol
- (void)startRequestWithSuccess:(TLCRequestSuccess)success
                           fail:(TLCRequestFail)fail{
    self.success = success;
    self.fail = fail;
    
    [[TLCNetworkingEngine shareManger] startRequest:self];
}



@end
