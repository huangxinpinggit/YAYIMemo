//
//  YAPersonalViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPersonalViewController.h"
#import "YAPersonItemCell.h"
#import "YAPersonItemModel.h"
#import "YASettingViewController.h"
#import "YAFeedbackViewController.h"
#import "YAMessageViewController.h"
#import "YALoginViewController.h"
#import "AppDelegate.h"
#import "YABaseViewController.h"
@interface YAPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, weak)UIImageView *avaterView;
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, strong)NSMutableArray *dataAry;

@end

@implementation YAPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataAry = [NSMutableArray array];
    [self createData];
    [self createTableView];
    [self createHeaderView];
    [self createFooterView];
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self getPersonInfo];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView beginAnimations:nil context:nil];
    [UIView commitAnimations];
    for (UIView *view in self.mm_drawerController.centerViewController.view.subviews) {
        if (view.alpha == 0.5) {
            [view removeFromSuperview];
            break;
        }
    }
   
}
-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 264*YAYIScreenScale, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#252525"];
    
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    

}

-(void)createHeaderView{
    UIView *view = [UIView new];
    
    view.frame = CGRectMake(0, 0, 264*YAYIScreenScale, 230*YAYIScreenScale);
    self.headerView = view;
    self.tableView.tableHeaderView = view;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"default_person_avatar"];
    [imageView zy_attachBorderWidth:2*YAYIScreenScale color:[UIColor colorWithHexString:@"#4b4b4b"]];
   
    [imageView zy_cornerRadiusAdvance:40*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [view addSubview:imageView];
    self.avaterView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32*YAYIScreenScale));
        make.centerX.mas_equalTo(view.mas_centerX);
        //.offset(-15*YAYIScreenScale);
        make.height.equalTo(@(80*YAYIScreenScale));
        make.width.equalTo(@(80*YAYIScreenScale));
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    nameLab.text = @"未知";
    nameLab.textColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [view addSubview:nameLab];
    self.nameLab = nameLab;
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        //.offset(-15*YAYIScreenScale);
   make.top.mas_equalTo(imageView.mas_bottom).offset(20*YAYIScreenScale);
        make.height.equalTo(@30);
    }];
}

-(void)createFooterView{
    UIView *view  = [UIView new];
    view.frame = CGRectMake(0, 0, 264*YAYIScreenScale, 260*YAYIScreenScale);
    view.backgroundColor = [UIColor colorWithHexString:@"#252525"];
    self.tableView.tableFooterView = view;
   
    UIImage *image = [UIImage imageNamed:@"exit"];
    UIImageView *imageView = [UIImageView new];
    imageView.image = image;
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(74*YAYIScreenScale));
        make.bottom.mas_equalTo(view.mas_bottom).offset(-174*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(image.size.width , image.size.height));
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#b8b8b8"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(24*YAYIScreenScale);
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    

}
-(void)createData{
    NSArray *titleAry = @[@"反馈",@"设置"];
    NSArray *imageAry = @[@"edit_icon",@"set"];
    for (int  i = 0; i < titleAry.count; i++) {
        YAPersonItemModel *model = [YAPersonItemModel new];
        model.title = titleAry[i];
        model.image = imageAry[i];
        [self.dataAry addObject:model];
    }
    [self.tableView reloadData];

}

#pragma mark ========================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifer";
    YAPersonItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAPersonItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.model = _dataAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataAry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        

        
//        YAYINavigationController *leftNav = [[YAYINavigationController alloc] initWithRootViewController:setView];
       // [self presentViewController:leftNav animated:YES completion:nil];
        
        YASettingViewController *setView = [YASettingViewController new];
        UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
        NSArray *arr = nav.viewControllers;
        [arr[0] pushViewController:setView animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];;
        
    }else if (indexPath.row == 0){
//        YAFeedbackViewController *feedback= [YAFeedbackViewController new];
//        YAYINavigationController *leftNav = [[YAYINavigationController alloc] initWithRootViewController:feedback];
//        [self presentViewController:leftNav animated:YES completion:nil];
       
         YAFeedbackViewController *feedback= [YAFeedbackViewController new];
        UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
        NSArray *arr = nav.viewControllers;
        [arr[0] pushViewController:feedback animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
//    }else{
//        YAMessageViewController *message = [YAMessageViewController new];
//        YAYINavigationController *leftNav = [[YAYINavigationController alloc] initWithRootViewController:message];
//        [self presentViewController:leftNav animated:YES completion:nil];
//    }
}
#pragma mark ===========================

-(void)getPersonInfo{
    __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:user_info_url parameters:nil success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        NSDictionary *data = responseObject[@"data"];
        YAPersonItemModel *model = [YAPersonItemModel new];
        [model setValuesForKeysWithDictionary:data];
        [[SDImageCache sharedImageCache] removeImageForKey:model.avatar];
        
        [[NSUserDefaults standardUserDefaults] setValue:model.mobile forKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults] setValue:model.avatar forKey:@"avatar"];
        [weakSelf.avaterView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_person_avatar"]];
        weakSelf.nameLab.text = model.name;
    } failure:^(NSError *error) {
        
    }];

}

-(void)loginOut:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    YABaseViewController *baseView = [YABaseViewController new];
    [YAHttpBase POST:logout_url  parameters:nil success:^(id responseObject, int code) {
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (int i = 0;  i < cookieJar.cookies.count; i++) {
            
            NSHTTPCookie *cookie = [cookieJar cookies][i];
            [cookieJar deleteCookie:cookie];
        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:YALoginCookieKey];
        
        YALoginViewController *loginView = [YALoginViewController new];
        loginView.loginSuccessOperation = ^{
            [baseView freshedData];
        };
        
        [weakSelf presentViewController:loginView animated:false completion:nil];
        
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    } failure:^(NSError *error) {
        
    }];
}
@end
