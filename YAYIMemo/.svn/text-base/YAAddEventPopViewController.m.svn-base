//
//  YAAddEventPopViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/6.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddEventPopViewController.h"
#import "YAAddEventTimeHeaderview.h"
#import "YAAddEventContentHeaderView.h"
#import "YAAddEventRepeatHeaderView.h"
#import "YAAddEventContentCell.h"
#import "YAAddEventSelectPatientCell.h"
#import "YAAddEventTimeCell.h"
#import "YAAddEventRepeatCell.h"
#import "YASelectPatientController.h"

@interface YAAddEventPopViewController ()<UITableViewDelegate,UITableViewDataSource,YAAddEventTimeCellDelegate,YAAddEventRepeatCellDelegate,YAAddEventContentCellDelegate>
@property (nonatomic, weak)UIView *contenView;
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, assign)BOOL isSelectedTime;
@property (nonatomic, assign)BOOL isRepeat;
@property (nonatomic, strong)NSArray *dataAry;
@property (nonatomic, strong)NSString *timeStr;
@property (nonatomic, weak)YAAddEventTimeHeaderview *timeHeaderView;
@property (nonatomic, weak)YAAddEventRepeatHeaderView *repeatHeaderView;
@property (nonatomic, weak)NSString *repeatStr;
@property (nonatomic, strong)NSString *patientName;
@property (nonatomic, strong)NSString *patientid;
@property (nonatomic, strong)NSString *eventString;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, weak)UIButton *saveBtn;
@property (nonatomic, strong)NSString *defaultDate;
@property (nonatomic, strong)NSString *defaultTime;
@property (nonatomic, strong)NSString *repeatCount;
@end

@implementation YAAddEventPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.patientid = @"0";
    _dataAry = @[@"永不"];//@"每天",@"每周",@"每年"
    self.repeatCount = @"0";
    self.view.backgroundColor = YA_ALPHA_COLOR(0, 0, 0, 0.25);
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    contentView.layer.shadowOffset = CGSizeMake(1, 1);
    [self.view addSubview:contentView];
    self.contenView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(72);
        make.height.equalTo(@(335*YAYIScreenScale));
        make.width.equalTo(@(345*YAYIScreenScale));
    }];
    [self createHeaderView];
    [self createTableView];
}

-(NSString *)defaultDate
{
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    formatter.timeZone = zone;
    return [formatter stringFromDate:date];
}
-(NSString *)defaultTime
{
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    formatter.dateFormat = @"HH:mm";
    formatter.timeZone = zone;
    return [formatter stringFromDate:date];
}
-(void)createHeaderView{
    
    UIImage *image = [UIImage imageNamed:@"s_Bback"];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.contenView addSubview:view];
    self.headerView = view;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:backBtn];
    
    UILabel *label = [UILabel new];
    label.text = @"添加事项";
    label.textColor = YABlack_color;
    label.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    self.saveBtn = saveBtn;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:saveBtn];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [view addSubview:hLine];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 41*YAYIScreenScale));
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(image.size.width + 16*YAYIScreenScale,image.size.height+10));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 15*YAYIScreenScale));
    }];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-8*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(40, 30*YAYIScreenScale));
    }];
    
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(345*YAYIScreenScale, 1*YAYIScreenScale));
    }];
    
}
-(void)createTableView{
    if (self.tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,41*YAYIScreenScale, 345*YAYIScreenScale,304*YAYIScreenScale) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = false;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contenView addSubview:tableView];
        self.tableView = tableView;
    }

}

#pragma mark ======================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        static NSString *identifer = @"cell1";
        YAAddEventTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YAAddEventTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *identifer = @"cell2";
            YAAddEventContentCell*cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAAddEventContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1){
            static NSString *identifer = @"cell3";
            YAAddEventSelectPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAAddEventSelectPatientCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
            }
            if (self.name) {
                cell.button.hidden = YES;
                cell.nameLab.text = self.name;
            }else{
                cell.button.hidden = false;
                cell.nameLab.text = self.patientName;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
       
    }
   static NSString *identifer = @"cell4";
    YAAddEventRepeatCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YAAddEventRepeatCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    if (indexPath.row == 0) {
        cell.selected = YES;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLab.text = _dataAry[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.isSelectedTime) {
            return 1;
        }
        return 0;
    }else if (section == 1){
        return 2;
    }else {
        if (self.isRepeat) {
            return 4;
        }
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 104*YAYIScreenScale;
        }else{
            return 41*YAYIScreenScale;
        }
    }else if (indexPath.section == 2){
        return 41*YAYIScreenScale;
    }
    return 41*5*YAYIScreenScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        static NSString *header = @"header1";
        YAAddEventTimeHeaderview *hederView = [[YAAddEventTimeHeaderview alloc] initWithReuseIdentifier:header];
        self.timeHeaderView = hederView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAction:)];
        [hederView addGestureRecognizer:tap];
        return hederView;
    }else if (section == 1){
        static NSString *header2 = @"header2";
        YAAddEventContentHeaderView *hederView =[[YAAddEventContentHeaderView alloc] initWithReuseIdentifier:header2];
        return hederView;
    }else{
        static NSString *header3 = @"header3";
        YAAddEventRepeatHeaderView *hederView3 =[[YAAddEventRepeatHeaderView alloc] initWithReuseIdentifier:header3];
        self.repeatHeaderView = hederView3;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repeatAction:)];
//        [hederView3 addGestureRecognizer:tap];
        return hederView3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41*YAYIScreenScale;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        if (self.name) {
            return;
        }
        YASelectPatientController *patientView = [YASelectPatientController new];
        YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:patientView];
        __weak typeof(self) weakSelf = self;
        patientView.isPresent = YES;
        patientView.selectedPatientBlock = ^(NSString *patientid,NSString *name){
            weakSelf.patientid = patientid;
            weakSelf.patientName = name;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        };
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma  mark ==================

//当键盘出现或改变时调用
//- (void)keyboardWillShow:(NSNotification *)aNotification
//{
//    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    int height = keyboardRect.size.height;
//    
//    if (self.isRepeat) {
//         self.isRepeat = false;
//         [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    
//    if (self.isSelectedTime) {
//        self.isSelectedTime = false;
//         [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
////    [self.view endEditing:YES];
////    [self.view endEditing:false];
//    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-(height-64-23-72));
//    }];
//    self.repeatHeaderView.repeatStr = self.repeatStr;
//    self.timeHeaderView.timeStr = self.timeStr;
//    
//}
//
//当键退出时调用
//- (void)keyboardWillHide:(NSNotification *)aNotification{
//    if (self.isSelectedTime) {
//        return;
//    }else if (self.isRepeat){
//        return;
//    }
//    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.view.mas_centerY).offset(72);
//        make.height.equalTo(@(335*YAYIScreenScale));
//    }];
//    CGRect rect = self.tableView.frame;
//    rect.size.height=(304*YAYIScreenScale);
//    [self.tableView setFrame:rect];
//}
//
#pragma mark ====================

-(void)setIsSelectedTime:(BOOL)isSelectedTime
{
    _isSelectedTime = isSelectedTime;
    if (_isSelectedTime) {
        [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.height.equalTo(@(335*YAYIScreenScale + 41*5*YAYIScreenScale));
        }];
        CGRect rect = self.tableView.frame;
        rect.size.height=(41*5*YAYIScreenScale+304*YAYIScreenScale);
        [self.tableView setFrame:rect];
    }else{
        [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(72);
            make.height.equalTo(@(335*YAYIScreenScale));
        }];
        CGRect rect = self.tableView.frame;
        rect.size.height=(304*YAYIScreenScale);
        [self.tableView setFrame:rect];
    }
}

-(void)setIsRepeat:(BOOL)isRepeat
{
    _isRepeat = isRepeat;
    if (_isRepeat) {
        [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.height.equalTo(@(335*YAYIScreenScale + 41*4*YAYIScreenScale));
        }];
        CGRect rect = self.tableView.frame;
        rect.size.height=(41*4*YAYIScreenScale+304*YAYIScreenScale);
        [self.tableView setFrame:rect];
    }else{
        [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(72);
            make.height.equalTo(@(335*YAYIScreenScale));
        }];
        CGRect rect = self.tableView.frame;
        rect.size.height=(304*YAYIScreenScale);
        [self.tableView setFrame:rect];
    }
}

-(void)selectedAction:(UITapGestureRecognizer *)tap{
    // 退出键盘
    [self.view endEditing:YES];
    if (!self.isSelectedTime) {
        
        if (self.isRepeat) {
             self.isRepeat = false;
             [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        self.isSelectedTime = true;
    }else{
        self.isSelectedTime = false;
        
       
    }
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.timeHeaderView.timeStr = self.timeStr;
    self.repeatHeaderView.repeatStr = self.repeatStr;
    
}
-(void)repeatAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
    // 退出键盘
    if (!self.isRepeat) {
        
        if (self.isSelectedTime) {
            self.isSelectedTime = false;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        self.isRepeat = true;
    }else{
        self.isRepeat = false;
    }
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.repeatHeaderView.repeatStr = self.repeatStr;
    self.timeHeaderView.timeStr = self.timeStr;

}


-(void)timeWithHour:(NSString *)hour minute:(NSString *)min
{
    /*
    NSString *dateString = [NSString stringWithFormat:@"%@ %@:%@:%@",self.datestr,hour,min,@"00"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    
    NSTimeInterval a = [date timeIntervalSince1970];
    self.time = [NSString stringWithFormat:@"%.lf",a];
     */
   
   
    self.timeStr = [NSString stringWithFormat:@"%@:%@",hour,min];
    
    self.timeHeaderView.timeStr = self.timeStr;
    [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    if (self.datestr == nil) {
        self.time = [self timeStamp:self.datestr timestr:self.timeStr];
    }else{
        self.time = [self timeStamp:self.datestr timestr:self.timeStr];
    }

    
}

-(void)repeatEvent:(NSString *)repeat isSelected:(BOOL)isSelected
{
   
    if ([repeat isEqualToString:@"永不"]) {
        self.repeatCount = @"0";
    }else if ([repeat isEqualToString:@"每天"]){
        self.repeatCount = @"1";
    }else if ([repeat isEqualToString:@"每周"]){
        self.repeatCount = @"2";
    }else if ([repeat isEqualToString:@"每年"]){
        self.repeatCount = @"3";
    }
    self.repeatStr = repeat;
    self.repeatHeaderView.repeatStr = repeat;
    [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];

    
    
}

-(void)eventcontent:(NSString *)str
{
    self.eventString = str;
    [self.saveBtn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    
}

-(void)saveAction:(UIButton *)sender{
    if (self.timeStr == nil && self.datestr != nil) {
        self.time = [self timeStamp:self.datestr timestr:self.defaultTime];
    }else if (self.timeStr ==nil && self.datestr == nil){
        self.time = [self timeStamp:self.defaultDate timestr:self.defaultTime];
    }
    if (self.time.length == 0) {
        [NSString showInfoWithStatus:@"请选择时间"];
        return;
    }
    if (self.eventString.length == 0) {
        [NSString showInfoWithStatus:@"请填写事项"];
        return;
    }
    if (self.patientid == nil) {
        [NSString showInfoWithStatus:@"请选择患者"];
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    param[@"patientid"] = self.patientid;
    param[@"worktime"] = self.time;
    param[@"items"] = self.eventString;
    param[@"repetition"] = self.repeatCount;
    
    [YAHttpBase POST:addCalendarInfo_url parameters:param success:^(id responseObject, int code) {

            NSString *message = responseObject[@"message"];
            [SVProgressHUD showSuccessWithStatus:message];
            [self dismissViewControllerAnimated:NO completion:nil];
        if (_refreshedOperation) {
            _refreshedOperation();
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:false completion:nil];
}

-(NSString *)timeStamp:(NSString *)dateStr timestr:(NSString *)time{
    NSLog(@"%@",time);
    NSString *dateString = [NSString stringWithFormat:@"%@ %@:%@",dateStr,time,@"00"];
    NSLog(@"%@",dateString);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    
    NSTimeInterval a = [date timeIntervalSince1970];
    self.time = [NSString stringWithFormat:@"%.lf",a];
     NSLog(@"%@",self.time);
    return [NSString stringWithFormat:@"%.lf",a];
}

@end
