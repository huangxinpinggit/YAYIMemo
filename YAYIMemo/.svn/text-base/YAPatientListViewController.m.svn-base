//
//  YAPatientListViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientListViewController.h"
#import "UISearchBar+YA.h"
#import "YAPatientItemSectionheaderView.h"
#import "YAPatientSearchController.h"
#import "YAPersonModel.h"
#import "BMChineseSort.h"
#import "YAPtientListViewCell.h"
#import "YALeftTableView.h"
@interface YAPatientListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate,YAPtientListViewCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
//排序前的数组
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray  *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property (nonatomic, assign)NSInteger selectedCount;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)NSMutableArray *selectedDataArray;
@property (nonatomic, weak)YALeftTableView *leftView;
@property (nonatomic, strong)NSMutableArray *searchArray;
@end

@implementation YAPatientListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedCount = 0;
    self.selectedDataArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    UIBarButtonItem *rightItem =  [self createButton:CGRectMake(0, 0, 70, 30) image:nil title:@"保存" font:YAFont(15) fontColor:YAColor(@"#b7b7b7") tag:101];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = @"选择患者";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData:nil];
    [self createLeftListView];
    [self createLeftView];
    [self createsearchBar];
    [self createTableView];
    self.automaticallyAdjustsScrollViewInsets = false;
    
   
}
-(void)createLeftListView{
    NSInteger navH = YANavBarHeight;
    YALeftTableView *leftView = [[YALeftTableView alloc] initWithFrame:CGRectMake(0, 0, 82*YAYIScreenScale, SCREEN_H - navH)];
    [self.view addSubview:leftView];
    self.leftView = leftView;
}
-(void)setSelectedCount:(NSInteger)selectedCount
{
    _selectedCount = selectedCount;
    if (selectedCount >0) {
        [self.saveBtn setTitle:[NSString stringWithFormat:@"保存(%ld)",_selectedCount] forState:UIControlStateNormal];
        [self.saveBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    }else{
        [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.saveBtn setTitleColor:YAColor(@"#b7b7b7") forState:UIControlStateNormal];
    }
}
-(UIBarButtonItem *)createButton:(CGRect)rect image:(NSString*)image title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    self.saveBtn = button;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
    button.tag = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

-(void)createLeftView{
    UILabel *label = [UILabel new];
    label.backgroundColor = YAColor(@"#e7e7e7");
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(82*YAYIScreenScale));
        make.top.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(1, SCREEN_H));
    }];
    
}
-(void)createsearchBar{
    // 创建searchBar
    UISearchBar *searchBar = [[UISearchBar  alloc] initWithFrame:CGRectMake(83*YAYIScreenScale-1, 10*YAYIScreenScale, SCREEN_W -  83*YAYIScreenScale, 44*YAYIScreenScale)];
    searchBar.delegate = self;
    //    searchBar.showsCancelButton = YES;
    searchBar.barTintColor = [UIColor blackColor];
    [searchBar changeLeftPlaceholder:@"搜索"];
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
    [searchBar fm_setTextFont:[UIFont systemFontOfSize:15*YAYIScreenScale]];
    [self.view addSubview:searchBar];
    
    //设置光标的颜色
    searchBar.tintColor = [UIColor grayColor];
}
-(void)createTableView{
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(83*YAYIScreenScale, 64*YAYIScreenScale-1, SCREEN_W - 83*YAYIScreenScale, 1);
    label.backgroundColor = YAColor(@"#e7e7e7");
    [self.view addSubview:label];
    NSInteger navH = YANavBarHeight;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(83*YAYIScreenScale, 64*YAYIScreenScale, SCREEN_W-83*YAYIScreenScale, SCREEN_H-64*YAYIScreenScale-navH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YAColor(@"#f5f5f5");
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    
    
}
//加载模拟数据
-(void)loadData:(NSString *)keyValue{
    __weak typeof(self) weekSelf = self;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"keyValue"] = nil;
    [YAHttpBase GET:selectPatient_patient_url parameters:param success:^(id responseObject, int code) {
        //YAYI_LOG(@"%@",responseObject);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            
            YAPersonModel *model = [[YAPersonModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weekSelf.dataArray addObject:model];
        }
        [weekSelf.dataArray enumerateObjectsUsingBlock:^(YAPersonModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            for (YAPersonModel *model in weekSelf.patientAry) {
                if ([obj.id integerValue] == [model.id integerValue ]) {
                    obj.isSelected = YES;
                }
            }
        }];
        [weekSelf.selectedDataArray addObjectsFromArray:weekSelf.patientAry];
        weekSelf.selectedCount = weekSelf.selectedDataArray.count;
        weekSelf.leftView.dataAry = weekSelf.selectedDataArray;
        weekSelf.indexArray = [BMChineseSort IndexWithArray:weekSelf.dataArray Key:@"name"];
        weekSelf.letterResultArr = [BMChineseSort sortObjectArray:weekSelf.dataArray Key:@"name"];
        [weekSelf.tableView  reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ===================================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.letterResultArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YAPtientListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAPtientListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.model = model;
    cell.delegate = self;
    model.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section] count]-1) {
        cell.hLine.hidden = YES;
    }else{
        cell.hLine.hidden = false;
    }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51*YAYIScreenScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37*YAYIScreenScale;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.view endEditing:YES];
}

#pragma mark ===================== searchDelegate ======================
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
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

#pragma mark     ===================================

-(void)saveAction:(UIButton *)sender{
    if (self.refreshedOperation) {
//        if (self.patientAry.count>0 && self.selectedDataArray.count == 0) {
//            
//        }
        
        if (self.dataArray.count) {
            self.refreshedOperation(self.selectedDataArray);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)selectedRow:(YAPersonModel *)model
{
    NSIndexPath *indexPath = model.indexPath;

    model.isSelected = !model.isSelected;
    YAPtientListViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.isCanselected = model.isSelected;
    if (model.isSelected) {
        [self.selectedDataArray addObject:model];
        self.selectedCount=self.selectedCount+1;
    }else{
        NSLog(@"%@",self.selectedDataArray);
        if (self.selectedDataArray.count) {
            
           [self.selectedDataArray enumerateObjectsUsingBlock:^(YAPersonModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if ([obj.id integerValue] == [model.id integerValue]) {
                   //obj = nil;
                   [self.selectedDataArray removeObject:obj];
               }
           }];
        }
        self.selectedCount=self.selectedCount-1;
    }
    
    self.leftView.dataAry = self.selectedDataArray;

}

@end
