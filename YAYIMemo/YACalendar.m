//
//  YACalendar.m
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACalendar.h"
#import "YAItemModel.h"
@implementation YACalendar
{
    NSArray *_itemArray;
    YACalenderCollectionView *_centerItem;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dateUntil = [YADateUntil new];
        [self createView];
    }
    return self;
}

-(void)setIsFreshed:(BOOL)isFreshed
{
    _isFreshed = isFreshed;
    [self loadDataSource:[NSString stringWithFormat:@"%ld",_centerItem.year] month:[NSString stringWithFormat:@"%ld",_centerItem.month] collectionView:_centerItem];

}
-(void)setPatientid:(NSString *)patientid
{
    _patientid = patientid;
     [self loadDataSource:[NSString stringWithFormat:@"%ld",_centerItem.year] month:[NSString stringWithFormat:@"%ld",_centerItem.month] collectionView:_centerItem];
    
}
-(void)createView{
    UIImage *image = [UIImage imageNamed:@"left"];
    YAHeaderView *header = [[YAHeaderView alloc] initWithFrame:CGRectMake(0, 13*YAYIScreenScale, SCREEN_W, image.size.height)];
    self.header = header;
    header.delegate = self;
    [self addSubview:header];
    
    YAWeekendayView *weekView = [[YAWeekendayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame)+15*YAYIScreenScale, SCREEN_W, 42*YAYIScreenScale)];
   
    [self addSubview:weekView];
    
    
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(weekView.frame), SCREEN_W, 234*YAYIScreenScale)];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = false;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
    
    
    
    YACalenderCollectionView *leftItem = [[YACalenderCollectionView alloc] initWithFrame:CGRectMake(15*YAYIScreenScale, 0, SCREEN_W - 30*YAYIScreenScale, 234*YAYIScreenScale)];
    leftItem.delegate = self;
    [leftItem loadData:[self.dateUntil lastMonth:[NSDate date]]];
    [self.scrollView addSubview:leftItem];
    
    YACalenderCollectionView *centerItem = [[YACalenderCollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftItem.frame)+30*YAYIScreenScale, 0, SCREEN_W - 30*YAYIScreenScale, 234*YAYIScreenScale)];
    centerItem.delegate = self;
    [self.scrollView addSubview:centerItem];
    
    YACalenderCollectionView *rightItem = [[YACalenderCollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(centerItem.frame)+30*YAYIScreenScale , 0, SCREEN_W -30*YAYIScreenScale, 234*YAYIScreenScale)];
    [rightItem loadData:[self.dateUntil nextMonth:[NSDate date]]];
    rightItem.delegate = self;
    [self.scrollView addSubview:rightItem];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_W*3, 234*YAYIScreenScale);
    self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);

    self.header.month = centerItem.month;
    [self.header updateDateWithYear:centerItem.year month:centerItem.month];
    _itemArray = @[leftItem,centerItem,rightItem];
    
    //阴影
    UIImage *image1 = [UIImage imageNamed:@"line_bg"];
    UIImageView *shadowView = [UIImageView new];
    shadowView.backgroundColor = [UIColor whiteColor];
    
    shadowView.image = image1;
    [self addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, image1.size.height));
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    _centerItem = centerItem;
}

-(void)loadDataSource:(NSString *)year month:(NSString *)month collectionView:(YACalenderCollectionView *)item{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"year"]  = year;
    param[@"month"] = month;
    param[@"patientid"] = self.patientid;
    [YAHttpBase GET:listCalendar_url parameters:param success:^(id responseObject, int code) {
        NSMutableArray *dataArry = [NSMutableArray array];
        NSArray *data = responseObject[@"data"];
        NSLog(@"%@",responseObject);
        for (NSDictionary *dic in data) {
            NSString *date = dic[@"date"];
            [dataArry addObject:date];
        }
        item.dateArray = dataArry;

    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark ===============   UIscrollView delegate ==================
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x/SCREEN_W;
    YACalenderCollectionView *leftItem = _itemArray[0];
    YACalenderCollectionView *centerItem = _itemArray[1];
    YACalenderCollectionView *rightItem = _itemArray[2];
    
    if (pageIndex >1) {
        [leftItem loadData:[self.dateUntil nextMonth:leftItem.date]];
        [centerItem loadData:[self.dateUntil nextMonth:centerItem.date]];
        [rightItem loadData:[self.dateUntil nextMonth:rightItem.date]];
        
        
    }else if (pageIndex < 1){
        
        [leftItem loadData:[self.dateUntil lastMonth:leftItem.date]];
        [centerItem loadData:[self.dateUntil lastMonth:centerItem.date]];
        [rightItem loadData:[self.dateUntil lastMonth:rightItem.date]];
    }
    _centerItem = centerItem;
    [self loadDataSource:[NSString stringWithFormat:@"%ld",centerItem.year] month:[NSString stringWithFormat:@"%ld",centerItem.month] collectionView:centerItem];
    [self.header updateDateWithYear:centerItem.year month:centerItem.month];
    self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
}


#pragma mark ===============

-(void)updateMonth:(NSInteger)index
{
    YACalenderCollectionView *leftItem = _itemArray[0];
    YACalenderCollectionView *centerItem = _itemArray[1];
    YACalenderCollectionView *rightItem = _itemArray[2];
    if (index == 1001) {
        [leftItem loadData:[self.dateUntil nextMonth:leftItem.date]];
        [centerItem loadData:[self.dateUntil nextMonth:centerItem.date]];
        [rightItem loadData:[self.dateUntil nextMonth:rightItem.date]];
    }else{
        [leftItem loadData:[self.dateUntil lastMonth:leftItem.date]];
        [centerItem loadData:[self.dateUntil lastMonth:centerItem.date]];
        [rightItem loadData:[self.dateUntil lastMonth:rightItem.date]];
    }
    [self.header updateDateWithYear:centerItem.year month:centerItem.month];
    [self loadDataSource:[NSString stringWithFormat:@"%ld",centerItem.year] month:[NSString stringWithFormat:@"%ld",centerItem.month] collectionView:centerItem];
    self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);

}

-(void)selectedItem:(NSString *)worktime date:(NSString *)date
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateData: date:)]) {
        [_delegate updateData:worktime date:date];
    }
}
-(void)selectedItemByBeyond:(NSString *)worktime date:(NSString *)date isLast:(BOOL)isLast
{
    YACalenderCollectionView *leftItem = _itemArray[0];
    YACalenderCollectionView *centerItem = _itemArray[1];
    YACalenderCollectionView *rightItem = _itemArray[2];
   
    [leftItem loadData:[self.dateUntil lastMonth:leftItem.date]];
    [centerItem loadData:[self.dateUntil lastMonth:centerItem.date]];
    [rightItem loadData:[self.dateUntil lastMonth:rightItem.date]];
    [self.header updateDateWithYear:centerItem.year month:centerItem.month];
    [self loadDataSource:[NSString stringWithFormat:@"%ld",centerItem.year] month:[NSString stringWithFormat:@"%ld",centerItem.month] collectionView:centerItem];
    
    self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    if (_delegate && [_delegate respondsToSelector:@selector(updateData: date:)]) {
        [_delegate updateData:worktime date:date];
    }
}
-(void)selectedItemByBeyond:(NSString *)worktime date:(NSString *)date isNext:(BOOL)isNext
{
    YACalenderCollectionView *leftItem = _itemArray[0];
    YACalenderCollectionView *centerItem = _itemArray[1];
    YACalenderCollectionView *rightItem = _itemArray[2];
    [leftItem loadData:[self.dateUntil nextMonth:leftItem.date]];
    [centerItem loadData:[self.dateUntil nextMonth:centerItem.date]];
    [rightItem loadData:[self.dateUntil nextMonth:rightItem.date]];
    [self.header updateDateWithYear:centerItem.year month:centerItem.month];
    [self loadDataSource:[NSString stringWithFormat:@"%ld",centerItem.year] month:[NSString stringWithFormat:@"%ld",centerItem.month] collectionView:centerItem];
    self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    if (_delegate && [_delegate respondsToSelector:@selector(updateData: date:)]) {
        [_delegate updateData:worktime date:date];
    }
}
@end
