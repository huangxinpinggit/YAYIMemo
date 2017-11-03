//
//  YAPatientsViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientsViewController.h"
#import "YATagListViewController.h"
#import "YAPatienCell.h"
#import "YAPatientOneSessionCell.h"
#import "YAPatientSectionTwoHeaderView.h"
#import "YAPatientItemSectionheaderView.h"
#import "BMChineseSort.h"
#import "YAPersonModel.h"
#import "YAYIActionSheet.h"
#import "YAPhoneBookController.h"
#import "YAAddNewPatientController.h"
#import "YAPatientDetailController.h"
#import "CustomSearchBar.h"
@interface YAPatientsViewController ()<UITableViewDelegate,UITableViewDataSource,YAYIActionSheetDelegate,UISearchBarDelegate,CustomSearchBarDelegate,CustomSearchBarDataSouce,CustomsearchResultsUpdater>

@property (nonatomic, strong)UITableView *tableView;
//排序前的数组
@property (nonatomic, strong)NSMutableArray *dataArray;

//排序后的出现过的拼音首字母数组
@property(nonatomic,  strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,  strong)NSMutableArray *letterResultArr;
@property(nonatomic,  weak)UISearchBar *searchBar;
@property (nonatomic ,weak)UIButton  *searchBtn;
@property (nonatomic, strong)NSMutableArray *searchArray;
@property (nonatomic, weak)CustomSearchBar *customSearchBar;
@property (nonatomic, assign)BOOL isSearch;
@property (nonatomic, weak)UIView *emptyDataView;
@property (nonatomic, assign)NSInteger isNotnet;
@property (nonatomic, copy)NSString *keyValue;
@property (nonatomic, assign)BOOL isEditting;
@end

@implementation YAPatientsViewController

-(void)netNotReachable{
    self.isNotnet = YES;
    [self.tableView reloadData];
}
-(void)loadNetData
{
    [self loadData:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"netNotReachable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tabBarDidSelectedNotification" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
   
    //注册接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSeleted) name:@"tabBarDidSelectedNotification" object:nil];
    
   
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage new] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIView *rightView = [UIView new];
    rightView.userInteractionEnabled = YES;
    rightView.frame = CGRectMake(0, 0, 100*YAYIScreenScale, 44);
    rightView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *rightSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSearchBtn.backgroundColor = [UIColor whiteColor];
    UIImage *search = [UIImage imageNamed:@"search"];
    [rightSearchBtn setImage:search forState:UIControlStateNormal];
    rightSearchBtn.frame = CGRectMake(100*YAYIScreenScale - search.size.width-20,0,search.size.width+20, search.size.height+27);
    self.searchBtn = rightSearchBtn;
    rightSearchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightSearchBtn setImage:[UIImage new] forState:UIControlStateSelected];
    //[rightSearchBtn setTitle:@"取消" forState:UIControlStateSelected];
    rightSearchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [rightSearchBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    [rightSearchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightSearchBtn];
    
    UIButton *rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *person = [UIImage imageNamed:@"add"];
    rightAddBtn.frame = CGRectMake(100*YAYIScreenScale- person.size.width - search.size.width - 40*YAYIScreenScale, 0, person.size.width+20, person.size.height+24);
    rightAddBtn.backgroundColor = [UIColor whiteColor];
    [rightAddBtn setImage:person forState:UIControlStateNormal];
    
    [rightAddBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightAddBtn];
    
    
    //[self createSearchBar];
    
    
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
        weekSelf.isSearch = false;
        [weekSelf loadData:nil];
    }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNetData) name:@"LoginSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotReachable) name:@"netNotReachable" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
 [super viewWillDisappear:YES];
 [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
 [self.customSearchBar hidSearchBar:nil];
 [MobClick endLogPageView: self.title];
    
//    [self.searchBar resignFirstResponder];
//    self.searchBar.hidden = YES;
//
//    UIButton *searchBtn = [self.navigationItem.rightBarButtonItem.customView.subviews firstObject];
//    searchBtn.selected = NO;
//    UIImage *search = [UIImage imageNamed:@"search"];
//    [self.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(CGSizeMake(search.size.width, search.size.height));
//    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
    [self.navigationController setNavigationBarHidden:false animated:false];
    [MobClick beginLogPageView:self.title];
//    if (self.tabBarController.tabBarItem) {
//        <#statements#>
//    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar  = false;
}
-(void)tabBarSeleted{
    
    [self loadData:nil];
}
-(void)searchAction:(UIButton *)sender{
    /*
    UIImage *search = [UIImage imageNamed:@"search"];
    sender.selected = !sender.selected;
    
    CGFloat lastWith = self.searchBar.width;
    CGFloat lastX = self.searchBar.x;
    CGFloat lastMaxX = CGRectGetMaxX(self.searchBar.frame);
    CGFloat lastsearchWidth =  self.searchBtn.width ;
    if (sender.selected) {
        
        self.searchBar.width = 0;
        self.searchBar.x = lastMaxX;
        self.searchBar.hidden = NO;
        self.searchBar.text = nil;
        
        [self.searchBar becomeFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            
            self.searchBar.width = lastWith;
            self.searchBar.x = lastX;
            self.searchBtn.width = lastsearchWidth + 20;
        } completion:^(BOOL finished) {
            
            self.searchBar.width = lastWith;
            self.searchBar.x = lastX;
            [self.searchBar becomeFirstResponder];
        }];
        [self.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGSizeMake(search.size.width+20, search.size.height));
        }];
        
    }else{
        [self.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGSizeMake(search.size.width, search.size.height));
        }];
        self.searchBar.hidden = YES;
        self.searchBar.text = nil;
        [self.searchBar resignFirstResponder];
        self.isSearch = false;
        //[self.searchAry removeAllObjects];
        [self loadData:nil];
        
    }
     */
    CGFloat navH = YANavBarHeight;
    CustomSearchBar  *customSearchBar= [CustomSearchBar show:CGPointMake(0, 0) andHeight:navH];
    self.customSearchBar = customSearchBar;
    customSearchBar.searchResultsUpdater = self;
    customSearchBar.DataSource = self;
    customSearchBar.delegate = self;
    [self.navigationController.view insertSubview:customSearchBar aboveSubview:self.navigationController.navigationBar];
}


-(void)customSearchBegin
{
    self.isSearch = YES;
    self.isEditting = YES;
}
-(void)customSearchBar:(CustomSearchBar *)segment cancleButton:(UIButton *)sender {
    
    if (self.isSearch) {
        self.isSearch = false;
        if (!self.isEditting) {
            [self loadData:nil];
        }
    }else{
        [self loadData:nil];
    }
    
}
-(void)customSearchDidend:(NSString *)text
{
    
        if (!self.isSearch) {
            [self loadData:nil];
        }else{
            [self loadData:text search:YES];
        }
    self.isEditting = false;
}

- (void)customSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText {
    self.keyValue = inputText;
    [self loadData:self.keyValue];
    
}



-(void)addAction:(UIButton *)sender{
    YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"通讯录导入",@"新增患者"] ];
    sheet.tag = 1001;
    [sheet show]; //  @"",@""
}
-(void)createTableView{
    NSInteger tabH = YATabBarHeight;
    NSInteger navH = YANavBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-tabH -navH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = YAYIBackgroundColor;
//    self.tableView.contentInset = UIEdgeInsetsMake(YANavBarHeight, 0, 0, 0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YANavBarHeight, 0, 0, 0);
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
    self.tableView.separatorColor = YAYICellLineColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
}
#pragma mark ===========   UISearchBar =================
// 创建  searchBar
-(void)createSearchBar{
    // 创建searchBar
    UISearchBar *searchBar = [[UISearchBar  alloc] initWithFrame:CGRectMake(12, 0, SCREEN_W -  72, 44)];
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

//加载模拟数据
-(void)loadData:(NSString *)keyValue{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"keyValue"] = keyValue;
    [YAHttpBase GET:selectPatient_patient_url parameters:param success:^(id responseObject, int code) {
        weakSelf.isNotnet = false;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.letterResultArr removeAllObjects];
        [weakSelf.indexArray removeAllObjects];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YAPersonModel *model = [[YAPersonModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.dataArray addObject:model];
        }
        self.indexArray = [BMChineseSort IndexWithArray:self.dataArray Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.dataArray Key:@"name"];
        NSLog(@"%@",responseObject);
        [weakSelf.tableView  reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

//加载模拟数据
-(void)loadData:(NSString *)keyValue search:(BOOL)isSearched{
    __weak typeof(self) weakSelf = self;
   
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"keyValue"] = keyValue;
    [YAHttpBase GET:selectPatient_patient_url parameters:param success:^(id responseObject, int code) {
        
        weakSelf.isNotnet = false;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.letterResultArr removeAllObjects];
        [weakSelf.indexArray removeAllObjects];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            
            YAPersonModel *model = [[YAPersonModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.dataArray addObject:model];
        }
        self.indexArray = [BMChineseSort IndexWithArray:self.dataArray Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.dataArray Key:@"name"];
        [weakSelf.tableView  reloadData];
        if (isSearched) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.isSearch = false;
            });
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ==========================================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        if ([self.letterResultArr count]== 0) {
            [self nosearchResultView:YES];
        }else{
            [self nosearchResultView:false];
        }
        return [self.letterResultArr count];
    }else{
        if ([self.letterResultArr count] ==0) {
           
             [self showNoDataFlag:YES];
        }else{
             [self showNoDataFlag:false];
        }
        return [self.letterResultArr count] + 2;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return [[self.letterResultArr objectAtIndex:section] count];
    }else{
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return [[YAFMDBDatabases sharedInstance] queryAllDatabases].count;
        }else{
            return [[self.letterResultArr objectAtIndex:section - 2] count];
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
        static NSString *identifer = @"identifer";
        YAPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YAPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        }
        cell.layoutMargins = UIEdgeInsetsZero;
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.model = model;
        if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section] count]-1) {
            cell.hLine.hidden = YES;
        }else{
            cell.hLine.hidden = false;
        }
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }else{
        if (indexPath.section == 0) {
            static NSString *identifer = @"identifer1";
            YAPatientOneSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAPatientOneSessionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.titleLab.text = @"标签";
            return cell;
        }else if(indexPath.section == 1){
            
            static NSString *identifer = @"identifer2";
            YAPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.model = [[YAFMDBDatabases sharedInstance] queryAllDatabases][indexPath.row];
           
            if (indexPath.row == [[YAFMDBDatabases sharedInstance] queryAllDatabases].count -1) {
                cell.hLine.hidden = YES;
            }else{
                cell.hLine.hidden = false;
            }
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            return cell;
            
        }else{
            
            static NSString *identifer = @"identifer";
            YAPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAPatienCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.layoutMargins = UIEdgeInsetsZero;
            YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-2] objectAtIndex:indexPath.row];
            cell.model = model;
            if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section-2] count]-1) {
                cell.hLine.hidden = YES;
            }else{
                cell.hLine.hidden = false;
            }
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
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
        if (section == 1) {
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
            header.titleLab.text = self.indexArray[section - 2];
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
    if (self.isSearch) {
        return 51*YAYIScreenScale;
    }
    if (indexPath.section == 0) {
        return 44 + 9*YAYIScreenScale;
    }else{
        return 51*YAYIScreenScale;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }
    if (section == 1) {
        UIView *view = [UIView new];
        view.backgroundColor =  [UIColor colorWithHexString:@"#f5f5f5"];
        return view;
        
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isSearch) {
        return 0.01;
    }
    if (section == 1) {
        if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count == 0) {
            return 0.01;
        }
        return 9*YAYIScreenScale;
    }else{
        return 0.01;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    if (self.isSearch) {
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        YAPatientDetailController *detail = [YAPatientDetailController new];
        detail.patientid = model.id;
        detail.refreshedOperation = ^{
            [weakSelf loadData:nil];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        if(indexPath.section == 0 ){
            YATagListViewController *tagView = [YATagListViewController new];
            tagView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tagView animated:YES];
        }else {
            if (indexPath.section == 1) {
                YAPersonModel *model = [[YAFMDBDatabases sharedInstance] queryAllDatabases][indexPath.row];
                YAPatientDetailController *detail = [YAPatientDetailController new];
                detail.patientid = model.id;
                detail.refreshedOperation = ^{
                    [weakSelf loadData:nil];
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:detail animated:YES];
            }else{
                YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-2] objectAtIndex:indexPath.row];
                YAPatientDetailController *detail = [YAPatientDetailController new];
                detail.patientid = model.id;
                detail.refreshedOperation = ^{
                    [weakSelf loadData:nil];
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:detail animated:YES];
            }
            
        }
    }
  
    
    
}
#pragma mark - 代理方法
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // 判断是否进行了搜索
    if (self.isSearch) {
      return 35.0*YAYIScreenScale;
    }
    
    if (0 == section) {
        return 0;
    }else if (section == 1){
        if ([[YAFMDBDatabases sharedInstance] queryAllDatabases].count == 0) {
            return 0.01;
        }else{
           return 10+ 20*YAYIScreenScale;
        }
        
    }
     
    return 35.0*YAYIScreenScale;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        return UITableViewCellEditingStyleDelete;
    }
    if(indexPath.section >0)//是否处于编辑状态
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}
//删除cell方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[self.letterResultArr objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        [self deleteNetRequest:model.id];
    }
    if (indexPath.section == 1) {
        YAPersonModel *model = [[YAFMDBDatabases sharedInstance] queryAllDatabases][indexPath.row];
        [[YAFMDBDatabases sharedInstance] deleteDownloaid:model.id];
        [self.tableView reloadData];
    }
    if (indexPath.section >=2) {
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-2] objectAtIndex:indexPath.row];
        [[self.letterResultArr objectAtIndex:indexPath.section-2] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadData:nil];
        [self deleteNetRequest:model.id];
    }
    
   
}

#pragma mark  =======
-(void)actionSheet:(YAYIActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index
{
    __weak typeof (self) weakSelf = self;
    if (actionSheet.tag == 1001) {
        if (index == 0) {
            YAPhoneBookController *book = [YAPhoneBookController new];
            book.refreshedBlock = ^{
                [weakSelf loadData:nil];
            };
            [self.navigationController pushViewController:book animated:YES];
        }else{
            YAAddNewPatientController *view = [YAAddNewPatientController new];
            view.title = @"新增患者";
            view.refreshedRow = ^{
                [weakSelf loadData:nil];
            };
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}


#pragma mark ==============  delete Action =========

-(void)deleteNetRequest:(NSString *)patientid{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = patientid;
    [YAHttpBase POST:delete_patient_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        [weakSelf loadData:nil];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ===================== searchDelegate ======================
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.isSearch = YES;
    [self.searchArray removeAllObjects];
    for (YAPersonModel *model in self.dataArray) {
        if ([model.name containsString:searchBar.text]) {
            [self.searchArray addObject:model];
        }else if([model.mobile containsString:searchBar.text]){
            [self.searchArray addObject:model];
        }else{
            
        }
    }
    if (self.searchArray.count >0) {
        self.indexArray = [BMChineseSort IndexWithArray:self.searchArray Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.searchArray Key:@"name"];
        [self.tableView  reloadData];
    }else{
        self.indexArray = [BMChineseSort IndexWithArray:self.dataArray Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.dataArray Key:@"name"];
        [self.tableView  reloadData];
    }
    
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}


#pragma amrk ===========  自定义image =========
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
        imageView.image = self.isNotnet?[UIImage imageNamed:@"no_networks"]: [UIImage imageNamed:@"no_bperson"];
        return;
    }
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor whiteColor];
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH - statuH - 9*YAYIScreenScale -44);
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
    
    imageView.image = [UIImage imageNamed:@"no_bperson"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
        make.centerY.mas_equalTo(emptyDataView.mas_centerY).offset(-22);
        //make.centerX.mas_equalTo(emptyDataView.centerX);
    }];
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
