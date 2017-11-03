//
//  YAAgreementViewController.m
//  YAYIMemo
//
//  Created by hxp on 2017/10/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAgreementViewController.h"
#import "YAAgreementCell.h"
@interface YAAgreementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArry;
@end

@implementation YAAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小牙签用户注册协议";
    self.dataArry = [NSMutableArray array];
    [self createTableView];
    [self loadData];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"s_Bback"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loadData{
    
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"YAHtml" ofType :@"bundle"];
    NSString *content = [bundlePath stringByAppendingPathComponent:@"register1.txt"];
 
    
    
   
    NSData *data = [NSData dataWithContentsOfFile:content];
    //
    NSString *registerStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",registerStr);
    [self.dataArry addObject:registerStr];
    [self.tableView reloadData];
    
}
-(void)createTableView{
   
    NSInteger navH = YANavBarHeight;
    if (self.tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H- navH) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layoutMargins = UIEdgeInsetsZero;
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
        [self.view addSubview:self.tableView];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifer";
    YAAgreementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAAgreementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentbLab.text = self.dataArry[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = self.dataArry[indexPath.row];
    CGFloat height = [self contentHeight:content].height;
    return height+20;
}
-(CGSize)contentHeight:(NSString *)conntent{
    
    NSDictionary *attrs = @{NSFontAttributeName : YAFont(14)};
    return [conntent boundingRectWithSize:CGSizeMake(SCREEN_W -20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
