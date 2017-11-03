//
//  YAPatientDetailController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientDetailController.h"
#import "YAPatientdetailHeaderView.h"
#import "YAOneImageViewCell.h"
#import "YAMoreImageViewCell.h"
#import "YAVideoViewCell.h"
#import "YATextViewCell.h"
#import "YAMedicalModel.h"
#import "YADetailViewCell.h"
#import "YADetailMobileCell.h"
#import "YADetailMattersViewCell.h"
#import "YAPatientDetailModel.h"
#import <MessageUI/MessageUI.h>
#import "YAPatientDetailTagview.h"
#import "YAScheduleViewController.h"
#import "YAAddNewPatientController.h"
#import "YAYIActionSheet.h"
#import "YWViewController.h"
#import "YATagViewController.h"
#import "YAAddWXViewController.h"
@interface YAPatientDetailController ()<UITableViewDelegate,UITableViewDataSource,YADetailMobileCellDelegate,MFMessageComposeViewControllerDelegate,YAPatientdetailHeaderViewDelegate,YATextViewCellDelegate,YAVideoViewCellDelegate,YAOneImageViewCellDelegate,YAMoreImageViewCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)YAPatientDetailModel *model;
@property (nonatomic, strong)NSMutableArray *tagAry;
@property (nonatomic, weak)YAPatientDetailTagview *tagView;
@property (nonatomic, assign)NSInteger lastPage;
@property (nonatomic, strong)NSString *tagids;
@property (nonatomic, strong)NSMutableArray *casetagArrary;
@property (nonatomic, assign)NSInteger selectedRow;
@property (nonatomic, assign)NSInteger workNum;
@property (nonatomic, weak)YAVideoViewCell *lastCell;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, weak)UIView *emptyDataView;
@property (nonatomic, assign)NSUInteger isNotnet;
@end

@implementation YAPatientDetailController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)netNotReachable{
    self.isNotnet = YES;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.title = @"患者详情";
    self.dataArray = [NSMutableArray array];
    [self getDetailData];
    [self getMedicalListData:false];
    [self createTableView];
    
    
    //[self getworkNum];
    self.casetagArrary = [NSMutableArray array];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotReachable) name:@"netNotReachable" object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self ll_navigationBarFollowScrollView:self.tableView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self ll_setNavigationBarHidden:NO animated:false];
    if(_refreshedOperation){
        self.refreshedOperation();
    }
}
-(void)createTableView{
   
    NSInteger navH = YANavBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H-navH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.showsVerticalScrollIndicator = false;
//    self.tableView.contentInset = UIEdgeInsetsMake(YANavBarHeight, 0, 0, 0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YANavBarHeight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = YAYIBackgroundColor;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
    self.tableView.separatorColor = YAYICellLineColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMedicalListData:false];
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{

        [weakSelf getMedicalListData:YES];

    }];
    

}

//
-(void)getworkNum{
     NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"patientid"] =  self.patientid;
    __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:recentCalendarNum_url parameters:nil success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        weakSelf.workNum = [responseObject[@"data"] integerValue];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getDetailData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] =  self.patientid;
    [YAHttpBase GET:selectDetail_url parameters:param success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        weakSelf.isNotnet = false;
        [self.casetagArrary removeAllObjects];
        NSDictionary *map = responseObject[@"map"];
        NSDictionary *patient = map[@"patient"];
        YAPatientDetailModel *model = [YAPatientDetailModel new];
        [model setValuesForKeysWithDictionary:map];
        YAPatientInfoDetailModel *infoModel = [YAPatientInfoDetailModel new];
        [infoModel setValuesForKeysWithDictionary:patient];
        model.patient  = infoModel;
        weakSelf.model = model;
        [self.casetagArrary addObjectsFromArray:model.caseTag];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(NSError *error) {
       
    }];

}
-(void)getMedicalListData:(BOOL)isMore{
    __weak typeof(self) weekSelf = self;
    NSInteger page = 1;
    if (isMore) {
        page = self.dataArray.count/10 + 1;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"patientid"] =  self.patientid;
    param[@"currentPage"] = @(page);
    param[@"tagids"] = self.tagids;
    [YAHttpBase GET:selectPatient_url parameters:param success:^(id responseObject, int code) {
        if (isMore) {
            if (page != _lastPage) {
                NSArray *data = responseObject[@"data"];
                for (NSDictionary *dic in data) {
                    YAMedicalModel *model = [YAMedicalModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
            }
        }else{
            [self.dataArray removeAllObjects];
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                YAMedicalModel *model = [YAMedicalModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    isMore?[weekSelf.tableView.mj_footer endRefreshing]:[weekSelf.tableView.mj_header endRefreshing];
        
        _lastPage = page;
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark   ===========  tableView delegate  =============

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if(section == 2){
        return 1;
    }
    if (self.dataArray.count == 0) {
        [self showNoDataFlag:YES];
    }else{
        [self showNoDataFlag:false];
    }
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifer = @"identifer1";
        YADetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YADetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        
        return cell;
    }else if (indexPath.section == 1){
        
        static NSString *identifer = @"identifer2";
        YADetailMobileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YADetailMobileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        cell.delegate =self;
        if (indexPath.row == 0) {
            cell.type = 0;
        }else{
            cell.type = 1;
        }
        return cell;
    }else if (indexPath.section == 2){
        static NSString *identifer = @"identifer3";
        YADetailMattersViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YADetailMattersViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else{
        YAMedicalModel *model = self.dataArray[indexPath.row];
        if (model.type == 0) { //图片
            NSArray *ary = [model.info componentsSeparatedByString:@","];
            if(ary.count == 1){ // 单张图
                static NSString *identifer = @"cell1";
                YAOneImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
                if (cell == nil) {
                    cell = [[YAOneImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                cell.layer.shouldRasterize = YES;
                cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
                [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.tooth.tag = indexPath.row + 2000;
                cell.moreIcon.tag = indexPath.row + 1000;
                cell.delegate = self;
                return cell;
            }else{
                static NSString *identifer = @"cell2";
                YAMoreImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
                if (cell == nil) {
                    cell = [[YAMoreImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                cell.layer.shouldRasterize = YES;
                cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
                [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.tooth.tag = indexPath.row + 2000;
                cell.moreIcon.tag = indexPath.row + 1000;
                cell.delegate = self;
                return cell;
            }
        }else if (model.type == 1){
            static NSString *identifer = @"cell4";
            YATextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YATextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            model.indexPath = indexPath;
            cell.model = model;
            cell.isOpen = self.isOpen;
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.tooth.tag = indexPath.row + 2000;
            cell.moreIcon.tag = indexPath.row + 1000;
            
            cell.delegate = self;
            return cell;
        }else{
            static NSString *identifer = @"cell3";
            YAVideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAVideoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
            [cell.moreIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.tooth addTarget:self action:@selector(toothAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.tooth.tag = indexPath.row + 2000;
            cell.moreIcon.tag = indexPath.row + 1000;
            cell.delegate = self;
            return cell;
        
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        return [UIView new];
    }else{
        static NSString *identifer = @"cell";
        YAPatientdetailHeaderView *view = [[YAPatientdetailHeaderView alloc] initWithReuseIdentifier:identifer];
        view.delegate = self;
        view.tagView.dataAry = self.casetagArrary;
        self.tagView = view.tagView;
        return view;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section <3) {
        return 0.01;
    }
    return 136.8*YAYIScreenScale+self.tagView.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 117*YAYIScreenScale;
    }else if (indexPath.section == 1){
        return 53*YAYIScreenScale;
    }else if (indexPath.section == 2){
        return 63*YAYIScreenScale;
    }
    YAMedicalModel *model = self.dataArray[indexPath.row];
    if (model.type == 0) { //图片
        NSArray *ary = [model.info componentsSeparatedByString:@","];
        if(ary.count == 1){ // 单张图
            return 246.8*YAYIScreenScale+[model tagviewHH];
        }else{
            return 208.8*YAYIScreenScale+[model tagviewHH];
        }
    }else if (model.type == 1){
        CGFloat height = [self contentHeight:model.info].height;
        if (self.isOpen) {
            return 166.8 + [model tagviewHH] + height;
        }else{
            return 216.8+[model tagviewHH] ;
        }
    }else{
        return 194.8*YAYIScreenScale+[model tagviewHH];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        YAScheduleViewController *scheduleView = [YAScheduleViewController new];
        scheduleView.patientid = self.model.patient.id;
        scheduleView.patientName = self.model.patient.name;
        [self.navigationController pushViewController:scheduleView animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        if (self.model.patient.wx.length == 0) {
            YAAddWXViewController *wxController = [YAAddWXViewController new];
            wxController.model = self.model;
             __weak typeof(self) weakSelf = self;
            wxController.refreshedOperation = ^{
                weakSelf.model = nil;
                [weakSelf getDetailData];
            };
            [self.navigationController pushViewController:wxController animated:YES];
        }else{
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
        }
        
    }else if (indexPath.section == 0){
        __weak typeof(self) weakSelf = self;
        YAAddNewPatientController *editInfor = [YAAddNewPatientController new];
        editInfor.title = @"编辑患者";
        editInfor.patientid = self.model.patient.id;
        editInfor.refreshedRow = ^{
            weakSelf.model = nil;
            [weakSelf getDetailData];
        };
        [self.navigationController pushViewController:editInfor animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y ==-64) {
        NSArray *cells = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath * indexPath in cells) {
            if (indexPath.section == 3) {
                YAMedicalModel * model = [self.dataArray objectAtIndex:indexPath.row];
                
                YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                [cell loadImage:model];
            }
            
        }
    }
    //NSLog(@"%lf",scrollView.contentOffset.y);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        NSArray *cells = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in cells) {
            if (indexPath.section == 3) {
                YAMedicalModel * model = [self.dataArray objectAtIndex:indexPath.row];
                
                YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                [cell loadImage:model];
            }
        }
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //如果tableview停止滚动，开始加载图像
    NSArray *cells = [self.tableView indexPathsForVisibleRows];
   
    for (NSIndexPath * indexPath in cells) {
        
        if (indexPath.section == 3) {
            YAMedicalModel * model = [self.dataArray objectAtIndex:indexPath.row];
            
            YAHomeBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell loadImage:model];
        }
       
    }
    
}

#pragma mark ===================


-(void)callMobileAction:(NSString *)mobile
{
    NSString *url = [NSString stringWithFormat:@"tel://%@",mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)openWeixinAction:(NSString *)weixin{
    if (weixin != nil) {
        [UIPasteboard generalPasteboard].string =weixin;
        [self showHud:@"微信号已复制"];
    }
}
-(void)sendMessageAction:(NSString *)mobile
{
    if([MFMessageComposeViewController canSendText]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",mobile]]];//@sms://13888888888
        
//        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//        NSLog(@"%@",controller);
//        controller.recipients = @[mobile];
//        controller.navigationBar.tintColor = [UIColor redColor];
//        controller.body = nil;
//        controller.messageComposeDelegate = self;
//
//        [self.navigationController presentViewController:controller animated:false completion:nil];;
//        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"title"];
    }
   
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

#pragma mark ==========================

-(void)selectedTags:(NSString *)tagsid tagAry:(NSArray *)ary
{
    
    [self.casetagArrary enumerateObjectsUsingBlock:^(YAPatientInfoPatientTagModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (YAPatientInfoPatientTagModel *mdel in ary) {
            if ([mdel.tagid integerValue] == [obj.tagid integerValue]) {
                obj.selected = YES;
                obj = mdel;
            }
        }
    }];
    self.tagids = tagsid;
    [self getMedicalListData:false];
}
-(void)showHud:(NSString *)content{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = content;
    hud.label.font = YAFont(14);
    hud.label.numberOfLines =0;
    hud.bezelView.color= YAColor(@"#000000");
    hud.label.textColor = YAColor(@"#ffffff");
    [hud hideAnimated:YES afterDelay:2];
    [hud removeFromSuperViewOnHide];
}

#pragma mark =========================

-(void)clickAction:(UIButton *)sender{
    self.selectedRow = sender.tag - 1000;
    YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil lastBtnTitle:@"删除"];
    [sheet show]; //  @"",@""
    
}
-(void)toothAction:(UIButton *)sender{
    __weak typeof (self) weakSelf = self;
    YWViewController *vc = [YWViewController new];
    YAMedicalModel *model = self.dataArray[sender.tag-2000];
    vc.caseid = model.caseid;
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:vc];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:sender.tag-2000 inSection:0];
    vc.refreshedRow = ^{
        [weakSelf getMedicalListData:false];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    [self.tabBarController presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark ===========================

-(void)actionSheet:(YAYIActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index
{
    YAMedicalModel *model = self.dataArray[self.selectedRow];
    [self deleteAction:model.caseid];
    
}

//删除病例

-(void)deleteAction:(NSString *)caseid{
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"caseid"] = caseid;
    [YAHttpBase POST:case_delete_url parameters:param success:^(id responseObject, int code) {
        [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        [weakSelf getMedicalListData:false];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark    ================ 添加标签  ==============
-(void)addTagAction:(YAMedicalModel *)model{
    __weak typeof(self) weakSelf = self;
    YATagViewController *tagView = [YATagViewController new];
    tagView.tagListAry = model.tagList;
    tagView.caseid = model.caseid;
    tagView.refreshedRow = ^{
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:model.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        weakSelf.model = nil;
        [weakSelf getMedicalListData:false];
        [weakSelf getDetailData];
    };
    [self.navigationController pushViewController:tagView animated:YES];
}

#define mark ========== 暂定语音播放==============
-(void)playerSound:(YAMedicalModel *)model
{
    self.lastCell.voiceImage.selected = false;
    [self.lastCell.voiceImage.imageView stopAnimating];
    NSIndexPath *indexpath = model.indexPath;
    YAVideoViewCell *cell = [self.tableView cellForRowAtIndexPath:indexpath];
    self.lastCell = cell;
    
}

-(void)openModelAction:(YAMedicalModel *)model
{
    NSIndexPath *indexPath = model.indexPath;
    self.isOpen = !self.isOpen;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    emptyDataView.frame = CGRectMake(0, 0, SCREEN_W, 300*YAYIScreenScale );
    [self.tableView.tableFooterView addSubview:emptyDataView];
    self.emptyDataView = emptyDataView;
    UIImageView *imageView = [UIImageView new];
    
    imageView.image = self.isNotnet?[UIImage imageNamed:@"no_networks"]: [UIImage imageNamed:@"no_bdate"];
    [emptyDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(30*YAYIScreenScale));
        make.centerX.mas_equalTo(emptyDataView.mas_centerX);
    }];
}
@end
