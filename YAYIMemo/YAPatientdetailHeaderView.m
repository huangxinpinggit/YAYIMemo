//
//  YAPatientdetailHeaderView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/15.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientdetailHeaderView.h"

@implementation YAPatientdetailHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
        _tagArray = [NSMutableArray array];
    }
    return self;
}

-(void)createViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [UILabel new];
    titleLab.font = YAFont(15);
    titleLab.text = @"所有标签";
    titleLab.textColor = YAColor(@"#8a8a8a");
    [self.contentView addSubview:titleLab];
    self.titleLab = titleLab;
    
    YAPatientDetailTagview *tagView = [[YAPatientDetailTagview alloc] initWithFrame:CGRectMake(0,0,SCREEN_W - 15*YAYIScreenScale, 28*YAYIScreenScale)];
    tagView.delegate = self;
    tagView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:tagView];
    self.tagView = tagView;
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = YAColor(@"#f3f4f6");
    [self.contentView addSubview:hLine];
    self.hLine = hLine;
    
    UILabel *detailtitleLab = [UILabel new];
    detailtitleLab.font = YAFont(15);
    detailtitleLab.text = @"详细资料";
    detailtitleLab.textColor = YAColor(@"#8a8a8a");
    [self.contentView addSubview:detailtitleLab];
    self.detailtitleLab = detailtitleLab;
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*YAYIScreenScale));
        make.top.equalTo(@(22*YAYIScreenScale));
    }];
    [self.tagView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(16*YAYIScreenScale);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W - 15*YAYIScreenScale, self.tagView.height));
    }];
    [self.hLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagView.mas_bottom).offset(16*YAYIScreenScale);
        make.left.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 5*YAYIScreenScale));
    }];
    [self.detailtitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.top.mas_equalTo(self.hLine.mas_bottom).offset(22*YAYIScreenScale);
    }];
    //22+15+16+72+16+22+15+8=125+61
}
//获取每个标签的宽
-(CGSize)getTagSize:(NSString *)tagName font:(UIFont *)font{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [tagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)selectedTagName:(YAPatientInfoPatientTagModel *)model
{
    if (model.selected) {
        [_tagArray addObject:model];
    }else{
        [_tagArray removeObject:model];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedTags: tagAry:)]) {
        [_delegate selectedTags:[self tagsid:_tagArray] tagAry:_tagArray];
    }
}

-(NSString *)tagsid:(NSArray *)ary{
    NSMutableString *mStr = [NSMutableString string];
    for (int i =0; i< ary.count; i++) {
        YAPatientInfoPatientTagModel *model = ary[i];
    
        [mStr appendFormat:@"%ld",[model.tagid integerValue]];
        if (i != ary.count - 1) {
            [mStr appendString:@","];
        }
    }
    return mStr;
}

@end
