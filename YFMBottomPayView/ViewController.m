//
//  ViewController.m
//  YFMBottomPayView
//
//  Created by YFM on 2018/8/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ViewController.h"

#import "YFMPaymentView.h"

#import <STPopup/STPopup.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)handlePayAction:(UIButton *)sender {
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.title = @"首页";
    NSArray *payTypeArr = @[
                            @{@"pic":@"pic_blance",
                              @"title":@"余额(剩余￥960.00)",
                              @"type":@"balance"},
                            @{@"pic":@"pic_alipay",
                              @"title":@"华夏银行 储蓄卡 (6055) ",
                              @"type":@"alipay"},
                            @{@"pic":@"pic_alipay",
                              @"title":@"华夏银行 储蓄卡 (6055) ",
                              @"type":@"alipay"},
                            @{@"pic":@"pic_alipay",
                              @"title":@"华夏银行 储蓄卡 (6055) ",
                              @"type":@"alipay"},
                            ];
    
    YFMPaymentView *pop = [[YFMPaymentView alloc]initTotalPay:@"39.99" vc:self dataSource:payTypeArr];
    STPopupController *popVericodeController = [[STPopupController alloc] initWithRootViewController:pop];
    popVericodeController.style = STPopupStyleBottomSheet;
    [popVericodeController presentInViewController:self];
    
    pop.payType = ^(NSString *type,NSString *balance) {
        NSLog(@"选择了支付方式:%@\n需要支付金额:%@",type,balance);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //navigationBar出现
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    //隐藏navigationBar
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

@end
