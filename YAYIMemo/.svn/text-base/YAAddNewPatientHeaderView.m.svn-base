//
//  YAAddNewPatientHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientHeaderView.h"

@implementation YAAddNewPatientHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}
-(void)setModel:(YAPatientDetailModel *)model
{
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:_model.patient.avatar] placeholderImage:[UIImage imageNamed:@"default_person_avatar"]];
    if (_model.patient.gender == 0) {
        self.segment.selectedSegmentIndex = 2;
    }else if (_model.patient.gender == 1){
        self.segment.selectedSegmentIndex = 1;
    }else if (_model.patient.gender == -1){
        self.segment.selectedSegmentIndex = -1;
    }

}
-(void)createView{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    self.backView = [UIView new];
    self.backView.userInteractionEnabled = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    self.avatar = [UIImageView new];
    [self.avatar zy_cornerRadiusAdvance:45*YAYIScreenScale rectCornerType:UIRectCornerAllCorners];
    [self.avatar zy_attachBorderWidth:2*YAYIScreenScale color:[UIColor colorWithHexString:@"#e7e7e7"]];
    self.avatar.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:self.avatar];
    
    self.camera = [UIButton buttonWithType:UIButtonTypeCustom];
    self.camera.layer.shadowOffset = CGSizeMake(1, 1);
    [self.camera setImage:[UIImage imageNamed:@"w_camera"] forState:UIControlStateNormal];
    self.camera.layer.shadowColor = [UIColor colorWithHexString:@"#252525"].CGColor;
    [self.backView addSubview:self.camera];
    
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女",@"不填"]];
    self.segment.selectedSegmentIndex = 2;//设置默认选择项索引
    self.segment.tintColor = [UIColor clearColor];
    self.segment.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    self.segment.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    //[UIColor colorWithHexString:@"#f1f1f1"];
    self.segment.layer.borderWidth = 1;
    self.segment.layer.cornerRadius = 14*YAYIScreenScale;
    self.segment.clipsToBounds = YES;
    self.segment.layer.borderColor = [UIColor colorWithHexString:@"#e2e2e2"].CGColor;
    [self.backView addSubview:self.segment];
    
    UIFont *font = [UIFont systemFontOfSize:YAYIFontWithScale(15)];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //修改颜色
    
    UIColor *textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    NSDictionary *textColorDic = [NSDictionary dictionaryWithObject:textColor forKey:NSForegroundColorAttributeName];
    [self.segment setTitleTextAttributes:textColorDic forState:UIControlStateNormal];
    UIColor *selectTextColor = [UIColor colorWithHexString:@"#424242"];
    NSDictionary *selectTextColorDic = [NSDictionary dictionaryWithObject:selectTextColor forKey:NSForegroundColorAttributeName];
    [self.segment setTitleTextAttributes:selectTextColorDic forState:UIControlStateSelected];
    UIImage *norImage = [self GetImageWithColor:[UIColor colorWithHexString:@"#f1f1f1"] andHeight:90*YAYIScreenScale];
    UIImage *selectImage = [self GetImageWithColor:[UIColor whiteColor] andHeight:90*YAYIScreenScale];
    [self.segment setBackgroundImage:selectImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segment setBackgroundImage:norImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segment addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, (17 + 90 + 28+39 +18)*YAYIScreenScale));
    }];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.equalTo(@(19*YAYIScreenScale));
        make.size.mas_equalTo(CGSizeMake(90*YAYIScreenScale, 90*YAYIScreenScale));
    }];
    UIImage *image = [UIImage imageNamed:@"w_camera"];
    [self.camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatar.mas_left).offset(54*YAYIScreenScale);
        make.top.mas_equalTo(self.avatar.mas_top).offset(62*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.avatar.mas_bottom).offset(28*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(273*YAYIScreenScale, 39*YAYIScreenScale));
    }];
    
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
-(void)selectAction:(UISegmentedControl *)sender
{
    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            if (_delegate && [_delegate respondsToSelector:@selector(gender: tag:)]) {
                [_delegate gender:@"1" tag:selecIndex];
            }
            break;
            
        case 1:
            if (_delegate && [_delegate respondsToSelector:@selector(gender: tag:)]) {
                [_delegate gender:@"-1" tag:selecIndex];
            }
            break;
            
        case 2:
            if (_delegate && [_delegate respondsToSelector:@selector(gender: tag:)]) {
                [_delegate gender:@"0" tag:selecIndex];
            }
            break;
        default:
            if (_delegate && [_delegate respondsToSelector:@selector(gender: tag:)]) {
                [_delegate gender:@"0" tag:selecIndex];
            }
            break;
    }
}



@end
