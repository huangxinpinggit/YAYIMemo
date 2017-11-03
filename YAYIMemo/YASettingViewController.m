//
//  YASettingViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASettingViewController.h"
#import "YAAboutViewController.h"
#import "YAPersonInfoController.h"
#import "YASettingCell.h"
@interface YASettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataAry;
@end

@implementation YASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    _dataAry = @[@"个人信息",@"关于小牙签"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self createTableView];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
   
}
-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f6"];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREEN_W, 10*YAYIScreenScale);
    view.backgroundColor = [UIColor colorWithHexString:@"#f3f3f6"];
    self.tableView.tableHeaderView = view;
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    footer.frame = CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.tableView.frame)-64-2*51*YAYIScreenScale-10*YAYIScreenScale);
    self.tableView.tableFooterView = footer;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YASettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = _dataAry[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54*YAYIScreenScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        YAAboutViewController *aboutView = [YAAboutViewController new];
        [self.navigationController pushViewController:aboutView animated:YES];
    }else{
        YAPersonInfoController *personInfo = [YAPersonInfoController new];
        [self.navigationController pushViewController:personInfo animated:YES];
    }
}
@end
