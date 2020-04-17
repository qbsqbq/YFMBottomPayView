//
//  YFMPaymentView.h
//  YFMBottomPayView
//
//  Created by YFM on 2018/8/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <STPopup/STPopup.h>

@interface YFMPaymentView : UIViewController
- (instancetype)initTotalPay:(NSString *)totalBalance vc:(UIViewController *)vc dataSource:(NSArray *)dataSource;
//支付方式
@property (nonatomic, copy) void(^payType)(NSString *type ,NSString *balance);

@end
