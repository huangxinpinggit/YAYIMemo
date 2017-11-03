//
//  YWViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/8/31.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YWViewController.h"
#import "YAPermanentTeethView.h"
#import "YABabyTeethView.h"
#import "YATeethModel.h"


@interface YWViewController ()<UIScrollViewDelegate,YABabyTeethViewDelegate,YAPermanentTeethViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *btnArray;
@property (nonatomic, strong)UILabel *indicatorLab;
@property (nonatomic, strong)UIButton *lastBtn;
@property (nonatomic, strong)UIButton *lastButn;
@property (nonatomic, strong)YABabyTeethView *babyView;
@property (nonatomic, strong)YAPermanentTeethView *permanentView;
@property (nonatomic, assign)YATEECHTYPE currentTeechType;
@property (nonatomic, strong)NSString *teeth;
@end

@implementation YWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择标记该患者的牙位图";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:YAYIFontWithScale(14)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8a8a8a"]}];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnArray = [NSMutableArray array];
    [self createSelectedBtns];
    [self createIndicator];
    [self createScrollView];
    [self createView];
    [self commitBtns];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)setCurrentTeechType:(YATEECHTYPE)currentTeechType
{
    _currentTeechType = currentTeechType;
    [self netRequest];
}

-(void)commitNet{
    NSLog(@"%ld",self.currentTeechType);
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"caseid"] = self.caseid;
    param[@"type"] = @(self.currentTeechType);
    param[@"tooth"] = self.teeth;
    [YAHttpBase POST:updateToothMap_url parameters:param success:^(id responseObject, int code) {
        NSString *message = responseObject[@"message"];
        [SVProgressHUD showSuccessWithStatus:message];
        [self dismissViewControllerAnimated:YES completion:nil];
        if (_refreshedRow) {
            _refreshedRow();
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)netRequest{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"caseid"] = self.caseid;
    param[@"type"] = @(self.currentTeechType);
   
    __weak typeof(self) weakSelf = self;
    [YAHttpBase GET:queryToothMap_url parameters:param success:^(id responseObject, int code) {
        NSArray *data = responseObject[@"data"];
        
        for (NSDictionary *dic in data) {
            YATeethModel *model = [[YATeethModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            NSArray *ary = [model.tooth componentsSeparatedByString:@","];
            NSLog(@"%ld",weakSelf.currentTeechType);
            if (weakSelf.currentTeechType == YAPermanentTeeth) {
                weakSelf.permanentView.dataAry = ary;
            }else{
                weakSelf.babyView.dataAry = ary;
            }
        }
       
        
        
    } failure:^(NSError *error) {
        
    }];

}
-(void)commitBtns{
    NSArray *titleArrray = @[@"取消",@"确定"];
    UIImage *image = [self GetImageWithColor:[UIColor colorWithHexString:@"#424242"] andHeight:27*YAYIScreenScale];
    for (int i=0; i < titleArrray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor =[UIColor colorWithHexString:@"#8a8a8a"].CGColor;
        button.layer.borderWidth = 1.0;
        [button setTitle:titleArrray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.tag = 1003+i;
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(14)];
        button.layer.cornerRadius = 14*YAYIScreenScale;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        [button setBackgroundImage:[image stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (i == 0) {
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.scrollView.mas_bottom).offset(44*YAYIScreenScale);
                make.right.mas_equalTo(self.view.mas_centerX).offset(-7.5*YAYIScreenScale);
                make.size.mas_equalTo(CGSizeMake(88*YAYIScreenScale, 27*YAYIScreenScale));
            }];
        }else{
            button.selected = YES;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.scrollView.mas_bottom).offset(44*YAYIScreenScale);
                make.left.mas_equalTo(self.view.mas_centerX).offset(7.5*YAYIScreenScale);
                make.size.mas_equalTo(CGSizeMake(88*YAYIScreenScale, 27*YAYIScreenScale));
            }];
        }
        
    }
}

-(void)commitAction:(UIButton *)sender{
    self.lastButn.selected = false;
    self.lastButn.layer.borderWidth = 1;
    sender.selected = YES;
    sender.layer.borderWidth = sender.selected? 0: 1;
    if (sender.tag == 1003 ) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self commitNet];
    }
    self.lastButn = sender;
}

-(void)createScrollView{
    if (self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 72*YAYIScreenScale, SCREEN_W, 389*YAYIScreenScale)];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.bounces = false;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = false;
        [self.view addSubview:self.scrollView];
    }
}

-(void)createSelectedBtns{
    NSArray *titleAry = @[@"恒牙",@"乳牙"];
    for (int i = 0; i < titleAry.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
        [self.view addSubview:button];
        button.tag = 1000+i;
        [self.btnArray addObject:button];
        if (i == 0) {
            button.selected = YES;
            self.lastBtn = button;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(17*YAYIScreenScale));
                make.right.mas_equalTo(self.view.mas_centerX).offset(-30*YAYIScreenScale);
                make.height.equalTo(@(15*YAYIScreenScale));
                
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(17*YAYIScreenScale));
                make.left.mas_equalTo(self.view.mas_centerX).offset(30*YAYIScreenScale);
                make.height.equalTo(@(15*YAYIScreenScale));
            }];
        }
       
    }

}

-(void)createIndicator{
    if (_indicatorLab == nil) {
        self.indicatorLab = [UILabel new];
        self.indicatorLab.backgroundColor = [UIColor colorWithHexString:@"#424242"];
        [self.view addSubview:self.indicatorLab];
        self.indicatorLab.frame = CGRectMake(self.view.centerX-(20+49)*YAYIScreenScale, 42*YAYIScreenScale, 49*YAYIScreenScale, 1);
        
    }

}


-(void)createView{
    YABabyTeethView *babyView = [[YABabyTeethView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, 389*YAYIScreenScale)];
    self.currentTeechType = babyView.type;
    self.babyView = babyView;
    babyView.delegate = self;
    [self.scrollView addSubview:babyView];
    
    YAPermanentTeethView *perView = [[YAPermanentTeethView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 389*YAYIScreenScale)];
    self.currentTeechType = perView.type;
    self.permanentView = perView;
    perView.delegate = self;
    [self.scrollView addSubview:perView];
    
    
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(SCREEN_W*2, 389*YAYIScreenScale);
    

}
-(void)selectedAction:(UIButton *)sender{
   
    self.lastBtn.selected = false;
    if (sender.tag == 1001) {
        self.currentTeechType = YABabyTeeth;
        CGRect rect = self.indicatorLab.frame;
        rect.origin.x = self.view.centerX+20*YAYIScreenScale;
        self.indicatorLab.frame = rect;
    }else{
        self.currentTeechType = YAPermanentTeeth;
        CGRect rect = self.indicatorLab.frame;
        rect.origin.x = self.view.centerX-(20+49)*YAYIScreenScale;
        self.indicatorLab.frame = rect;
    }
    NSInteger index = sender.tag - 1000;
    [self.scrollView setContentOffset:CGPointMake(index*SCREEN_W, 0)];
    sender.selected = YES;
    self.lastBtn = sender;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (self.scrollView.contentOffset.x+(SCREEN_W/2.0))/SCREEN_W;
    self.lastBtn.selected = false;
    if(scrollView.contentOffset.x == 0){
        self.currentTeechType = YAPermanentTeeth;
        [UIView animateWithDuration:0.1 animations:^{
           
            CGRect rect = self.indicatorLab.frame;
            rect.origin.x = self.view.centerX-(20+49)*YAYIScreenScale;
            self.indicatorLab.frame = rect;
            UIButton *button = self.btnArray[index];
            button.selected = YES;
            self.lastBtn = button;
        } completion:^(BOOL finished) {
            
        }];
        
    }else if (scrollView.contentOffset.x == SCREEN_W){
        self.currentTeechType = YABabyTeeth;
        [UIView animateWithDuration:0.1 animations:^{
            CGRect rect = self.indicatorLab.frame;
            rect.origin.x = self.view.centerX+20*YAYIScreenScale;
            self.indicatorLab.frame = rect;
            UIButton *button = self.btnArray[index];
            
            button.selected = YES;
            self.lastBtn = button;
        } completion:^(BOOL finished) {
            
            
        }];
    }
   
   
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    

}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

-(void)teeth:(NSArray *)teeth type:(YATEECHTYPE)type
{
    NSMutableString *tooth = [NSMutableString string];
    for (UIButton *button in teeth) {
        if (button.selected) {
            NSString *str = [NSString stringWithFormat:@"%ld",button.tag];
            [tooth appendString:str];
            [tooth appendString:@","];
        }
    }
    self.currentTeechType = type;
    if (tooth.length >0) {
        self.teeth = [tooth substringToIndex:tooth.length-1];
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
@end
