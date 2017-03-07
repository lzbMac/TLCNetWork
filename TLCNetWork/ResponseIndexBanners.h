//
//  ResponseIndexBanners.h
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "TLCBaseResponse.h"

@interface IndexSubjectLeft : NSObject
@property (copy, nonatomic)NSString * event;

@property (copy, nonatomic)NSString * refid;

@property (copy, nonatomic)NSString * memo;

@property (copy, nonatomic)NSString * share;

@end

@interface ResponseIndexBanners : TLCBaseResponse

@property (copy, nonatomic)NSString * isHotSubjectsShow;

@property (copy, nonatomic)NSString * isSubjectsShow;

@property (copy, nonatomic)NSString * isActShow;

@property (copy, nonatomic)NSString * refid;

@property (strong, nonatomic)IndexSubjectLeft * subjectLeft;

@property (strong, nonatomic)NSMutableArray<IndexSubjectLeft *> * branner;


@end
