//
//  YASelectPatientController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/30.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASelectPatientController.h"
#import "YAPersonModel.h"
#import "BMChineseSort.h"
#import "YASelectedPatienCell.h"
#import "YAPatientSectionTwoHeaderView.h"
#import "YAPatientItemSectionheaderView.h"
@interface YASelectPatientController ()<UITableViewDelegate,UITableViewDataSource,YASelectedPatienCellDelegate,UISearchBarDelegate>
@property (nonatomic, strong)UITableView *tableView;
//排序前的数组
@property (nonatomic, strong)NSMutableArray *dataArray;

//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *searchArray;
@property (nonatomic, assign)BOOL isSearch;
@property (nonatomic,strong)YASelectedPatienCell *lastCell;
@property (nonatomic, strong)NSMutableArray *recentlyArrary;
@property (nonatomic, weak)UIView *emptyDataView;
@end

@implementation YASelectPatientController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    self.recentlyArrary = [NSMutableArray array];
    self.title = @"选择患者";
    
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
    
    [self createSearchBar];
    
    [self loadData:nil];
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    
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
        [weekSelf loadData:nil];
    }];
    
        
}

-(void)setIsPresent:(BOOL)isPresent
{
    _isPresent = isPresent;
    if (_isPresent) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 30);
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setImage:[UIImage imageNamed:@"s_Bback"] forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.searchBar.hidden = YES;
    [self.view endEditing:YES];
    [self.searchBar endEditing:YES];
    [self.searchBar resignFirstResponder];
}
-(void)createTableView{
    NSInteger navH = YANavBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = YAYIBackgroundColor;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
    self.tableView.separatorColor = YAYICellLineColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
}
//加载模拟数据

-(void)loadData:(NSString *)keyValue{
    __weak typeof(self) weekSelf = self;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"keyValue"] = nil;
    [YAHttpBase GET:selectPatient_patient_url parameters:param success:^(id responseObject, int code) {
        [weekSelf.dataArray removeAllObjects];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            
            YAPersonModel *model = [[YAPersonModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weekSelf.dataArray addObject:model];
        }
        
        weekSelf.indexArray = [BMChineseSort IndexWithArray:self.dataArray Key:@"name"];
        weekSelf.letterResultArr = [BMChineseSort sortObjectArray:self.dataArray Key:@"name"];
       
        [weekSelf.tableView  reloadData];
        [weekSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}




#pragma mark ==========================================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        if (self.letterResultArr.count == 0) {
            [self nosearchResultView:YES];
        }else{
            [self nosearchResultView:false];
        }
    
        return [self.letterResultArr count];
    }
    return [self.letterResultArr count] + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return [[self.letterResultArr objectAtIndex:section] count];
    }else{
        if(section == 0){
            return [[YAFMDBDatabases sharedInstance] queryAllDatabases].count;
        }else{
            return [[self.letterResultArr objectAtIndex:section - 1] count];
        }
    }
}

//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        static NSString *identifer = @"identifer3";
        YASelectedPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YASelectedPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        }
        cell.delegate = self;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.model = model;
        if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section] count]-1) {
            cell.hLine.hidden = YES;
        }else{
            cell.hLine.hidden = false;
        }
        return cell;
    }else{
        if(indexPath.section == 0){
            
            static NSString *identifer = @"identifer2";
            YASelectedPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YASelectedPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            YAPersonModel *model = [[YAFMDBDatabases sharedInstance] queryAllDatabases][indexPath.row];
            if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count-1 == indexPath.row) {
                cell.hLine.hidden = YES;
            }else{
                cell.hLine.hidden = false;
            }
            model.indexPath = indexPath;
            cell.model = model;
            cell.delegate = self;
            return cell;
            
        }else{
            
            static NSString *identifer = @"identifer";
            YASelectedPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YASelectedPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.delegate = self;
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
            cell.model = model;
            model.indexPath = indexPath;
            if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section-1] count]-1) {
                cell.hLine.hidden = YES;
            }else{
                cell.hLine.hidden = false;
            }
            return cell;
        }
     
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.isSearch) {
        static NSString *identifer = @"header2";
        YAPatientItemSectionheaderView *header = [[YAPatientItemSectionheaderView alloc] initWithReuseIdentifier:identifer];
        header.titleLab.text = self.indexArray[section];
        if (section %4 == 0) {
            header.hLine.backgroundColor = [UIColor colorWithHexString:@"#7690ff"];
        }else if (section % 4 == 1){
            header.hLine.backgroundColor = [UIColor colorWithHexString:@"#fddc27"];
        }else if (section % 4 == 2){
            header.hLine.backgroundColor = [UIColor colorWithHexString:@"#ff83f2"];
        }else{
            header.hLine.backgroundColor = [UIColor colorWithHexString:@"#31f3fa"];
        }
        
        
        return header;
    }else{
        if (section == 0) {
            if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count == 0) {
                return nil;
            }
            static NSString *identifer = @"header";
            YAPatientSectionTwoHeaderView *header = [[YAPatientSectionTwoHeaderView alloc] initWithReuseIdentifier:identifer];
            header.titleLab.text = @"最近患者";
            return header;
        }else{
            
            static NSString *identifer = @"header2";
            YAPatientItemSectionheaderView *header = [[YAPatientItemSectionheaderView alloc] initWithReuseIdentifier:identifer];
            header.titleLab.text = self.indexArray[section - 1];
            if (section %4 == 0) {
                header.hLine.backgroundColor = [UIColor colorWithHexString:@"#7690ff"];
            }else if (section % 4 == 1){
                header.hLine.backgroundColor = [UIColor colorWithHexString:@"#fddc27"];
            }else if (section % 4 == 2){
                header.hLine.backgroundColor = [UIColor colorWithHexString:@"#ff83f2"];
            }else{
                header.hLine.backgroundColor = [UIColor colorWithHexString:@"#31f3fa"];
            }
            return header;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51*YAYIScreenScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }else{
        if (section == 0) {
            UIView *view = [UIView new];
            view.backgroundColor =  [UIColor colorWithHexString:@"#f5f5f5"];
            return view;
            
        }else{
            return nil;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isSearch) {
        return 0.01;
    }else{
        if (section == 0) {
            if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count == 0) {
                return 0.01;
            }
            return 9*YAYIScreenScale;
        }else{
            return 0.01;
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 代理方法
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.isSearch) {
        return 35.0*YAYIScreenScale;
    }else{
        if (section == 0){
            if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count == 0) {
                return 0.01;
            }
            return 10+ 20*YAYIScreenScale;
        }
        return 35.0*YAYIScreenScale;
    }
    
}


-(void)commitAction:(NSString *)patientid name:(NSString *)name model:(YAPersonModel *)model{
    if (_isPresent) {
        if (_selectedPatientBlock) {
            _selectedPatientBlock(patientid,name);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"caseid"] = self.caseid;
        param[@"patientid"] = patientid;
        NSLog(@"%@",param);
        __weak typeof(self) weakSelf = self;
        [YAHttpBase POST:add_casePatient_url parameters:param success:^(id responseObject, int code) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if (weakSelf.refreshedRow) {
                weakSelf.refreshedRow();
            }
            [[YAFMDBDatabases sharedInstance] updateDatabases:model];
        } failure:^(NSError *error) {
            //NSLog(@"%@",error);
        }];
    }
}

-(void)selectedIndexRow:(YAPersonModel *)model
{
    self.lastCell.selectBtn.selected = false;
    YASelectedPatienCell *cell = [self.tableView cellForRowAtIndexPath:model.indexPath];
    [self commitAction:model.id name:model.name model:model];
    self.lastCell = cell;
}

#pragma mark  ===================== search 
-(void)searchAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    CGFloat lastWith = self.searchBar.width;
    CGFloat lastX = self.searchBar.x;
    CGFloat lastMaxX = CGRectGetMaxX(self.searchBar.frame);
    
    if (sender.selected) {
        
        self.searchBar.width = 0;
        self.searchBar.x = lastMaxX;
        self.searchBar.hidden = NO;
        self.searchBar.text = nil;
        
        [self.searchBar becomeFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            
            self.searchBar.width = lastWith;
            self.searchBar.x = lastX;
        } completion:^(BOOL finished) {
            
            self.searchBar.width = lastWith;
            self.searchBar.x = lastX;
            [self.searchBar becomeFirstResponder];
        }];
    }else{
        [self nosearchResultView:false];
        self.searchBar.hidden = YES;
        self.searchBar.text = nil;
        [self.searchBar resignFirstResponder];
        self.isSearch = false;
        [self.searchArray removeAllObjects];
        [self loadData:nil];
        
    }
}
#pragma mark ===================== searchDelegate ======================
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.isSearch = YES;
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.searchBar resignFirstResponder];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self.searchArray removeAllObjects];
    for (YAPersonModel *model in self.dataArray) {
        if ([model.name containsString:searchBar.text]) {
            [self.searchArray addObject:model];
        }else if([model.mobile containsString:searchBar.text]){
            [self.searchArray addObject:model];
        }else{
            
        }
    }
    if (self.searchArray.count >0 && self.isSearch) {
        self.indexArray = [BMChineseSort IndexWithArray:self.searchArray Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.searchArray Key:@"name"];
    }else if(self.searchArray.count == 0){
        [self.letterResultArr removeAllObjects];
    }
    [self.tableView  reloadData];
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}


// 创建  searchBar
-(void)createSearchBar{
    // 创建searchBar
    UISearchBar *searchBar = [[UISearchBar  alloc] initWithFrame:CGRectMake(8, 0, SCREEN_W -  68, 44)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索";
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
    searchBar.hidden = YES;
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
        
        searchField.layer.masksToBounds = YES;
    }
    //5. 设置搜索Icon
    //[searchBar setImage:[UIImage imageNamed:@"Search_Icon"]
    //             forSearchBarIcon:UISearchBarIconSearch
    //                        state:UIControlStateNormal];
}
-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
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
    //    CGContextFillRect(context, rect);
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)nosearchResultView:(BOOL)flag
{
    
    CGFloat navH = YANavBarHeight;
    CGFloat tabH = YATabBarHeight;
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
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH - tabH );
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
