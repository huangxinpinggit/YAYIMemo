//
//  YAAddPatientTagActionController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/12.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddPatientTagActionController.h"
#import "YAAddPatienActionHeaderView.h"
#import "YAPatientItemSectionheaderView.h"
#import "YAPatienCell.h"
#import "YAPatientListViewController.h"
#import "BMChineseSort.h"
#import "YAAddTagListModel.h"
@interface YAAddPatientTagActionController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YAAddPatienActionHeaderViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)NSArray  *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;


@end

@implementation YAAddPatientTagActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"标签";
    UIBarButtonItem *rightItem =  [self createButton:CGRectMake(0, 0, 70, 30) image:nil title:@"保存" font:YAFont(15) fontColor:YAColor(@"#b7b7b7") tag:101];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createTableView];
}
-(void)setDataAry:(NSMutableArray *)dataAry{
    _dataAry = dataAry;
    if (_dataAry.count >0) {
        [self.saveBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    }else{
        [self.saveBtn setTitleColor:YAColor(@"#b7b7b7") forState:UIControlStateNormal];
    }
}
-(void)setPatientArray:(NSArray *)patientArray
{
    _patientArray = patientArray;
    NSMutableArray *dataAry = [NSMutableArray array];
    for (YATagPatientModel *mdel in _patientArray) {
        YAPersonModel *model = [YAPersonModel new];
        model.name = mdel.patientName;
        model.id = mdel.patientid;
        model.spell = mdel.spell;
        [dataAry addObject:model];
    }
    self.indexArray = [BMChineseSort IndexWithArray:dataAry Key:@"name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:dataAry Key:@"name"];
    [self.tableView  reloadData];
    self.dataAry =[NSMutableArray arrayWithArray:dataAry];
}
-(UIBarButtonItem *)createButton:(CGRect)rect image:(NSString*)image title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
    self.saveBtn = button;
    button.tag = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}


-(void)createTableView{
    NSInteger navH = YANavBarHeight;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YAColor(@"#f5f5f5");
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
        [self.view addSubview:_tableView];
    }
}

#pragma mark ==============================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.letterResultArr count]+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YAPatienCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAPatienCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section != 0) {
        YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section-1] count]-1) {
            cell.hLine.hidden = YES;
        }else{
            cell.hLine.hidden = false;
        }

    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return [[self.letterResultArr objectAtIndex:section-1] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51*YAYIScreenScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
         return 138*YAYIScreenScale;
    }
    
    return  35*YAYIScreenScale;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        static NSString *identifer = @"header";
        YAAddPatienActionHeaderView *header = [[YAAddPatienActionHeaderView alloc] initWithReuseIdentifier:identifer];
        if (self.tagName) {
            header.textfield.text = self.tagName;
        }
        header.delegate = self;
        header.userInteractionEnabled = YES;
        return header;
    }else{
        static NSString *identifer = @"header2";
        YAPatientItemSectionheaderView *header = [[YAPatientItemSectionheaderView alloc] initWithReuseIdentifier:identifer];
        header.titleLab.text = self.indexArray[section-1];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section >0)//是否处于编辑状态
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}
//删除cell方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YAPersonModel *model = [[self.letterResultArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
    [[self.letterResultArr objectAtIndex:indexPath.section-1]  removeObject:model];
    [self.dataAry removeObject:model];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

#pragma mark  ================================
-(void)addAction
{
    __weak typeof(self) weakSelf = self;
    YAPatientListViewController *listView = [YAPatientListViewController new];
    NSLog(@"%@",self.dataAry);
    listView.patientAry = self.dataAry;
    listView.refreshedOperation = ^(NSArray *dataAry){

        weakSelf.indexArray = [BMChineseSort IndexWithArray:dataAry Key:@"name"];
        weakSelf.letterResultArr = [BMChineseSort sortObjectArray:dataAry Key:@"name"];
        [weakSelf.tableView  reloadData];
        [weakSelf.dataAry removeAllObjects];
        
        weakSelf.dataAry = [NSMutableArray  arrayWithArray:dataAry];
        NSLog(@"%@",weakSelf.dataAry);
        NSLog(@"%@",self.letterResultArr);
    };
    [self.navigationController pushViewController:listView animated:YES];
}

#pragma mark ======================

-(void)saveAction:(UIButton *)sender{
    if (self.tagName.length == 0) {
        [NSString showInfoWithStatus:@"请填写标签名称"];
        return;
    }
    if(self.dataAry.count == 0){
        [NSString showInfoWithStatus:@"请添加患者"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"tagName"] = self.tagName;
    param[@"tagid"] = self.tagid;
    param[@"patientids"] = [self patientIDStr:self.dataAry];
    NSString *url = self.tagid == nil? insertPatientTag_url : updatePatientTag_url;
    [YAHttpBase POST:url parameters:param success:^(id responseObject, int code) {
        NSString *mesage = responseObject[@"message"];
       
        
        [SVProgressHUD showSuccessWithStatus:mesage];
        if (_refreshedOperation) {
            weakSelf.refreshedOperation();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(NSString *)patientIDStr:(NSArray *)ary{
    NSMutableString *str = [NSMutableString string];
    for (int i =0; i< ary.count; i++) {
        YAPersonModel *model = ary[i];
        NSString *patientid = [NSString stringWithFormat:@"%ld",[model.id integerValue]];
        [str appendString:patientid];
        if (i != self.dataAry.count -1) {
            [str appendString:@","];
        }
        
    }
    return str;
}
-(void)tagName:(NSString *)tagName
{
    if (tagName.length >0) {
       [self.saveBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    }else{
       [self.saveBtn setTitleColor:YAColor(@"#b7b7b7") forState:UIControlStateNormal];
    }
    
    if (tagName) {
        self.tagName = tagName;
    }
}
@end

