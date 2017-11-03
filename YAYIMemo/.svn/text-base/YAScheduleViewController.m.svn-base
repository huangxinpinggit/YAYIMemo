//
//  YAScheduleViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAScheduleViewController.h"
#import "YACalendar.h"
#import "YAScheduleCell.h"
#import "YAAddEventPopViewController.h"
#import "TableViewAnimationKit.h"
#import "YAWorkEventModel.h"
#import "YASearchworkViewController.h"

@interface YAScheduleViewController ()<UITableViewDelegate,UITableViewDataSource,YACalendarDelegate>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)YACalendar *calendar;
@property (nonatomic, weak)UIButton *addBtn;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *worktime;
@property (nonatomic, strong)NSString *dateStr;
@property (nonatomic, assign)NSInteger lastPage;
@property (nonatomic, weak)UIView *emptyDataView;
@property (nonatomic, assign)NSInteger isNotnet;
@end

@implementation YAScheduleViewController
-(void)loadNetData
{
    [self loadData:nil isMore:false];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"netNotReachable" object:nil];
}

-(void)netNotReachable{
    self.isNotnet = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日程";
    
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *search = [UIImage imageNamed:@"search"];
    [rightSearchBtn setImage:search forState:UIControlStateNormal];
    rightSearchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightSearchBtn setImage:[UIImage new] forState:UIControlStateSelected];
    [rightSearchBtn setTitle:@"取消" forState:UIControlStateSelected];
    rightSearchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightSearchBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    rightSearchBtn.frame = CGRectMake(0, 0,40, search.size.height);
    [rightSearchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:rightSearchBtn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    YACalendar *calendar = [[YACalendar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, (326+37)*YAYIScreenScale)];
    self.calendar = calendar;
    self.calendar.patientid = self.patientid;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
    [self createTableView];
    [self createAddBtn];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNetData) name:@"LoginSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotReachable) name:@"netNotReachable" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}


-(void)createAddBtn{
    CGFloat navH = YATabBarHeight;
    UIImage *image = [UIImage imageNamed:@"b_add"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn = button;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(@(-navH-(23*YAYIScreenScale)));
        make.right.equalTo(@(-15*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
}

-(void)addAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    YAAddEventPopViewController *popView = [YAAddEventPopViewController new];
    popView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    popView.datestr = self.dateStr;
    popView.name = self.patientName;
    NSLog(@"%@",self.dateStr);
    popView.refreshedOperation = ^{
        [weakSelf.dataArray removeAllObjects];
        [weakSelf loadData:weakSelf.worktime isMore:false];
        weakSelf.calendar.isFreshed = YES;
    };
    [self.tabBarController presentViewController:popView animated:false completion:^{
        
    }];
}

-(void)createTableView{
    NSInteger tabH = YATabBarHeight;
    NSInteger navH = YANavBarHeight;
    if (self.tabBarController.tabBar.hidden) {
        tabH = 0;
    }
    if (self.tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - tabH - navH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = YAYIBackgroundColor;
        //[UIColor colorWithHexString:@"#f3f4f6"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    self.tableView.tableHeaderView = self.calendar;
    [TableViewAnimationKit overTurnAnimationWithTableView:self.tableView];
    
    
    __weak typeof(self) weakSelf = self;
    [weakSelf loadData:weakSelf.worktime isMore:YES];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
//
//        [weakSelf loadData:weakSelf.worktime isMore:YES];
//
//    }];
}
#pragma mark ========   load data   ============
-(void)loadData:(NSString *)worktime isMore:(BOOL)isMore{
    __weak typeof(self) weekSelf = self;
    NSInteger page = 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"urrent_page"] = @(page);
    param[@"patientid"] = self.patientid;
    param[@"worktime"] = worktime;
    NSLog(@"%@",worktime);
    [YAHttpBase GET:listCalendarInfo_url parameters:param success:^(id responseObject, int code) {
        weekSelf.isNotnet = false;
        NSLog(@"%@",responseObject);
        if (isMore) {
            if (page !=_lastPage) {
                NSArray *data = responseObject[@"data"];
                for (NSDictionary *dic in data) {
                    YAWorkEventModel *model = [YAWorkEventModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [weekSelf.dataArray addObject:model];
                }
            }
        }else{
            [weekSelf.dataArray removeAllObjects];
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                YAWorkEventModel *model = [YAWorkEventModel new];
                [model setValuesForKeysWithDictionary:dic];
                [weekSelf.dataArray addObject:model];
            }
            [weekSelf.tableView reloadData];
        }
        isMore?[weekSelf.tableView.mj_footer endRefreshing]:[weekSelf.tableView.mj_header endRefreshing];
        _lastPage = page;
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark ==================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        [self showNoDataFlag:YES];
    }else{
        [self showNoDataFlag:false];
    }
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"idntifer";
    YAScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        
        cell = [[YAScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row %4 == 0) {
        cell.vLine.backgroundColor = [UIColor colorWithHexString:@"#7fe0f3"];
    }else if (indexPath.row %4 == 1){
        cell.vLine.backgroundColor = [UIColor colorWithHexString:@"#b29cff"];
    }else if (indexPath.row %4 == 2){
        cell.vLine.backgroundColor = [UIColor colorWithHexString:@"#ff799d"];
    }else{
        cell.vLine.backgroundColor = [UIColor colorWithHexString:@"#fdc293"];
    }
    if (indexPath.row == self.dataArray.count -1) {
        cell.hLine.hidden = YES;
    }else{
        cell.hLine.hidden = false;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51*YAYIScreenScale;
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
    
    
    YAWorkEventModel *model = self.dataArray[indexPath.row];
    [self.dataArray removeObject:model];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self deleteEventAction:model.id];
    [self loadData:self.worktime isMore:false];
    
   
    
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y>0) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.addBtn.transform = CGAffineTransformMakeScale(0, 0);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
            self.addBtn.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
        }];
    }

}

#pragma mark ====================
-(void)searchAction:(UIButton *)sender{
    
    YASearchworkViewController *searchView = [YASearchworkViewController new];
    searchView.patientid = self.patientid;
    [self.navigationController pushViewController:searchView animated:YES];
    
}


#pragma mark ===================

-(void)updateData:(NSString *)worktime date:(NSString *)date
{
    self.worktime = worktime;
    self.dateStr = date;
    [self.dataArray removeAllObjects];
    [self loadData:worktime isMore:false];

}

-(void)deleteEventAction:(NSString *)eventid{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = eventid;
    [YAHttpBase POST:cancelCalendarInfo_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  没有数据时显示
 */
- (void)showNoDataFlag:(BOOL)flag
{
    CGFloat navH = YANavBarHeight;
    CGFloat statuH = YAStatusBarHeight;
    if (!flag) {
        [[self.emptyDataView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.emptyDataView removeFromSuperview];
        self.emptyDataView = nil;
        return;
    }
    
    if (self.emptyDataView) {
        UIImageView *imageView = [[self.emptyDataView subviews] firstObject];
        imageView.image = self.isNotnet?[UIImage imageNamed:@"no_networks"]: [UIImage imageNamed:@"no_bschedule"];
        return;
    }
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor whiteColor];
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH - statuH - (326+37)*YAYIScreenScale -30);
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
   
    imageView.image = [UIImage imageNamed:@"no_bschedule"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(30));
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
        //make.centerX.mas_equalTo(emptyDataView.centerX);
    }];
}
@end
