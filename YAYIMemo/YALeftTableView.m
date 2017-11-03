//
//  YALeftTableView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/13.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YALeftTableView.h"

@implementation YALeftTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YAColor(@"#f5f5f5");
        [self createListView];
    }
    return self;
}

-(void)setDataAry:(NSMutableArray *)dataAry
{
    _dataAry = dataAry;
    [self.tableView reloadData];
}

-(void)createListView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = YAColor(@"#f5f5f5");
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
    }

}
#pragma mark ===================

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YALeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YALeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.model = self.dataAry[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAPersonModel *model =  self.dataAry[indexPath.row];
     CGFloat height = [self heightForString:model.name fontSize:14 andWidth:72*YAYIScreenScale];
    return 30*YAYIScreenScale + height;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:YAFont(fontSize)
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeToFit.height;
}


@end

@implementation YALeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)setModel:(YAPersonModel *)model
{
    _model = model;
    self.Label.text = model.name;
}

-(void)createView{
    UILabel *label = [UILabel new];
    label.textColor = YAColor(@"#8a8a8a");
    label.font = YAFont(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    self.Label = label;

}
-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(82*YAYIScreenScale - 10*YAYIScreenScale);
    }];
    
}

@end
