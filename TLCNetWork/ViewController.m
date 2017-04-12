//
//  ViewController.m
//  TLCNetWork
//
//  Created by 李正兵 on 2017/3/6.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import "ViewController.h"
#import "RequestIndexBanners.h"
#import "RequestConfirmOrder.h"
#import "ResponseIndexBanners.h"
#import "RequestChangePwd.h"

#import "RequestIndexGoods.h"

@interface ViewController ()

@end

@implementation ViewController
//以Reuquest为前缀，创建继承TLCBaseRequest的子类，所传参数以property形式赋值，网络请求成功后数据会以respon为前缀的类对象返回在block中，如：RequestIndexBanners，返回数据对象为ResponseIndexBanners类型，Requestxxx与Responsexxx必须一一对应，目前该库还存在一些问题
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fecthIndexGoods];
    [self fetchIndexBannerData];
//    [self fetchOrderConfirmData];
//    [self changePwdRequest];
}
//首页数据请求模拟
- (void)fetchIndexBannerData {
    RequestIndexBanners *request = [RequestIndexBanners new];
    [request startRequestWithSuccess:^(id responseObject, NSDictionary *options) {
        ResponseIndexBanners *rsp = (ResponseIndexBanners *)responseObject;
        NSLog(@"----------Banner success---------");
    } fail:^(TLCNetworkError *error, NSDictionary *options) {
        NSLog(@"----------fail---------");
    }];
}
- (void)fecthIndexGoods{
    RequestIndexGoods *request = [RequestIndexGoods new];
    request.pageNum = @"1";
    request.pageSize = @"10";
    request.equCode = @"e61c07a17efdI";
    [request startRequestWithSuccess:^(id responseObject, NSDictionary *options) {
        NSLog(@"----------Goods success---------");
        
    } fail:^(TLCNetworkError *error, NSDictionary *options) {
        NSLog(@"----------fail---------");
    }];
}

- (void)fetchOrderConfirmData {
    RequestConfirmOrder *request = [RequestConfirmOrder new];
    OrderConfirmDtoObj *objSuper = [OrderConfirmDtoObj new];
    OrderConfirmDtoObj *objs = [OrderConfirmDtoObj new];
    OrderConfirmDtoObj *objSub = [OrderConfirmDtoObj new];
    objSub.count = @"1";
    objSub.goodsid = @"225";
    objSub.standardcfg = @"1";

    objs.goodsOrderDtos = objSub;
    objSuper.goodsOrderDtos = objs;

    request.goodsOrderDtos = @{@"goodsOrderDtos":@{@"goodsOrderDtos":@{@"count":@"1",@"goodsid":@"225",@"standardcfg":@"1"}}};
    [request startRequestWithSuccess:^(id responseObject, NSDictionary *options) {
        NSLog(@"----------success---------");
    } fail:^(TLCNetworkError *error, NSDictionary *options) {
        NSLog(@"----------fail---------");
    }];
}
- (void)changePwdRequest {
    RequestChangePwd *request = [RequestChangePwd new];
    request.Authorization = @"Bearer 1ef38928-c389-443e-b31c-d63dfa5f6026";
    request.oPassword = @"lzb12345";
    request.nPassword = @"wyy12345";
    request.headers = @{@"Authorization":@"Bearer 1ef38928-c389-443e-b31c-d63dfa5f6026"};
    [request startRequestWithSuccess:^(id responseObject, NSDictionary *options) {

    } fail:^(TLCNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
