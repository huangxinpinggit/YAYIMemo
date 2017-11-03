//
//  YASearchworkViewController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/18.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASearchworkViewController.h"
#import "YAScheduleCell.h"
#import "YAWorkEventModel.h"
#import "YASearchWorkCell.h"
#import "YASearchWorkHeaderView.h"
@interface YASearchworkViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)NSArray *keyAry;
@property (nonatomic, weak)UIView *bottomView;
@property (nonatomic, strong)NSString *keyword;
@property (nonatomic, assign)NSInteger lastPage;
@property (nonatomic, weak)UIView *emptyDataView;
@end

@implementation YASearchworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lastPage = 1;
    self.dataAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 44);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = YAFont(15);
    [button setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    [self createSearchBar];
    [self createTableView];
    [self createBottomView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar removeFromSuperview];
    [self.bottomView removeFromSuperview];
    self.navigationItem.hidesBackButton = false;
    
}
// 创建  searchBar
-(void)createSearchBar{
    // 创建searchBar
    UISearchBar *searchBar = [[UISearchBar  alloc] initWithFrame:CGRectMake(8, 0, SCREEN_W -  63, 44)];
    searchBar.delegate = self;
   
    //    searchBar.showsCancelButton = YES;
    searchBar.barTintColor = [UIColor blackColor];

    //修改标题和标题颜色
    [[[[self.searchBar.subviews objectAtIndex:0] subviews] objectAtIndex : 0] removeFromSuperview];
    
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:28];  //YAYIColor(220, 220, 220)//YAYIBackgroundColor
    //设置背景图片
    [searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    //    [searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    searchBar.hidden = false;
    [self.navigationController.navigationBar addSubview:searchBar];
    
    self.searchBar = searchBar;
    
    //设置光标的颜色
    searchBar.tintColor = [UIColor grayColor];
    
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        searchField.backgroundColor = [UIColor whiteColor];
        searchField.layer.borderWidth = 1;
        searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName: YAColor(@"#8a8a8a"),NSFontAttributeName:YAFont(14)}];
        searchField.layer.masksToBounds = YES;
    }
}

-(void)createTableView{
    CGFloat navH = YANavBarHeight;
    if (self.tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49*YAYIScreenScale - navH) style:UITableViewStylePlain];
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
      __weak typeof(self) weekSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
    
            [weekSelf loadData:weekSelf.keyword isMore:YES];
    
    }];
    
}

#pragma mark =======================

-(void)loadData:(NSString *)keyword isMore:(BOOL)isMore{
    
    NSInteger page = 1;
    if (isMore) {
        page = self.dataAry.count/10+1;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"current_page"] = @(page);
    param[@"key"] = keyword;
    param[@"patientid"] = self.patientid;
   
    NSLog(@"%@",param);
    [YAHttpBase GET:listCalendarInfoByKey_url parameters:param success:^(id responseObject, int code) {
        NSLog(@"%@===== %@",param,responseObject);
        if (isMore) {
            if (page !=_lastPage) {
                NSArray *data = responseObject[@"data"];
                NSMutableArray *dataArray = [NSMutableArray array];
                NSMutableArray *mothAry = [NSMutableArray array];
                for (NSDictionary *dic in data) {
                    YAWorkEventModel *model = [YAWorkEventModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:model];
                    [mothAry addObject:model.month];
                }
                NSSet *set = [[NSSet alloc] initWithArray:mothAry];
                NSSortDescriptor *sdp1= [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
                NSArray *ascMonthAry = [[set allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sdp1, nil]];
                [ascMonthAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
                    NSMutableArray *itemAry = [NSMutableArray array];
                    for (YAWorkEventModel *model in dataArray) {
                        if ([obj isEqualToString:model.month]) {
                            [itemAry addObject:model];
                        }
                    }
                    
                    NSSortDescriptor *sdp2= [NSSortDescriptor sortDescriptorWithKey:@"worktime" ascending:YES];
                    NSArray *newArry = [itemAry sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sdp2, nil]];
                    
                    [mdic setObject:newArry forKey:obj];
                    [_dataAry addObject:mdic];
                }];
                _keyAry = ascMonthAry;
                [self.tableView reloadData];
            }
        }else{
            [self.dataAry removeAllObjects];
            NSArray *data = responseObject[@"data"];
            NSMutableArray *dataArray = [NSMutableArray array];
            NSMutableArray *mothAry = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                YAWorkEventModel *model = [YAWorkEventModel new];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
                [mothAry addObject:model.month];
            }
            NSSet *set = [[NSSet alloc] initWithArray:mothAry];
            NSSortDescriptor *sdp1= [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
            NSArray *ascMonthAry = [[set allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sdp1, nil]];
            [ascMonthAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
                NSMutableArray *itemAry = [NSMutableArray array];
                for (YAWorkEventModel *model in dataArray) {
                    if ([obj isEqualToString:model.month]) {
                        [itemAry addObject:model];
                    }
                }
                
                NSSortDescriptor *sdp2= [NSSortDescriptor sortDescriptorWithKey:@"worktime" ascending:YES];
                NSArray *newArry = [itemAry sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sdp2, nil]];
                
                [mdic setObject:newArry forKey:obj];
                [_dataAry addObject:mdic];
            }];
            _keyAry = ascMonthAry;
            [self.tableView reloadData];
        }
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_footer endRefreshing];
        _lastPage = page;
        
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark ==================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataAry.count == 0) {
        [self nosearchResultView:YES];
    }else{
        [self nosearchResultView:false];
    }
    return self.dataAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSDictionary *dic = self.dataAry[section];
    NSArray *arry = [dic  valueForKey:[_keyAry objectAtIndex:section]];
    
    return arry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"idntifer";
    YASearchWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        
        cell = [[YASearchWorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSDictionary *dic = self.dataAry[indexPath.section];
    NSArray *arry = [dic  valueForKey:[_keyAry objectAtIndex:indexPath.section]];
    YAWorkEventModel *model = arry[indexPath.row];
    cell.model = model;
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
    if (indexPath.row == arry.count-1) {
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35*YAYIScreenScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"header";
    YASearchWorkHeaderView *header = [[YASearchWorkHeaderView alloc] initWithReuseIdentifier:identifer];
    header.dateString = _keyAry[section];
    return header;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.searchBar resignFirstResponder];
}

#pragma mark ============================


- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, CGRectGetMaxX(rect), CGRectGetMaxY(rect), 5);
    UIBezierPath *berzPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    
    CGContextAddPath(context, berzPath.CGPath);
    CGContextFillPath(context);
    
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark ========================

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    [self loadData:searchBar.text isMore:false];
    self.keyword = searchBar.text;
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self loadData:searchText isMore:false];
    self.keyword = searchBar.text;
}

#pragma mark ===============

-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ================

-(void)createBottomView{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:bottomView];
    bottomView.frame = CGRectMake(0, SCREEN_H - 49*YAYIScreenScale, SCREEN_W, 49*YAYIScreenScale);
    self.bottomView = bottomView;
    
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [todayBtn setTitle:@"今天" forState:UIControlStateNormal];
    todayBtn.titleLabel.font = YAFont(15);
    [todayBtn addTarget:self action:@selector(todayAction:) forControlEvents:UIControlEventTouchUpInside];
    [todayBtn setTitleColor:YAColor(@"#ff414c") forState:UIControlStateNormal];
    todayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bottomView addSubview:todayBtn];
    
    todayBtn.frame = CGRectMake(22*YAYIScreenScale, 10, 60, 29);
    
}

-(void)todayAction:(UIButton *)sender{
    [_keyAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:[self todaydateStr]]) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:idx];
            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            stop = true;
        }
        
    }];
   
}
-(NSString *)todaydateStr{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年M月dd号";
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:zone];
    return [formatter stringFromDate:date];
    
}
- (void)nosearchResultView:(BOOL)flag
{
    CGFloat navH = YANavBarHeight;
   
    if (!flag) {
        [[self.emptyDataView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.emptyDataView removeFromSuperview];
        self.emptyDataView = nil;
        return;
    }
    
    if (self.emptyDataView) {
        return;
    }
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor whiteColor];
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH);
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
    
    imageView.image = [UIImage imageNamed:@"no_search"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(navH+30));
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
    }];
    
}
@end
