//
//  YAPhoneBookController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/24.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPhoneBookController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "YABookModel.h"
#import "YAPatientItemSectionheaderView.h"
#import "YAPersonModel.h"
#import "BMChineseSort.h"
#import "YABookViewCell.h"
@interface YAPhoneBookController ()<CNContactPickerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YABookViewCellDelegate>
@property (nonatomic, strong)NSMutableArray *dataArry;
@property (nonatomic, strong)NSMutableArray *letterResultArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *indexArray;
@property (nonatomic, strong)NSMutableArray *patientAry;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)NSString  *keyword;
@property (nonatomic, assign)BOOL isSearch;
@property (nonatomic, strong)NSMutableArray *searchAry;
@property (nonatomic, strong)UIView *alphView;
@end

@implementation YAPhoneBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
   
    
    
    self.dataArry = [NSMutableArray array];
    self.searchAry = [NSMutableArray array];
    self.title = @"通讯录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getBookData];
    [self createTableView];
    [self loadData:nil];
    [self createSearchBar];
    
    
    [self createAlphView];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.searchBar resignFirstResponder];
    self.searchBar.hidden = YES;
    
    UIButton *searchBtn = self.navigationItem.rightBarButtonItem.customView;
    searchBtn.selected = NO;
    if (self.refreshedBlock) {
        self.refreshedBlock();
    }
}

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

-(void)createTableView{
    CGFloat navH = YANavBarHeight;
    if (self.tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-navH) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        self.tableView.sectionIndexColor = [UIColor colorWithHexString:@"#4d4d4d"];
        self.tableView.backgroundColor = YAYIBackgroundColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }

}
-(void)getBookData{
    
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"授权成功");
                // 2. 获取联系人仓库
                CNContactStore * store = [[CNContactStore alloc] init];
                
                // 3. 创建联系人信息的请求对象
                NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
                
                // 4. 根据请求Key, 创建请求对象
                CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                
                // 5. 发送请求
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                        
                        // 6.1 获取姓名
                        YABookModel *model = [YABookModel new];
                         model.name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                        
                        // 6.2 获取电话
                        NSArray *phoneArray = contact.phoneNumbers;
                        for (CNLabeledValue *labelValue in phoneArray) {
                            
                            CNPhoneNumber *number = labelValue.value;
                            model.phoneNumber = number.stringValue;
                            NSLog(@"%@--%@", number.stringValue, labelValue.label);
                        }
                        [self.dataArry addObject:model];
                        
                    }];
                
                [self loadData:nil];
            } else {
                NSLog(@"授权失败");
            }
        }];
        
    }else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"授权成功");
                // 2. 获取联系人仓库
                CNContactStore * store = [[CNContactStore alloc] init];
                
                // 3. 创建联系人信息的请求对象
                NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
                
                // 4. 根据请求Key, 创建请求对象
                CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                
                // 5. 发送请求
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    // 6.1 获取姓名
                    YABookModel *model = [YABookModel new];
                    model.name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                    // 6.2 获取电话
                    NSArray *phoneArray = contact.phoneNumbers;
                    for (CNLabeledValue *labelValue in phoneArray) {
                        
                        CNPhoneNumber *number = labelValue.value;
                        model.phoneNumber = number.stringValue;
                        
                        NSLog(@"%@", number.stringValue);
                    }
                    [self.dataArry addObject:model];
                }];
            } else {
                NSLog(@"授权失败");
            }
        }];
    
    }

}


-(void)loadData:(NSString *)keyValue{
    
    __weak typeof(self) weekSelf = self;
    self.patientAry = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"keyValue"] = nil;
    [YAHttpBase GET:selectPatient_patient_url parameters:param success:^(id responseObject, int code) {
        [weekSelf.patientAry removeAllObjects];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            
            YAPersonModel *model = [[YAPersonModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weekSelf.patientAry addObject:model];
        }
        
        [weekSelf.dataArry enumerateObjectsUsingBlock:^(YABookModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (YAPersonModel *model in weekSelf.patientAry) {
                if ([model.mobile isEqualToString:obj.phoneNumber]) {
                    obj.isExit =YES;
                    obj.avatar = model.avatar;
                }
            }
        }];
        
        self.indexArray = [BMChineseSort IndexWithArray:self.dataArry Key:@"name"];
        self.letterResultArr = [BMChineseSort sortObjectArray:self.dataArry Key:@"name"];
        
        [weekSelf.tableView  reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ================================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return 1;
    }
    return self.indexArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *identifer = @"identifer";
    YABookViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];;
    if (cell == nil) {
        cell = [[YABookViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.delegate = self;
    if (!self.isSearch) {
        YABookModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == [[self.letterResultArr objectAtIndex:indexPath.section] count]-1) {
            cell.hLine.hidden = YES;
        }else{
            cell.hLine.hidden = false;
        }
    }else{
        YABookModel *model = self.searchAry[indexPath.row];
        cell.model = model;
        if (indexPath.row == self.searchAry.count- 1) {
            cell.hLine.hidden = YES;
        }else{
            cell.hLine.hidden = false;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 51*YAYIScreenScale;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return self.searchAry.count;
    }
    return [[self.letterResultArr objectAtIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.isSearch) {
        return @[];
    }
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return [UIView new];
    }
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
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // 判断是否进行了搜索
    if (self.isSearch) {
        return 0.01;
    }
    return 35.0*YAYIScreenScale;
}

#pragma mark =====================
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.letterResultArr removeAllObjects];
    [self.indexArray removeAllObjects];
    [self.searchAry removeAllObjects];
    self.isSearch = YES;
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    return YES;
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchAry removeAllObjects];
    if (searchBar.text.length == 0) {
        
        self.keyword = nil;
        [self loadData:nil];
    }else{
        if (!self.alphView.hidden) {
            self.alphView.hidden = YES;
            [self.alphView removeFromSuperview];
            self.alphView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 0);
        }
        self.keyword = searchBar.text;
        
        
        for (YABookModel *model in self.dataArry) {
            if([model.phoneNumber containsString:searchBar.text])
            {
                [self.searchAry addObject:model];
            }else if ([model.name containsString:searchBar.text]){
                [self.searchAry addObject:model];
            }
        }
        [self.tableView reloadData];
    }
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchBar.text.length == 0) {
        [self loadData:nil];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    
    [searchBar resignFirstResponder];
    [self.searchAry removeAllObjects];
    if (searchBar.text.length == 0) {
        
        self.keyword = nil;
        [self loadData:nil];
    }else{
        
        self.keyword = searchBar.text;
    
        for (YABookModel *model in self.dataArry) {
            if([model.phoneNumber containsString:searchBar.text])
            {
                [self.searchAry addObject:model];
            }else if ([model.name containsString:searchBar.text]){
                [self.searchAry addObject:model];
            }
        }
        [self.tableView reloadData];
    }
    
}


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
        
        self.searchBar.hidden = YES;
        self.searchBar.text = nil;
        self.keyword = nil;
        [self.searchBar resignFirstResponder];
        self.isSearch = false;
        [self.searchAry removeAllObjects];
        [self loadData:nil];
       
    }

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

-(void)addPatient:(YABookModel *)model
{
   
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = model.name;
    param[@"mobile"] = model.phoneNumber;
    __weak typeof(self) weakSelf = self;
    [YAHttpBase POST:patient_insert_url parameters:param success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        NSString *message =  responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        if (weakSelf.isSearch) {
            [weakSelf.searchAry removeAllObjects];
        }
        YAPersonModel *mdel = [YAPersonModel new];
        mdel.name = model.name;
        mdel.mobile = model.phoneNumber;
        mdel.id = [NSString stringWithFormat:@"%ld",[responseObject[@"data"] integerValue]];
        [[YAFMDBDatabases sharedInstance] updateDatabases:mdel];
        [weakSelf loadData:nil];
    } failure:^(NSError *error) {
        
    }];
}
-(void)createAlphView{
//    self.alphView = [UIView new];
//    self.alphView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 0);
//    self.alphView.backgroundColor = YA_ALPHA_COLOR(0, 0, 0, 0.35);
//    self.alphView.hidden = YES;
//    self.navigationController.view.backgroundColor = [UIColor orangeColor];
//    [self.navigationController.view  addSubview:self.alphView];
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (!self.alphView.hidden) {
        return;
    }
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
   ;
    self.alphView.hidden = false;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rect = self.alphView.frame;
        rect.origin.y-=(SCREEN_H - 64);
        rect.size.height +=(SCREEN_H - height - 64);
        self.alphView.frame = rect;
        NSLog(@"%@",self.alphView);
    }];
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    if (self.alphView.hidden) {
        return;
    }
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rect = self.alphView.frame;
        rect.origin.y+=(SCREEN_H - 64);
        rect.size.height-=(SCREEN_H - height - 64);
        self.alphView.frame = rect;
    } completion:^(BOOL finished) {
        self.alphView.hidden = YES;
    }];
}
@end
