//
//  YATagListViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YATagListViewController.h"
#import "YAAddPatienttagCell.h"
#import "YAAddPatienttagHeaderView.h"
#import "YAAddPatientTagActionController.h"
#import "YAAddTagListModel.h"
@interface YATagListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YAAddPatienttagHeaderViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *datarray;
@property (nonatomic, weak)UIView *emptyDataView;
@property (nonatomic, assign)NSInteger isNotnet;
@end

@implementation YATagListViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)netNotReachable{
    self.isNotnet = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNotnet = false;
    self.datarray = [NSMutableArray array];
    self.view.backgroundColor = YAColor(@"#f5f5f5");
    self.navigationItem.title = @"标签";
    [self requestNet];
    [self createTableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    __weak typeof(self) weekSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weekSelf requestNet];
    }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotReachable) name:@"netNotReachable" object:nil];
}

-(void)createTableView{
    NSInteger navH = YANavBarHeight;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-navH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YAColor(@"#f5f5f5");
        _tableView.showsVerticalScrollIndicator = false;
      
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YAAddPatienttagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAAddPatienttagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.model = _datarray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    YAAddTagListModel *model = _datarray[indexPath.row];
    YAAddPatientTagActionController *tagView = [YAAddPatientTagActionController new];
    tagView.patientArray = model.patients;
    tagView.tagName = model.tagName;
    tagView.tagid = model.tagid;
    tagView.refreshedOperation = ^{
        [weakSelf requestNet];
    };
    [self.navigationController pushViewController:tagView animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_datarray.count == 0) {
        [self showNoDataFlag:YES isNotNet:self.isNotnet];
    }else{
        [self showNoDataFlag:false isNotNet:self.isNotnet];
    }
    return _datarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64*YAYIScreenScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 74*YAYIScreenScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"headr";
    YAAddPatienttagHeaderView *header = [[YAAddPatienttagHeaderView alloc] initWithReuseIdentifier:identifer];
    header.delegate = self;
    return header;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0)//是否处于编辑状态
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}
//删除cell方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        YAAddTagListModel *model = _datarray[indexPath.row];
        [self.datarray removeObject:model];
    
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteNetRequest:model.tagid];
        //[self requestNet];
    
    
}


-(void)openAction
{
    __weak typeof(self) weakSelf = self;
    YAAddPatientTagActionController *tagView = [YAAddPatientTagActionController new];
    
    tagView.refreshedOperation = ^{
        [weakSelf requestNet];
    };
    [self.navigationController pushViewController:tagView animated:YES];

}

#pragma mark ========================

-(void)requestNet{
    
    __weak typeof(self) weakSelf = self;
    
    [YAHttpBase GET:selectPatientTag_patient_url parameters:nil success:^(id responseObject, int code) {
        weakSelf.isNotnet = false;
        [weakSelf.datarray removeAllObjects];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YAAddTagListModel *model = [YAAddTagListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.datarray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

-(void)deleteNetRequest:(NSString *)tagid{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"tagid"] = tagid;
    [YAHttpBase POST:deletePatientTag_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  没有数据时显示
 */
- (void)showNoDataFlag:(BOOL)flag isNotNet:(BOOL)isNet
{
    CGFloat navH = YANavBarHeight;
   
    if (!flag) {
        [[self.emptyDataView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.emptyDataView removeFromSuperview];
        self.emptyDataView = nil;
        return;
    }
    
    if (self.emptyDataView) {
        UIImageView *imageView = [self.emptyDataView.subviews firstObject];
        if (isNet) {
            imageView.image = [UIImage imageNamed:@"no_networks"];
        }else{
            imageView.image = [UIImage imageNamed:@"no_bperson"];
        }
        return;
    }
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor whiteColor];
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH - 74*YAYIScreenScale);
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"no_bperson"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(80*YAYIScreenScale));
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
    }];
}
@end
