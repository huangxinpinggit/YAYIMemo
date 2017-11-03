//
//  YAMedicalViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMedicalViewController.h"
#import "YAMedicalImageViewCell.h"
#import "YAMedicalMoreImageViewCell.h"
#import "YAMedicalVoiceViewCell.h"
#import "YAMedicalTextViewCell.h"
#import "YAMedicalModel.h"
#import "YATagViewController.h"
#import "YAYIActionSheet.h"
#import "YAPhoneBookController.h"
#import "YAAddNewPatientController.h"
#import "YASelectPatientController.h"
#import "YWViewController.h"
#import "TableViewAnimationKit.h"
#import "YAPublishedTextController.h"
#import "YACameraViewController.h"
#import "YAPatientDetailController.h"
#import "YARecorderView.h"
#import "YAPersonItemModel.h"
#import "CustomSearchBar.h"
#import "AppDelegate.h"

//#import "MMDrawerController+YA.h"
@interface YAMedicalViewController ()<UITableViewDelegate,UITableViewDataSource,YAMedicalImageViewCellDelegate,YAMedicalTextViewCellDelegate,YAMedicalVoiceViewCellDelegate,YAMedicalMoreImageViewCellDelegate,YAYIActionSheetDelegate,YARecorderViewDelegate,UISearchBarDelegate,CustomSearchBarDelegate,CustomSearchBarDataSouce,CustomsearchResultsUpdater>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, weak)UIView *alphaView;
@property (nonatomic, assign)NSInteger lastPage;
@property (nonatomic, assign)NSInteger selectedRow;
@property (nonatomic, weak)UIButton *editBtn;
@property (nonatomic, weak)UIButton *cameraBtn;
@property (nonatomic, weak)UIButton *micBtn;
@property (nonatomic, weak)UIImageView *bgBtn;
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, weak)UISearchBar *searchBar;
@property (nonatomic, strong)NSString *keyWord;
@property (nonatomic, weak)UIButton *searchBtn;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, weak)UIView *emptyDataView;
@property (nonatomic, weak)CustomSearchBar *customSearchBar;
@property (nonatomic, strong)YAMedicalVoiceViewCell *lastCell;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度所用字典
@property (nonatomic, assign)NSInteger isNotnet;
@property (nonatomic, assign)BOOL isfreshed;
@property (nonatomic, assign)BOOL isSearched;
@property (nonatomic, assign)BOOL isEditting;
@end

@implementation YAMedicalViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"netNotReachable" object:nil];
}

-(void)netNotReachable{
    self.isNotnet = YES;
    [self.tableView reloadData];
}
-(void)loadNetData
{
    [self netRequest:false keyword:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.heightAtIndexPath = [NSMutableDictionary dictionary];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"individual"];
    [leftbtn setImage:image forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(0, 0,image.size.width +20 ,image.size.height+20);
    [leftbtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
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
    rightSearchBtn.frame = CGRectMake(100*YAYIScreenScale - image.size.width-20,0,search.size.width+20, search.size.height+27);
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
    _dataAry = [NSMutableArray array];
    [self netRequest:NO keyword:nil];
    [self createTableview];
    [self createMenuView];
   
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    
    //  刷新
    __weak typeof(self) weakSelf = self;
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         weakSelf.isSearched = false;
         [weakSelf netRequest:NO keyword:nil];
     }];
     header.lastUpdatedTimeLabel.hidden = YES;
     [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
     [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
     [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
     
     // 设置字体
     header.stateLabel.font = [UIFont systemFontOfSize:13];
     header.stateLabel.textColor = YA_COLOR(171, 171, 171);
     self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        
        [self netRequest:true keyword:nil];
        
    }];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNetData) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotReachable) name:@"netNotReachable" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.customSearchBar hidSearchBar:nil];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [MobClick endLogPageView:self.title];;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false animated:false];
    [MobClick beginLogPageView:self.title];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar  = false;
    [self getPersonInfo];
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

-(void)netRequest:(BOOL)isMore keyword:(NSString *)keyWord{
    __weak typeof(self) weakSelf = self;
    NSInteger page = 1;
    if (isMore) {
        page = self.dataAry.count/10 + 1;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currentPage"] = @(page);
    param[@"keyword"] = keyWord;
    [YAHttpBase GET:case_list_url parameters:param success:^(id responseObject, int code){
        weakSelf.isNotnet = false;
       
        if (isMore) {
             weakSelf.isfreshed = false;
            if (_lastPage != page) {
                NSArray *data = responseObject[@"data"];
                for (NSDictionary *dic in data) {
                    YAMedicalModel *model = [YAMedicalModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    //YA_LOG(@"%@", model.tagList);
                    [weakSelf.dataAry addObject:model];
                }
                [weakSelf.tableView reloadData];
            }
            
        }else{
            [self.dataAry removeAllObjects];
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            weakSelf.isfreshed = YES;
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                YAMedicalModel *model = [YAMedicalModel new];
                [model setValuesForKeysWithDictionary:dic];
                //YA_LOG(@"%@", model.tagList);
                [weakSelf.dataAry addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
       
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        _lastPage = page;
       
        
    } failure:^(NSError *error) {
       
    }];

}
-(void)createMenuView{
    CGFloat navH = YATabBarHeight;
    NSInteger tabH = YATabBarHeight;
    UIImage *bgImage = [UIImage imageNamed:@"black_bg"];
    UIImageView *imageView = [UIImageView new];
    imageView.image = bgImage;
    self.bgBtn = imageView;
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(SCREEN_W - bgImage.size.width -8*YAYIScreenScale, SCREEN_H - navH -23*YAYIScreenScale -bgImage.size.height - tabH, bgImage.size.width, bgImage.size.height);
    
    NSArray *imageAry = @[@"edit",@"camera",@"mic"];
    for (int  i = 0 ; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:imageAry[i]];
        CGFloat itemX= SCREEN_W -((bgImage.size.width-image.size.width)/2.0+8*YAYIScreenScale+image.size.width);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 101+i;
        [button setImage:image forState:UIControlStateNormal];
        [self.view addSubview:button];
        if (i == 0) {
            self.editBtn = button;
            button.frame = CGRectMake(itemX, CGRectGetMaxY(imageView.frame)-12-image.size.height,image.size.width ,image.size.height);
        }else if(i == 1){
            self.cameraBtn = button;
            button.frame = CGRectMake(itemX, 0, image.size.width, image.size.height);
            button.center = imageView.center;
        }else{
            self.micBtn = button;
            button.frame = CGRectMake(itemX, CGRectGetMinY(imageView.frame)+8, image.size.width, image.size.height);
        }
        
        
    }

}

-(void)createTableview{
    NSInteger tabH = YATabBarHeight;
    NSInteger navH = YANavBarHeight;
    if (self.tableView == nil) {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-tabH - navH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.showsVerticalScrollIndicator = false;
    //self.tableView.estimatedRowHeight = 238.0f;
    //self.tableView.rowHeight =UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self.view addSubview:self.tableView];
   }
}

#pragma mark =========  tableViewDlegate==================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearched) {
        if (self.dataAry.count== 0) {
            [self nosearchResultView:YES];
        }else{
            [self nosearchResultView:false];
        }
    }else{
        if (self.dataAry.count == 0) {
            [self showNoDataFlag:YES];
        }else{
            [self showNoDataFlag:false];
        }
    }
    
    return self.dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    YAMedicalModel *model = self.dataAry[indexPath.row];
    
    if (model.type == 0) { //图片
        NSArray *ary = [model.info componentsSeparatedByString:@","];
        if(ary.count == 1){ // 单张图
            static NSString *identifer1 = @"identifer1";
            YAMedicalImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer1];
            if (cell == nil) {
                cell = [[YAMedicalImageViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer1];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.moreIcon.tag = indexPath.row + 1000;
            [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.tooth.tag = indexPath.row + 2000;
            cell.delegate = self;
            cell.model = model;
            cell.isFreshed = self.isfreshed;
            model.index = indexPath.row;
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            return cell;
        
        }else{  // 多张图
            static NSString *identifer2 = @"identifer2";
            YAMedicalMoreImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer2];
            if (cell == nil) {
                cell = [[YAMedicalMoreImageViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer2];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.moreIcon.tag = indexPath.row + 1000;
            [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.tooth.tag = indexPath.row + 2000;
            cell.delegate = self;
            cell.model = model;
            cell.isFreshed = self.isfreshed;
            model.index = indexPath.row;
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            return cell;
        
        }
    }else if (model.type == 1){ // 文本
        static NSString *identifer3 = @"identifer3";
        YAMedicalTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (cell == nil) {
            cell = [[YAMedicalTextViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer3];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.tooth.tag = indexPath.row + 2000;
        cell.moreIcon.tag = indexPath.row + 1000;
        cell.delegate = self;
        cell.isOpen = model.isOpen;
         cell.model = model;
        model.index = indexPath.row;
        model.indexPath = indexPath;
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }else{ // 语音
        static NSString *identifer4 = @"identifer4";
        YAMedicalVoiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer4];
        if (cell == nil) {
            cell = [[YAMedicalVoiceViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer4];
        }
       
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.moreIcon.tag = indexPath.row + 1000;
        [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.tooth.tag = indexPath.row + 2000;
        cell.delegate = self;
        cell.model = model;
        model.index = indexPath.row;
        model.indexPath = indexPath;
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAMedicalModel *model = _dataAry[indexPath.row];
   
    if (model.type == 0) {
        NSArray *ary = [model.info componentsSeparatedByString:@","];
        if (ary.count == 1) {
            if ([model.patientid integerValue] == 0) {
                return 35 +321.5*YAYIScreenScale + [model tagviewHH];
            }
            return 35 +371.5*YAYIScreenScale + [model tagviewHH];
        }else{
            if ([model.patientid integerValue] == 0) {
                return 35 +168*YAYIScreenScale + [model tagviewHH];
            }
            return 35 + 218*YAYIScreenScale+[model tagviewHH];;
        }
    }else if (model.type == 1){
        CGFloat height = [self contentHeight:model.info].height;
        if (model.isOpen) {
            if ([model.patientid integerValue] == 0) {
                return 35 + 127.5*YAYIScreenScale + [model tagviewHH] + height;
            }
            return 35 + 177.5*YAYIScreenScale + [model tagviewHH] + height;
        }else{
            if ([model.patientid integerValue] == 0) {
                return 35 + 192.5*YAYIScreenScale + [model tagviewHH] ;
            }
            return 35 + 242.5*YAYIScreenScale + [model tagviewHH] ;
        }
    }else{
         UIImage *voice = [UIImage imageNamed:@"voice_b1"];
        if ([model.patientid integerValue] == 0) {
            
            return 55+120.5*YAYIScreenScale+ [model tagviewHH]+voice.size.height;
        }
        
         return 55+170.5*YAYIScreenScale+ [model tagviewHH]+voice.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//给cell添加动画  摇摆从0到完全显示
/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    /*
    cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
     */
    
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y ==-64) {
        NSArray *cells = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath * indexPath in cells) {
            YAMedicalModel * model = [self.dataAry objectAtIndex:indexPath.row];
            
            YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell loadImage:model];
        }
    }
    //NSLog(@"%lf",scrollView.contentOffset.y);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        NSArray *cells = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath * indexPath in cells) {
            YAMedicalModel * model = [self.dataAry objectAtIndex:indexPath.row];
            
            YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell loadImage:model];
        }
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //如果tableview停止滚动，开始加载图像
    NSArray *cells = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath * indexPath in cells) {
        YAMedicalModel * model = [self.dataAry objectAtIndex:indexPath.row];
        
        YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell loadImage:model];
    }
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSArray *cells = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath * indexPath in cells) {
        YAMedicalModel * model = [self.dataAry objectAtIndex:indexPath.row];
        
        YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell loadImage:model];
    }
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return 238;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(YAHomeBaseCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //YAHomeBaseCell *cell = cell;
    
   // [cell loadImage:nil];
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UIImage *image = [UIImage imageNamed:@"edit"];
    UIImage *bgImage = [UIImage imageNamed:@"black_bg"];
    CGFloat margin = (bgImage.size.width - image.size.width)/2.0;
    if (velocity.y >0) {
    
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.bgBtn.alpha = 0;
            self.editBtn.transform = CGAffineTransformMakeScale(0, 0);
            self.cameraBtn.transform = CGAffineTransformMakeScale(0, 0);
            self.micBtn.transform = CGAffineTransformMakeScale(0, 0);
            /*
            CGRect rect = self.editBtn.frame;
            rect.size.width =0;
            rect.size.height = 0;
            rect.origin.x = SCREEN_W -8*YAYIScreenScale-margin-image.size.width/2.0;
            [self.editBtn setFrame:rect];
            
            CGRect rect2 = self.cameraBtn.frame;
            rect2.size.width = 0;
            rect2.size.height = 0;
            rect2.origin.x =  SCREEN_W -8*YAYIScreenScale-margin-image.size.width/2.0;
            [self.cameraBtn setFrame:rect2];
            
            CGRect rect3 = self.micBtn.frame;
            rect3.size.height = 0;
            rect3.size.width = 0;
            rect3.origin.x =  SCREEN_W -8*YAYIScreenScale-margin-image.size.width/2.0;
            [self.micBtn setFrame:rect3];
            
             */
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else{
        [UIView animateWithDuration: 0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
            // 放大
            /*
            
            CGRect rect = self.editBtn.frame;
            rect.size.width =image.size.width;
            rect.size.height = image.size.height;
            rect.origin.x =SCREEN_W  - image.size.width -margin -8*YAYIScreenScale;
            [self.editBtn setFrame:rect];
            
            CGRect rect2 = self.cameraBtn.frame;
            rect2.size.width = image.size.width;
            rect2.size.height = image.size.height;
            rect2.origin.x = SCREEN_W - image.size.width-8*YAYIScreenScale-margin;
            [self.cameraBtn setFrame:rect2];
            
            CGRect rect3 = self.micBtn.frame;
            rect3.size.height = image.size.width;
            rect3.size.width = image.size.height;
            rect3.origin.x = SCREEN_W - image.size.width-8*YAYIScreenScale-margin;
            [self.micBtn setFrame:rect3];
             */
            self.editBtn.transform = CGAffineTransformMakeScale(1, 1);
            self.cameraBtn.transform = CGAffineTransformMakeScale(1, 1);
            self.micBtn.transform = CGAffineTransformMakeScale(1, 1);
            self.bgBtn.alpha = 1.0;
        } completion:nil];
       
        /*
        
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect rect = self.editBtn.frame;
            rect.size.width =image.size.width;
            rect.size.height = image.size.height;
            rect.origin.x =SCREEN_W  - image.size.width -margin -8*YAYIScreenScale;
            [self.editBtn setFrame:rect];
            
            CGRect rect2 = self.cameraBtn.frame;
            rect2.size.width = image.size.width;
            rect2.size.height = image.size.height;
            rect2.origin.x = SCREEN_W - image.size.width-8*YAYIScreenScale-margin;
            [self.cameraBtn setFrame:rect2];
            
            CGRect rect3 = self.micBtn.frame;
            rect3.size.height = image.size.width;
            rect3.size.width = image.size.height;
            rect3.origin.x = SCREEN_W - image.size.width-8*YAYIScreenScale-margin;
            [self.micBtn setFrame:rect3];
            
                   } completion:^(BOOL finished) {
                       /*
                       [self.bgBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(bgImage.size.width, bgImage.size.height));
                       }];
                       [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
                       }];
                       [self.cameraBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
                       }];
                       [self.micBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                           make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
                       }];
                        */

        //}];
    

    }

}

#pragma mark    ======== button  点击事件 ==========

-(void)addAction:(UIButton *)sender{
    YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"通讯录导入",@"新增患者"] ];
    sheet.tag = 1001;
    [sheet show]; //  @"",@""
}
-(void)searchAction:(UIButton *)sender{

    CGFloat navH = YANavBarHeight;
    CustomSearchBar  *customSearchBar= [CustomSearchBar show:CGPointMake(0, 0) andHeight:navH];
    customSearchBar.searchResultsUpdater = self;
    customSearchBar.DataSource = self;
    customSearchBar.delegate = self;
    self.customSearchBar = customSearchBar;
    [self.navigationController.view insertSubview:customSearchBar aboveSubview:self.navigationController.navigationBar];
}



-(void)customSearchBar:(CustomSearchBar *)segment cancleButton:(UIButton *)sender {
   
    if (self.isSearched) {
         self.isSearched = false;
        if (!self.isEditting) {
            [self netRequest:false keyword:nil];
        }
        [self.dataAry removeAllObjects];
    }else{
         [self netRequest:false keyword:nil];
    }
   
    
    
   
}
- (void)customSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText {
        [self.dataAry removeAllObjects];
        self.keyWord = inputText;
        [self netRequest:false keyword:self.keyWord];
}
-(void)customSearchBegin
{
     self.isSearched = YES;
     self.isEditting = YES;
     self.isfreshed = false;
}
-(void)customSearchDidend:(NSString *)text
{
    
   
        if (!self.isSearched) {
             [self nosearchResultView:false];
             [self netRequest:false keyword:nil];
        }else{
            [self netRequest:false keyword:self.keyWord search:YES];
        }
    
    self.isEditting = false;
    self.isfreshed = YES;
}


-(void)leftBtnAction{
    
   // __weak typeof(self) weekSelf = self;
    /*
    if (self.alphaView == nil) {
        UIView *alphaView = [UIView new];
        alphaView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        alphaView.backgroundColor = YA_ALPHA_COLOR(0, 0, 0, 0.25);
        self.alphaView = alphaView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBtnAction)];
        [alphaView addGestureRecognizer:tap];
        [self.view.window addSubview:alphaView];
        
    }else{
        [self.alphaView removeFromSuperview];
        self.alphaView.hidden = YES;
        self.alphaView = nil;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        CGRect rect = self.alphaView.frame;
        rect.origin.x +=264*YAYIScreenScale;
        rect.size.width= SCREEN_W -264*YAYIScreenScale;
        self.alphaView.frame = rect;
        
    }];
    */
    if (self.alphaView == nil) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        UIView *grayView = [[UIView alloc]initWithFrame:self.mm_drawerController.centerViewController.view.bounds];
        grayView.backgroundColor = [UIColor blackColor];
        grayView.alpha = 0.5;
        [UIView beginAnimations:nil context:nil];
        //刷新数据
        [UIView commitAnimations];
        self.alphaView = grayView;
        [self.mm_drawerController.centerViewController.view addSubview:grayView];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView commitAnimations];
        [self.alphaView removeFromSuperview];
    }
    
    
    //[self.mm_drawerController showAlphaView1];
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    if (tempAppDelegate.LeftSlideVC.closed)
//    {
//        [tempAppDelegate.LeftSlideVC openLeftView];
//    }
//    else
//    {
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//    }
    
}


#pragma mark    ================ 添加标签  ==============
-(void)addTagAction:(YAMedicalModel *)model{
    __weak typeof(self) weakSelf = self;
    YATagViewController *tagView = [YATagViewController new];
    tagView.tagListAry = model.tagList;
    tagView.caseid = model.caseid;
    tagView.refreshedRow = ^{
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:model.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf netRequest:NO keyword:nil];
    };
    [self.navigationController pushViewController:tagView animated:YES];

}
-(void)detailAction:(YAMedicalModel *)model
{
    NSLog(@"%@",model.patientid);
    if (model.patientid == nil || [model.patientid integerValue] == 0) {
        
        return;
    }
    YAPatientDetailController *detailView = [YAPatientDetailController new];
    detailView.patientid = model.patientid;
    [self.navigationController pushViewController:detailView animated:YES];
    /*
    [UIView transitionWithView:self.navigationController.view
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        [self.navigationController pushViewController:detailView animated:NO];
                    }
                    completion:nil];
     */

}

-(void)clickAction:(UIButton *)sender{
    self.selectedRow = sender.tag - 1000;
    YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"选择患者",@"新增患者"] lastBtnTitle:@"删除"];
    [sheet show]; //  @"",@""
    
}
-(void)toothAction:(UIButton *)sender{
    __weak typeof (self) weakSelf = self;
    YWViewController *vc = [YWViewController new];
    YAMedicalModel *model = self.dataAry[sender.tag-2000];
    vc.caseid = model.caseid;
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:vc];
   
    vc.refreshedRow = ^{
       
        [weakSelf netRequest:false keyword:nil];
        
    };
    
    [self.tabBarController presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark ===========================

-(void)actionSheet:(YAYIActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index
{
    __weak typeof (self) weakSelf = self;
    if (actionSheet.tag == 1001) {
        
        if (index == 0) {
            YAPhoneBookController *book = [YAPhoneBookController new];
            [self.navigationController pushViewController:book animated:YES];
        }else{
            YAAddNewPatientController *view = [YAAddNewPatientController new];
            view.title = @"新增患者";
            [self.navigationController pushViewController:view animated:YES];
        }
        
       
    }else{
        if(index == 0){
            YASelectPatientController *patientView = [YASelectPatientController new];
            YAMedicalModel *model = self.dataAry[self.selectedRow];
            patientView.caseid = model.caseid;
            
            
           
            patientView.refreshedRow = ^{
                [weakSelf netRequest:false keyword:nil];
            };
            [self.navigationController pushViewController:patientView animated:YES];
        }else  if (index == 1) {
            YAAddNewPatientController *view = [YAAddNewPatientController new];
            view.title = @"新增患者";
            YAMedicalModel *model = self.dataAry[self.selectedRow];
            view.caseid = model.caseid;
             NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.selectedRow inSection:0];
            view.refreshedRow = ^{
                [weakSelf netRequest:false keyword:nil];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [self.navigationController pushViewController:view animated:YES];
        }else{
            YAMedicalModel *model = self.dataAry[self.selectedRow];
            [self deleteAction:model.caseid];
            
        }
    }

}
//删除病例

-(void)deleteAction:(NSString *)caseid{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"caseid"] = caseid;
   [YAHttpBase POST:case_delete_url parameters:param success:^(id responseObject, int code) {
       [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
       [weakSelf netRequest:false keyword:nil];
   } failure:^(NSError *error) {
       
   }];
}



#pragma mark  ======================== 发布病例  ==================
-(void)publishAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    if (sender.tag == 101) {
        YAPublishedTextController *textView = [YAPublishedTextController new];
        textView.userid = self.userid;
        textView.refreshedOperation = ^{
            [weakSelf netRequest:false keyword:nil];
        };
        [self.navigationController pushViewController:textView animated:YES];
    }else if (sender.tag == 102){
        YACameraViewController *carmera = [YACameraViewController new];
        carmera.userid = self.userid;
        carmera.refreshedOperation = ^{
            [weakSelf netRequest:false keyword:nil];
        };
        [self.navigationController pushViewController:carmera animated:YES];
    }else{
        YARecorderView *recoderView = [[YARecorderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [recoderView show];
        recoderView.userInteractionEnabled = YES;
        recoderView.opaque = false;
        recoderView.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:recoderView];
    }
}
#pragma mark =================

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:YAFont(fontSize)
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeToFit.height;
}

-(NSString *)tagStr:(NSArray *)ary{
    NSMutableString *str = [NSMutableString string];
    for (YATagsModel *model in ary) {
        [str appendString:@"| "];
        [str appendString:model.tagname];
        [str appendString:@" |"];
    }
    return str;
}
-(void)recorderFinished:(NSData *)data duration:(NSInteger)duration{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"2";
    param[@"userid"]= self.userid;
    param[@"timelong"] = @(duration);
    
    
    [[AliyunOSSObject sharedInstance] uploadRecorderObjectAsyc:nil imageData:data file:@"sdsdsds" success:^(NSString *url) {
        NSLog(@"%@",url);
        param[@"info"] = url;
        [YAHttpBase POST:case_insert_url parameters:param success:^(id responseObject, int code) {
            NSString *message = responseObject[@"message"];
            [SVProgressHUD showSuccessWithStatus:message];
            [weakSelf netRequest:false keyword:nil];
        } failure:^(NSError *error) {
            
        }];
    } fail:^(BOOL fal) {
        
    }];
    
}


-(void)getPersonInfo{
    __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:user_info_url parameters:nil success:^(id responseObject, int code) {
        NSDictionary *data = responseObject[@"data"];
        YAPersonItemModel *model = [YAPersonItemModel new];
        [model setValuesForKeysWithDictionary:data];
        NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
        [userdef setValue:model.id forKey:@"userid"];
        weakSelf.userid = model.id;
        [userdef synchronize];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark =====================
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    return YES;
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    self.keyWord = searchBar.text;
    [self netRequest:false keyword:self.keyWord];
    return YES;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.keyWord = searchBar.text;
    [self netRequest:false keyword:self.keyWord];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.keyWord = searchBar.text;
    [self netRequest:false keyword:self.keyWord];
    [self.searchBar resignFirstResponder];
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
#define mark ========== 暂定语音播放==============
-(void)playerSound:(YAMedicalModel *)model
{
    
    NSIndexPath *indexpath = model.indexPath;
    YAMedicalVoiceViewCell *cell = [self.tableView cellForRowAtIndexPath:indexpath];
    if (self.lastCell != cell) {
        self.lastCell.voiceImage.selected = false;
        [self.lastCell.voiceImage.imageView stopAnimating];
        self.lastCell = cell;
    }
}

-(void)openModelAction:(YAMedicalModel *)model
{
    NSIndexPath *indexPath = model.indexPath;
    model.isOpen = !model.isOpen;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      //[self.tableView reloadData];
}

-(CGSize)contentHeight:(NSString *)conntent{
    
    NSDictionary *attrs = @{NSFontAttributeName : YAFont(15)};
    return [conntent boundingRectWithSize:CGSizeMake(SCREEN_W -84*YAYIScreenScale -15*YAYIScreenScale, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
/**
 *  没有数据时显示
 */
- (void)showNoDataFlag:(BOOL)flag
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
        UIImageView *imageView = [[self.emptyDataView subviews] firstObject];
        imageView.image = self.isNotnet?[UIImage imageNamed:@"no_networks"]: [UIImage imageNamed:@"no_bdate"];
        return;
    }
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor whiteColor];
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH - tabH );
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
    
    imageView.image = [UIImage imageNamed:@"no_bdate"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(emptyDataView.mas_centerY);
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
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
-(void)netRequest:(BOOL)isMore keyword:(NSString *)keyWord search:(BOOL)isSearch{
    __weak typeof(self) weakSelf = self;
    NSInteger page = 1;
    if (isMore) {
        page = self.dataAry.count/10 + 1;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currentPage"] = @(page);
    param[@"keyword"] = keyWord;
    [YAHttpBase GET:case_list_url parameters:param success:^(id responseObject, int code){
        weakSelf.isNotnet = false;
        
        if (isMore) {
            weakSelf.isfreshed = false;
            if (_lastPage != page) {
                NSArray *data = responseObject[@"data"];
                for (NSDictionary *dic in data) {
                    YAMedicalModel *model = [YAMedicalModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    //YA_LOG(@"%@", model.tagList);
                    [weakSelf.dataAry addObject:model];
                }
                [weakSelf.tableView reloadData];
            }
            
        }else{
            [self.dataAry removeAllObjects];
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            weakSelf.isfreshed = YES;
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                YAMedicalModel *model = [YAMedicalModel new];
                [model setValuesForKeysWithDictionary:dic];
                //YA_LOG(@"%@", model.tagList);
                [weakSelf.dataAry addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        _lastPage = page;
        if (isSearch) {
            weakSelf.isSearched = false;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
