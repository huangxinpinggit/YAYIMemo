//
//  YAMessageViewController.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/10.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAMessageViewController.h"
#import "YAMessageViewCell.h"
@interface YAMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation YAMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    UIBarButtonItem *leftItem = [self createButton:CGRectMake(0, 0, 60, 30) image:@"s_Bback" title:nil font:nil fontColor:nil tag:101];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self createTableView];
}

-(UIBarButtonItem *)createButton:(CGRect)rect image:(NSString*)image title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)color tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateSelected];
    button.tag = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

-(void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f3f4f6"];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YAMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAMessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = @"鲜花笑脸轻轻扬，小鸟欢歌喜婉转，天空悠闲好蔚蓝，小溪幸福慢慢淌，晨风轻叩美窗棂，催你早起迎朝阳!祝你早安，心情灿烂!";
    CGFloat height = [self heightForString:content fontSize:12 andWidth:278*YAYIScreenScale];
    return (20+14+12+6+15+14+1+20)*YAYIScreenScale + height;
}

-(void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:YAFont(fontSize)
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeToFit.height;
}


@end
