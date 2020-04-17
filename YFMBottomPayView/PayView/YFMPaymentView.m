//
//  YFMPaymentView.m
//  YFMBottomPayView
//
//  Created by YFM on 2018/8/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YFMPaymentView.h"

#import "PayTopTableViewCell.h"

#import <Masonry.h>

// 动态获取屏幕宽高
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)

#define KColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LineColor                KColorFromRGB(0xefefef)
#define CColor                   KColorFromRGB(0x666666)
#define DColor                   KColorFromRGB(0x999999)
#define RemindRedColor           KColorFromRGB(0xF05F50)

@interface YFMPaymentView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UIViewController *vc;

@property (nonatomic ,copy) NSString *totalBalance;

@end

@implementation YFMPaymentView
- (instancetype)initTotalPay:(NSString *)totalBalance vc:(UIViewController *)vc dataSource:(NSArray *)dataSource{
    if (self = [super init]) {
        self.vc = vc;
        self.totalBalance = totalBalance;
        self.dataArr = dataSource;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    [self initPop];
    [self setUpUI];
}

- (void)initPop {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat height = 204;
    height += self.dataArr.count * 63;
    self.contentSizeInPopup = CGSizeMake(self.view.frame.size.width, height);
    self.popupController.navigationBarHidden = YES;
    [self.popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)]];
}

- (void)setUpUI {
    [self.view addSubview:self.tableView];
    [self creatSureBtn];
}

-(void)closeBlockView {
    [self backgroundTap];
}

- (void)backgroundTap  {
    [self.popupController dismiss];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 94)];
        v.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, v.bounds.size.height, KScreenWidth, 1)];
        line.backgroundColor = LineColor;
        [v addSubview:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, KScreenWidth, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"选择优先支付方式";
//        label.text = [NSString stringWithFormat:@"选择优先支付方式: ¥ %@",self.totalBalance];
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
//        label.attributedText = [self setPriceAttreWithStr:label.text];
        [v addSubview:label];
        
        UILabel *labelDe = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, KScreenWidth, 40)];
        labelDe.textAlignment = NSTextAlignmentCenter;
        labelDe.text = @"银行卡可用余额不足，请选择下列方式完成付";
        labelDe.font = [UIFont systemFontOfSize:13];
        labelDe.textColor = [UIColor redColor];
        labelDe.numberOfLines = 0;
        labelDe.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:0.08];
        [v addSubview:labelDe];
        
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [xButton setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
        xButton.frame = CGRectMake(8, 16, 22, 22);
        [v addSubview:xButton];
        [xButton addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventTouchUpInside];
        
        _tableView.tableHeaderView = v;
    }
    return _tableView;
}

#pragma mark === 富文本设置字体
- (NSMutableAttributedString *)setPriceAttreWithStr:(NSString *)str
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:12] range:NSMakeRange(0, 7)];
    [attri addAttribute:NSForegroundColorAttributeName value:DColor range:NSMakeRange(0, 5)];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:18] range:NSMakeRange(7, str.length - 7)];
    [attri addAttribute:NSForegroundColorAttributeName value:RemindRedColor range:NSMakeRange(5, str.length - 5)];
    return attri;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [NSString stringWithFormat:@"PayTopTableViewCell%ld",indexPath.row];
    PayTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PayTopTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
    }
    [self configCell:cell data:[self.dataArr objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
}


- (void)configCell:(PayTopTableViewCell *)cell data:(NSDictionary *)data indexPath:(NSIndexPath *)indexPath{
    cell.iconImgView.image = [UIImage imageNamed:data[@"pic"]];
    NSString *str = data[@"title"];
    cell.titleLabel.text = str;
//    cell.desLabel.text = @"推荐当前支付方式";
    if (self.currentIndex == indexPath.row) {
        cell.stateView.image =  [UIImage imageNamed:@"pay_selected"];
    }else{
        cell.stateView.image =  [UIImage imageNamed:@""];
    }
    
}


-(void)creatSureBtn
{    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 120)];
    UIButton*addBankCard = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBankCard setTitle:@"  添加银行卡付款" forState:UIControlStateNormal];
    [addBankCard addTarget:self action:@selector(handleSurePay) forControlEvents:UIControlEventTouchUpInside];
    addBankCard.frame = CGRectMake(16, 0, KScreenWidth, 63);
    [addBankCard setImage:[UIImage imageNamed:@"card"] forState:UIControlStateNormal];
    addBankCard.titleLabel.font = [UIFont systemFontOfSize:16];
    [addBankCard setTitleColor:CColor forState:UIControlStateNormal];
    addBankCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [footer addSubview:addBankCard];

    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 28, 21, 8, 13)];
    icon.image = [UIImage imageNamed:@"Chevron"];
    [footer addSubview:icon];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, 63, KScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [footer addSubview:line];
    self.tableView.tableFooterView = footer;
}

#pragma mark === 确认支付
-(void)handleSurePay
{
    if (self.payType) {
        self.payType([[self.dataArr objectAtIndex:self.currentIndex] objectForKey:@"type"],self.totalBalance);
        [self backgroundTap];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
