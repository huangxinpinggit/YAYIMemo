//
//  YAPatientSearchController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientSearchController.h"
#import "YASelectedTagView.h"
#import "YAPersonModel.h"
#import "YAAddTagListModel.h"
@interface YAPatientSearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)BOOL isInput;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, weak)YASelectedTagView *selectedTagView;
@property (nonatomic, strong)NSMutableArray *tagAry;

@end

@implementation YAPatientSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagAry = [NSMutableArray array];
    self.navigationItem.title = @"选择患者";
    self.view.backgroundColor = [UIColor whiteColor];

    [self createsearchBar];
    [self createTableView];
    [self createSelectedTagView];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedTagView removeFromSuperview];
}
-(void)createTableView{
    if (_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.showsVerticalScrollIndicator = false;
        [self.view addSubview:_tableView];
    }

}

-(void)createSelectedTagView{
    YASelectedTagView *selectedView = [[YASelectedTagView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - 64)];
    [[UIApplication sharedApplication].keyWindow addSubview:selectedView];
   
    self.selectedTagView = selectedView;
    [self requestNet];
}


-(void)createsearchBar{
    // 创建searchBar
    UISearchBar *searchBar = [[UISearchBar  alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
    searchBar.delegate = self;
    //    searchBar.showsCancelButton = YES;
    searchBar.barTintColor = [UIColor blackColor];
    searchBar.placeholder = @"搜索";
    
    // 修
    
    //修改标题和标题颜色
    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex : 0] removeFromSuperview];
    
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:28];  //YAYIColor(220, 220, 220)//YAYIBackgroundColor
    //设置背景图片
    [searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    //    [searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    [self.view addSubview:searchBar];
    //设置光标的颜色
    searchBar.tintColor = [UIColor grayColor];
    self.searchBar = searchBar;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:false];
    //[self.searchBar becomeFirstResponder];
    
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark  =======================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark =========================



#pragma mark =====================

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

-(void)requestNet{
    
    __weak typeof(self) weakSelf = self;
    
    [YAHttpBase GET:selectPatientTag_patient_url parameters:nil success:^(id responseObject, int code) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YAAddTagListModel *model = [YAAddTagListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.tagAry addObject:model];
        }
        weakSelf.selectedTagView.dataAry = self.tagAry;
    } failure:^(NSError *error) {
        
    }];
}

@end
