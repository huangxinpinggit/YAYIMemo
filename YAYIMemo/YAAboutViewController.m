//
//  YAAboutViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAboutViewController.h"
#import "YASettingCell.h"
#import "YAAboutHeaderView.h"
#import "YALiabilityViewController.h"
@interface YAAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataAry;

@end

@implementation YAAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于小牙签";
    _dataAry = @[@"客服电话",@"客服邮箱",@"免责声明"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    
    [self createTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    if (indexPath.row == 0) {
        cell.nameLab.text = @"0571-81182533";
        cell.icon.hidden = YES;
    }else if (indexPath.row ==1){
        cell.nameLab.text = @"kefu@yayi365.cn";
        cell.icon.hidden = YES;
    }else{
        cell.nameLab.text = @"";
        
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54*YAYIScreenScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"0571-81182533" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0571-81182533"]];
    
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];;

    }else if (indexPath.row == 1){
    
    
    }else{
        YALiabilityViewController *view = [YALiabilityViewController new];
        [self.navigationController pushViewController:view animated:YES];
    
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"header";
    YAAboutHeaderView *header = [[YAAboutHeaderView alloc] initWithReuseIdentifier:identifer];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 176*YAYIScreenScale;
}


-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ( indexPath.row ==1) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender

{
    
    if (action == @selector(copy:)) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender

{
    
    if (action == @selector(copy:)) {
        
        if (indexPath.row == 1) {
             [UIPasteboard generalPasteboard].string =@"kefu@yayi365.cn";
        }
        
    }
    
}





@end
