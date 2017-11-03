//
//  YAAddNewPatientController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientController.h"
#import "YAAddNewPatientHeaderView.h"
#import "YAAddNewPatientViewCell.h"
#import "YAAddNewPatientTagViewCell.h"
#import "YAAddNewPatientFooterView.h"
#import "YAYIActionSheet.h"
#import "AliyunOSSObject.h"
#import "YAPatientDetailModel.h"
#import "NSString+YA.h"
@interface YAAddNewPatientController ()<UITableViewDelegate,UITableViewDataSource,YAAddNewPatientViewCellDelegate,YAAddNewPatientTagViewCellDelegate,YAAddNewPatientFooterViewDelegate,YAAddNewPatientHeaderViewDelegate,YAYIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)UIImageView *avatarView;
@property (nonatomic, strong)NSString *gender;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *age;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *avater;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)NSMutableArray *dataTagAry;
@property (nonatomic, assign)NSInteger keyboardHeight;
@property (nonatomic, weak)YAAddNewPatientFooterView *footer;
@property (nonatomic, weak)YAAddNewPatientHeaderView *header;
@property (nonatomic, weak)YAAddNewPatientTagViewCell *cell;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)NSMutableArray *tagListAry;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, assign)NSInteger seletedIndex;
@property (nonatomic, strong)NSString *tag_name;
@property (nonatomic, strong)NSString *tagid;
@property (nonatomic, strong)NSString *wx;
@property (nonatomic, strong)YAPatientDetailModel *model;
@property (nonatomic, strong)NSMutableArray *patientTagsArray;
@property (nonatomic, assign)BOOL isEditing;;
@end

@implementation YAAddNewPatientController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set default value 2
    self.patientTagsArray = [NSMutableArray array];
    self.seletedIndex = 2;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [button setTitleColor:[UIColor colorWithHexString:@"#b7b7b7"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 20);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    
    self.dataAry = [NSMutableArray array];
    self.dataTagAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self loadData];
    [self netRequest];
    [self getDetailData];
    
    
    
}

-(void)getDetailData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] =  self.patientid;
    [YAHttpBase GET:selectDetail_url parameters:param success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        NSDictionary *map = responseObject[@"map"];
        NSDictionary *patient = map[@"patient"];
        YAPatientDetailModel *model = [YAPatientDetailModel new];
        [model setValuesForKeysWithDictionary:map];
        YAPatientInfoDetailModel *infoModel = [YAPatientInfoDetailModel new];
        [infoModel setValuesForKeysWithDictionary:patient];
        model.patient  = infoModel;
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    //增加监听，当键盘出现或改变时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
//    
//    //增加监听，当键退出时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)createTableView{
    CGFloat navH = YANavBarHeight;
    if (self.tableView == nil) {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-navH) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 54;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    [self.view addSubview:self.tableView];
   }
}
-(void)loadData{
    NSArray *titleAry = @[@"患者姓名",@"年龄",@"手机号",@"微信",@"标签"];
    NSArray *placherAry = @[@"填写姓名",@"填写年龄",@"填写手机号码",@"请输入微信号码",@""];
    
    for (int i = 0; i < titleAry.count; i++) {
        YAAddNewPatientModel *model = [YAAddNewPatientModel new];
        model.name = titleAry[i];
        model.placher = placherAry[i];
        
        [self.dataAry addObject:model];
    }
    [self.tableView reloadData];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 4) {
        static NSString *identifer = @"identifer";
        YAAddNewPatientViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YAAddNewPatientViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YAAddNewPatientModel *model = self.dataAry[indexPath.row];
        cell.titleLab.text = model.name;
        cell.delegate = self;
        cell.contentText.tag = 1000+indexPath.row;
        cell.contentText.placeholder = model.placher;
        cell.model = self.model;
        return cell;
    }else{
       
        static NSString *identifer = @"identifer1";
        YAAddNewPatientTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YAAddNewPatientTagViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        }
        self.cell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        YAAddNewPatientModel *model = self.dataAry[indexPath.row];
        cell.titleLab.text = model.name;
        if (self.model.patientTag != nil) {
            cell.tagView.dataAry = self.model.patientTag;
        }
        
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4 && _cellHeight > 54*YAYIScreenScale) {
        return _cellHeight;
    }
    return 54*YAYIScreenScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"identifer";
    YAAddNewPatientHeaderView *header = [[YAAddNewPatientHeaderView alloc] initWithReuseIdentifier:identifer];
    header.delegate = self;
    self.header = header;
    
    header.avatar.image = self.image;
    header.segment.selectedSegmentIndex = self.seletedIndex;
    [header.camera addTarget:self action:@selector(openCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    header.model = self.model;
    return header;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 202*YAYIScreenScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *identifer = @"identifer1";
    YAAddNewPatientFooterView *footer = [[YAAddNewPatientFooterView alloc] initWithReuseIdentifier:identifer];
    footer.delegate = self;

    footer.tagView.dataAry = self.dataTagAry;
    self.footer = footer;
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.footer.tagView.height > 40*YAYIScreenScale) {
        return self.footer.tagView.height+ 48*YAYIScreenScale+20;
    }
    return 48*YAYIScreenScale + 140*YAYIScreenScale;
}
// 获取所有标签

-(void)netRequest{
    __weak typeof(self)  weakSelf = self;
    [YAHttpBase GET: add_patients_selectBaseTag parameters:@{@"type":@"2"} success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        NSArray *data = responseObject[@"data"];
        weakSelf.dataTagAry = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YAPatientInfoPatientTagModel  *model = [YAPatientInfoPatientTagModel  new];
            model.tagid = dic[@"id"];
            model.tagName = dic[@"name"];
            [weakSelf.dataTagAry addObject:model];
        }
        weakSelf.footer.tagView.dataAry = weakSelf.dataTagAry;
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.keyboardHeight = height;
    
}
-(void)keyboardWillHide:(NSNotification *)aNotification{

}
#pragma  mark ======================



#pragma mark =======================   cell delegate =====

-(void)nextAction:(NSInteger)tag
{
 

    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForRow:(tag+1-1000) inSection:0];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:nextIndexPath];
    UITextField *text = [cell viewWithTag:tag+1];
    [text becomeFirstResponder];
}

#pragma mark =============================  editTagView ========



-(void)updateCellHeight:(CGFloat)height
{
    self.cellHeight = height;

}
-(void)updateData:(YAPatientInfoPatientTagModel  *)model
{

    model.selected = false;
    model.deleted = false;
    [self.dataTagAry enumerateObjectsUsingBlock:^(YAPatientInfoPatientTagModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
     if (obj.tagid  == model.tagid) {
            [self.dataTagAry replaceObjectAtIndex:idx withObject:model];
        }
    
    }];
    
    self.footer.tagView.dataAry = self.dataTagAry;
}

-(void)tagName:(NSString *)tagname tag_id:(NSString *)tagid
{
    self.tag_name = tagname;
    self.tagid = tagid;
}

#pragma mark ========================   tagView delegate ========

-(void)selectTagName:(YAPatientInfoPatientTagModel  *)model
{
    self.cell.tagView.model = model;
}


#pragma mark  ====== foot delegate ======

-(void)gender:(NSString *)gender tag:(NSInteger)index
{
   
    self.gender = gender;
    self.seletedIndex = index;
    self.model.patient.gender = [self.gender integerValue];
}
-(void)content:(NSString *)content tag:(NSInteger)tag
{
    
    if (tag == 0) {
        self.name = content;
        self.model.patient.name = content;
    }else if (tag == 1){
        self.age = content;
        self.model.patient.age = [content integerValue];
    }else if (tag == 2){
        self.mobile = [content stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.model.patient.mobile = self.mobile;
    }else if (tag == 3){
        self.wx = content;
        self.model.patient.wx = self.wx;
    }
}


#pragma mark    post 

-(void)saveAction:(UIButton *)sender{
    [self.view endEditing:YES];
    if (self.patientid != nil) {
        if (self.name.length == 0 && self.model.patient.name.length == 0) {
            [NSString showInfoWithStatus:@"姓名不能为空"];
            return;
        }else if (self.name.length == 0 && self.model.patient.name.length != 0){
            self.name = self.model.patient.name;
        }
        if (self.mobile.length == 0 && self.model.patient.mobile.length == 0){
            [NSString showInfoWithStatus:@"手机号不能为空"];
            return;
        }else if (self.mobile.length == 0 && self.model.patient.mobile.length != 0){
            
             self.mobile = self.model.patient.mobile;
            
        }else if (self.mobile.length>0){
            if ([NSString  valiMobile:self.mobile] != nil) {
                [NSString showInfoWithStatus:@"手机号不合法"];
                return;
            }
        }
        
        if (self.wx.length == 0 && self.model.patient.wx.length != 0) {
            self.wx = self.model.patient.wx;
        }
        
        if([self.age integerValue] == 0  && self.model.patient.age>0 ){
            self.age = [NSString stringWithFormat:@"%ld",self.model.patient.age];
        }
        if (self.image == nil && self.model.patient.avatar != nil) {
            self.avater = self.model.patient.avatar;
        }
        if (self.tagListAry.count == 0 && self.patientTagsArray.count >0) {
            NSMutableString *mStr = [NSMutableString string];
            for (YAPatientInfoPatientTagModel  *model in self.patientTagsArray) {
                
                [mStr appendString:[NSString stringWithFormat:@"%ld",[model.tagid integerValue]]];
                [mStr appendString:@","];
            }
            self.tagid = mStr;
        }
        if (self.gender == nil && self.model.patient.gender>=-1) {
            self.gender = [NSString stringWithFormat:@"%ld",self.model.patient.gender];
        }
    }else{
        if (self.name.length == 0) {
            [NSString showInfoWithStatus:@"姓名不能为空"];
            return;
        }else if (self.mobile.length == 0){
            [NSString showInfoWithStatus:@"手机号不能为空"];
            return;
        }else if (self.mobile.length>0){
            if ([NSString  valiMobile:self.mobile] != nil) {
                [NSString showInfoWithStatus:@"手机号不合法"];
                return;
            }
        }
        if([self.age integerValue] == 0  && [self.age integerValue]>150 ){
            [NSString showInfoWithStatus:@"年龄不合法"];
            return;
        }
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = self.name;
    param[@"age"] = self.age;
    param[@"mobile"] = self.mobile;
    param[@"gender"] = self.gender;
    param[@"tag_name"] = self.tag_name;
    param[@"tagid"] = self.tagid;
    param[@"caseid"] = self.caseid;
    param[@"wx"] = self.wx;
    if (self.patientid != nil) {
        param[@"id"] = self.patientid;
    }
    
    __weak typeof(self) weakSelf = self;
    NSString *postUrl = self.patientid==nil?patient_insert_url:update_patient_url;
    if (self.image ==nil) {
        param[@"avatar"]= self.avater;
        [YAHttpBase POST:postUrl parameters:param success:^(id responseObject, int code) {
            NSDictionary *data = responseObject[@"data"];

            YA_LOG(@"%@",responseObject[@"message"]);
            //[SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if (weakSelf.refreshedRow) {
                weakSelf.refreshedRow();
            }
            YAPersonModel *model = [YAPersonModel new];
            model.name = weakSelf.name;
            model.avatar = weakSelf.avater;
            model.mobile = weakSelf.mobile;
            
            if (self.patientid) {
                model.id = self.patientid;
            }else{
                NSLog(@"%@",data);
                model.id = [NSString stringWithFormat:@"%ld",[responseObject[@"data"] integerValue]];
            }
            [[YAFMDBDatabases sharedInstance] updateDatabases:model];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    else{
        
        NSData *data = UIImageJPEGRepresentation(self.image, 0.5);
        [[AliyunOSSObject sharedInstance] uploadObjectAsyc:nil imageData:data file:self.mobile success:^(NSString *url) {
            param[@"avatar"] = url;
            NSLog(@"%@",param);
            [YAHttpBase POST:postUrl parameters:param success:^(id responseObject, int code) {
                
                //[SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
                [NSString hidHud];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.refreshedRow) {
                    weakSelf.refreshedRow();
                }
                YAPersonModel *model = [YAPersonModel new];
                model.name = weakSelf.name;
                model.avatar = url;
                model.mobile = weakSelf.mobile;
                
                if (self.patientid) {
                    model.id = self.patientid;
                }else{
                    model.id = [NSString stringWithFormat:@"%ld",[responseObject[@"data"] integerValue]];
                }
               
                [[YAFMDBDatabases sharedInstance] updateDatabases:model];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
                NSLog(@"%@",error);
            }];
            
        } fail:^(BOOL fal) {
        
        }];
        
    }
    
}




-(void)openCameraAction:(UIButton *)sender{
    [self.view endEditing:YES];
    YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"相机",@"相册"] ];
    sheet.tag = 1001;
    [sheet show]; 

}

-(void)actionSheet:(YAYIActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index
{
    if (index == 0) {
        [self openCamera];
    }else{
        [self openPhotoLibrary];
    }
    
}


- (void)openCamera

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        NSLog(@"没有摄像头");
    }
}

/**
 *  打开相册
 */
-(void)openPhotoLibrary

{
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
        }];
        
    }else{
        NSLog(@"不能打开相册");
    }
}
#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    NSLog(@"finish..");
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        //图片存入相册
       
    }
    CGFloat clipX = (image.size.width - 100)/2.0;
    CGFloat clipY = (image.size.height - 100)/2.0;
    UIImage *newImage = [UIImage clipWithImageRect:CGRectMake(clipX, clipY, 100, 100) clipImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.header.avatar.image = newImage;
    self.image = newImage;
    
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

@implementation  YAAddNewPatientModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
