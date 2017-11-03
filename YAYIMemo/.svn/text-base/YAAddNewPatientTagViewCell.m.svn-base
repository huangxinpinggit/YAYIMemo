//
//  YAAddNewPatientTagViewCell.m
//  YAYIMemo
//
//  Created by hxp on 17/8/28.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAddNewPatientTagViewCell.h"

@implementation YAAddNewPatientTagViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView{
    self.titleLab = [UILabel new];
    self.titleLab.font = [UIFont systemFontOfSize:YAYIFontWithScale(13)];
    self.titleLab.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    [self.contentView addSubview:self.titleLab];
    
    self.tagView = [[YAAddNewPatientEditTagView alloc] initWithFrame:CGRectMake(114*YAYIScreenScale, 6*YAYIScreenScale, 224*YAYIScreenScale, 44*YAYIScreenScale)];
    self.tagView.delegate = self;
    [self.contentView addSubview:self.tagView];
    __weak typeof(self) weakSelf = self;
    weakSelf.tagView.updateLayout = ^(CGFloat height){
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateCellHeight:)]) {
            [_delegate updateCellHeight:height];
        }
        UITableView *tableView = [weakSelf tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    };
    weakSelf.tagView.updatedata = ^(YAPatientInfoPatientTagModel  *model){
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateData:)]) {
            [_delegate updateData:model];
        }

    };
    
    
    self.hLine = [UIImageView new];
    self.hLine.image = [UIImage imageNamed:@"i_line"];
    [self.contentView addSubview:self.hLine];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(22*YAYIScreenScale));
        make.left.equalTo(@(27*YAYIScreenScale));
        make.height.equalTo(@(13*YAYIScreenScale));
        
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.titleLab.mas_left);
        make.right.equalTo(@(-27*YAYIScreenScale));
        make.height.equalTo(@(1*YAYIScreenScale));
    }];
}

#pragma mark     =================

-(void)datasources:(NSMutableArray *)ary
{
    NSMutableString *tagName = [NSMutableString string];
    NSMutableString *tag_id = [NSMutableString string];
    for (YAPatientInfoPatientTagModel  *model in ary) {
        if (model.isInput) {
           [tagName appendString:model.tagName];
           [tagName appendString:@","];
        }else{
            [tag_id appendString:[NSString stringWithFormat:@"%ld",[model.tagid integerValue]]];
            [tag_id appendString:@","];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(tagName:tag_id:)]) {
        [_delegate tagName:tagName tag_id:tag_id];
    }

}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
@end
