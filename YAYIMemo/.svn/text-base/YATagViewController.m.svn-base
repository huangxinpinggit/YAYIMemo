//
//  YATagViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/21.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YATagViewController.h"
#import "YATagsView.h"
#import "YAEditTagesView.h"
#import "YATagsModel.h"
@interface YATagViewController ()<YATagsViewDelegate,YAEditTagesViewDelegate>
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)YATagsView *tagsView;
@property (nonatomic, weak)UILabel *vLine;
@property (nonatomic, weak)YAEditTagesView *edittagView;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)NSArray *tags;
@property (nonatomic, weak)UIButton *saveBtn;
@end

@implementation YATagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    [button setTitleColor:[UIColor colorWithHexString:@"#b7b7b7"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    self.saveBtn = button;
    button.frame = CGRectMake(0, 0, 40, 20);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    [self addTagsView];
    
    
    
    
    // 左分割线
    
    UILabel *vLine = [UILabel new];
    vLine.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    self.vLine = vLine;
    [self.view addSubview:vLine];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(88*YAYIScreenScale));
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(1, SCREEN_H));
    }];
    
    [self createTagView];
    
    [self netRequest];
}
/*
-(void)setTagListAry:(NSArray *)tagListAry
{
    _tagListAry = tagListAry;
 
    
    
}
 */
// 添加标签

-(void)addTagsView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    self.headerView = view;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(88*YAYIScreenScale+1));
        make.top.equalTo(@0);
        make.right.mas_equalTo(@(-15*YAYIScreenScale));
        make.height.equalTo(@(44*YAYIScreenScale));
    }];
    
    YAEditTagesView *editTagView = [[YAEditTagesView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W - 88*YAYIScreenScale-1-15*YAYIScreenScale, 44*YAYIScreenScale)];
    self.edittagView = editTagView;
    editTagView.delegate = self;
    [_headerView addSubview:editTagView];
    
    __weak typeof(self) weakSelf = self;
    editTagView.updateLayout = ^(CGFloat height){
        
        [weakSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        
    };
    editTagView.updatedata = ^(YATagsModel *model){
        model.selected = false;
        model.deleted = false;
        [weakSelf.dataAry enumerateObjectsUsingBlock:^(YATagsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tagid  == model.tagid) {
                [weakSelf.dataAry replaceObjectAtIndex:idx withObject:model];
            }
            
        }];
        
        weakSelf.tagsView.dataAry = weakSelf.dataAry;
    };
    
    //
    
    self.edittagView.dataAry = [NSMutableArray arrayWithArray:_tagListAry];
   
    
    
    
    
    
    
   // editTagView.dataAry = [NSMutableArray arrayWithArray:@[@"狗不理",@"不要脸",@"狗改不了吃屎"]];
    
    
    UILabel *label = [UILabel new];
    self.hLine = label;
    label.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.top.mas_equalTo(view.mas_bottom);
        make.right.mas_equalTo(view.mas_right);
        make.height.equalTo(@1);
    }];
    
    

}
// 所有标签
-(void)createTagView{
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"所有标签";
    titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
    titleLab.textColor = [UIColor colorWithHexString:@"#828282"];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vLine.mas_right).offset(10*YAYIScreenScale);
        make.top.mas_equalTo(self.hLine.mas_bottom).offset(14*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(80, 14*YAYIScreenScale));
    }];
    
    
    YATagsView * tagsView = [[YATagsView alloc] initWithFrame:CGRectMake(88*YAYIScreenScale+1, 120, SCREEN_W - 88*YAYIScreenScale-1, 140)];
    self.tagsView = tagsView;
    tagsView.backgroundColor = [UIColor whiteColor];
    tagsView.delegate = self;
    [self.view addSubview:tagsView];
    [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vLine.mas_right);
        make.top.mas_equalTo(titleLab.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 88*YAYIScreenScale-1, 140));
    }];
}

-(void)saveAction:(UIButton *)sender{
    [self.view endEditing:YES];
    if (self.tags.count==0) {
        [NSString showInfoWithStatus:@"请添加标签"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    sender.selected = !sender.selected;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"caseid"] = self.caseid;
    param[@"tags"] = self.tags;
  
    NSLog(@"%@",param);
    [YAHttpBase POST:updateTag_url parameters:param  success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        if (weakSelf.refreshedRow) {
            weakSelf.refreshedRow();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
-(void)selectedTagName:(YATagsModel *)model
{
    NSLog(@"%@",self.edittagView);
    
    self.edittagView.model = model;
}

-(void)netRequest{
    __weak typeof(self)  weakSelf = self;
    [YAHttpBase GET:listCommonTag_url parameters:nil success:^(id responseObject, int code) {
        //YAYI_LOG(@"%@",responseObject);
        
        NSArray *data = responseObject[@"data"];
        weakSelf.dataAry = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YATagsModel *model = [YATagsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.dataAry addObject:model];
        }
        
        [weakSelf.dataAry enumerateObjectsUsingBlock:^(YATagsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (YATagsModel *model in _tagListAry) {
                if (obj.tagid == model.tagid) {
                    obj.selected = YES;
                }
            }
            
        }];
        
        weakSelf.tagsView.dataAry = weakSelf.dataAry;
       
    } failure:^(NSError *error) {
        
    }];
}
-(void)datasources:(NSMutableArray *)ary
{
    if (ary.count >0) {
        [self.saveBtn setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
    }else{
        [self.saveBtn setTitleColor:YAColor(@"#b7b7b7") forState:UIControlStateNormal];
    }
    NSMutableArray *dataAry = [NSMutableArray array];
    for (YATagsModel *model in ary) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"tagid"] = [NSString stringWithFormat:@"%ld",model.tagid];
        param[@"tagname"] = model.tagname;
        [dataAry addObject:param];
    }
    self.tags = dataAry;

}
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
