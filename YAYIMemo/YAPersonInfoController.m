//
//  YAPersonInfoController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/8.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPersonInfoController.h"
#import "YASettingCell.h"
#import "YAPersonInfonViewCell.h"
#import "YAYIActionSheet.h"
#import "YAEditNameController.h"
#import "YAEditPasswordController.h"
#import "YAPersonItemModel.h"
#import "YASetNewMobileController.h"
@interface YAPersonInfoController ()<UITableViewDelegate,UITableViewDataSource,YAYIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImage *avater;
@property (nonatomic, strong)YAPersonItemModel *model;
@end

@implementation YAPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f3f3f6"];
    [self getPersonInfo];
    [self createTableView];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f6"];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor whiteColor];
    footer.frame = CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.tableView.frame)-64-3*54*YAYIScreenScale-20*YAYIScreenScale - 98*YAYIScreenScale);
    self.tableView.tableFooterView = footer;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *identifer = @"cell";
            YAPersonInfonViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YAPersonInfonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            if (self.avater) {
                cell.avater.image = self.avater;
            }else{
               cell.model = self.model;
            }
            cell.titleLab.text = @"头像";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString *identifer = @"cell1";
            YASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (cell == nil) {
                cell = [[YASettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            cell.titleLab.text = @"昵称";
            cell.operaLab.text = self.model.name;
            cell.hLine.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        static NSString *identifer = @"cell2";
        YASettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YASettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"手机号";
            cell.operaLab.text = self.model.mobile;
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"密码";
            cell.operaLab.text = @"修改";
        }
        return cell;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 98*YAYIScreenScale;
    }
    return 54*YAYIScreenScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*YAYIScreenScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREEN_W, 10*YAYIScreenScale);
    view.backgroundColor = [UIColor colorWithHexString:@"#f3f3f6"];
    return  view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        YAYIActionSheet *sheet = [[YAYIActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"相机",@"从照片库选择"] ];
        sheet.tag = 1001;
        [sheet show];
    }else if(indexPath.section == 0 && indexPath.row == 1){
        __weak typeof(self) weakSelf = self;
        YAEditNameController *editView = [YAEditNameController new];
        editView.name = self.model.name;
        editView.refreshedOperation = ^{
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            weakSelf.model = nil;
            [weakSelf getPersonInfo];
        };
        [self.navigationController pushViewController:editView animated:YES];
    }else if (indexPath.section ==1 && indexPath.row == 0){
        YASetNewMobileController *editMobileView = [YASetNewMobileController new];
         __weak typeof(self) weakSelf = self;
        editMobileView.refreshedOperation = ^{
            weakSelf.model = nil;
            [weakSelf getPersonInfo];
        };
        [self.navigationController pushViewController:editMobileView animated:YES];
    }else{
        YAEditPasswordController *editView = [YAEditPasswordController new];
        [self.navigationController pushViewController:editView animated:YES];
    }

}




#pragma mark ===================

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
        imagePicker.navigationBar.tintColor = YAColor(@"#424242");
        [imagePicker.navigationBar setBackgroundImage:[UIImage createImageWithColor:YA_ALPHA_COLOR(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
        [imagePicker.navigationBar setShadowImage:[UIImage createImageWithColor:YA_ALPHA_COLOR(0, 0, 0, 0.1)]];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CGFloat clipX = (image.size.width - 100)/2.0;
    CGFloat clipY = (image.size.height - 100)/2.0;
    UIImage *newImage = [UIImage clipWithImageRect:CGRectMake(clipX, clipY, 100, 100) clipImage:image];
    
    self.avater = newImage;
    [self updateAvater];
    [self.tableView  reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ===========================

-(void)updateAvater{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = self.model.id;
    
    NSData *data = UIImageJPEGRepresentation(self.avater,0.5);
    [[AliyunOSSObject sharedInstance] uploadObjectAsyc:nil imageData:data
      file:self.model.mobile success:^(NSString *url) {
           param[@"avatar"] = url;
          NSLog(@"%@",param);
          [YAHttpBase POST:update_user_avater_url parameters:param success:^(id responseObject, int code) {
              NSString *message = responseObject[@"message"];
              [SVProgressHUD showSuccessWithStatus:message];
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
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

@end
