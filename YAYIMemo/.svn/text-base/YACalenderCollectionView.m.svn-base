//
//  YACalenderCollectionView.m
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACalenderCollectionView.h"
#import "YAItemOfdayCell.h"
#import "YADateUntil.h"
#import "YAItemModel.h"
#define selectedDate @"selectedDate"

@implementation YACalenderCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataAry = [NSMutableArray array];
        [self createView];
        [self loadData:[NSDate date]];
    }
    return self;
}
-(void)createView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
       
        layout.minimumInteritemSpacing = 0;// 垂直方向的间距
        layout.minimumLineSpacing = 1*YAYIScreenScale; // 水平方向的间距
        NSLog(@"%lf",self.frame.size.width);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 234*YAYIScreenScale) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        [self.collectionView registerClass:[YAItemOfdayCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
   

}

-(void)setDateArray:(NSMutableArray *)dateArray
{
    _dateArray = dateArray;
    [self.dataAry enumerateObjectsUsingBlock:^(YAItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [dateFormatter stringFromDate:obj.date];
        if (self.dateArray.count >0) {
            for (NSString *item in _dateArray) {
                if ([item isEqualToString:dateStr]) {
                    obj.isEvent = YES;
                }
                if ([[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]) {
                    if ([dateStr isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]] && !obj.isSelected) {
                        
                        if (obj.isSelected) {
                            
                            break;
                        }else{
                            
                            NSLog(@"%@  ======= %@ ======= %@ ===  %ld",[[NSUserDefaults standardUserDefaults] valueForKey:selectedDate],obj.date,obj,idx);
                            obj.isSelected = YES;
                        }
                    }
                }
                
            }
        }else{
            NSLog(@" ======= %@ ======= ",[[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]);
            if ([[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]) {
                if ([dateStr isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]] && !obj.isSelected) {
                    
           
                    NSLog(@"%@  ======= %@ ======= %@ ===  %ld",[[NSUserDefaults standardUserDefaults] valueForKey:selectedDate],obj.date,obj,idx);
                        obj.isSelected = YES;
                    
                }
            }
        }
       
    }];
    [self.collectionView reloadData];

}
-(void)loadData:(NSDate *)date{
    self.date = date;
    [self.dataAry removeAllObjects];
    YADateUntil *dateUtil = [YADateUntil new];
    self.month =  [dateUtil month:date];
    self.year = [dateUtil year:date];
    for (int i =0; i< 42; i++) {
        NSInteger daysInLastMonth = [dateUtil totaldaysInMonth:[dateUtil lastMonth:date]];
        NSInteger daysInThisMonth = [dateUtil totaldaysInMonth:date];
        NSInteger firstWeekday    = [dateUtil firstWeekdayInThisMonth:date];
        NSInteger day = 0;
        
        YAItemModel *model = [YAItemModel new];
        if (i < firstWeekday) {
            //超出这个月的 头部
            day = daysInLastMonth - firstWeekday + i + 1;
            model.isBeyond = YES;
            model.isLastMonth = YES;
            
            model.day = [NSString stringWithFormat:@"%ld",day];
            model.year = [NSString stringWithFormat:@"%ld",[dateUtil year:[dateUtil lastMonth:date]]];
            model.moth = [NSString stringWithFormat:@"%ld",[dateUtil month:[dateUtil lastMonth:date]]];
            model.beyonddate = [dateUtil getDateWithYear:[model.year integerValue] month:[model.moth integerValue] day:[model.day integerValue]];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            //超出这个月的 尾部
            day = i + 1 - firstWeekday - daysInThisMonth;
            model.isBeyond = YES;
            model.isNextMonth = YES;
            model.day = [NSString stringWithFormat:@"%ld",day];
            model.year = [NSString stringWithFormat:@"%ld",[dateUtil year:[dateUtil nextMonth:date]]];
            model.moth = [NSString stringWithFormat:@"%ld",[dateUtil month:[dateUtil nextMonth:date]]];
            model.beyonddate = [dateUtil getDateWithYear:[model.year integerValue] month:[model.moth integerValue] day:[model.day integerValue]];
            //[self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            //本月的
            day = i - firstWeekday + 1;
            model.isBeyond = false;
            model.day = [NSString stringWithFormat:@"%ld",day];
            model.year = [NSString stringWithFormat:@"%ld",[dateUtil month:date]];
            model.date = [dateUtil getDateWithYear:[dateUtil year:date] month:[dateUtil month:date] day:day];
            //[self setStyle_AfterToday:dayButton];
        }
        if ([dateUtil month:date] == [dateUtil month:[NSDate date]]) {
            
            NSInteger todayIndex = [dateUtil day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                model.isNext = false;
                //[self setStyle_BeforeToday:dayButton];
                
            }else if(i ==  todayIndex){
               
                 // 今天
                NSLog(@"%ld",todayIndex);
                model.isToday = YES;
                model.isDefault = YES;
                
            }else{
                model.isToday = false;
                model.isNext = YES;
            }
        }
        
        [self.dataAry addObject:model];
    }
    [self.collectionView reloadData];

}





#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YAItemOfdayCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataAry[indexPath.item];
    if (cell.model.isDefault && [[NSUserDefaults standardUserDefaults] valueForKey:selectedDate]== nil) {
        NSTimeInterval a=[cell.model.date timeIntervalSince1970]-8*3600;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:cell.model.date];
        if (_delegate && [_delegate respondsToSelector:@selector(selectedItem: date:)]) {
            
            [_delegate selectedItem:[NSString stringWithFormat:@"%.lf",a] date:dateStr];
            [cell setSelected:YES];
        }
        self.lastIndexPath = indexPath;
    }else if (cell.model.isSelected){
        NSTimeInterval a=[cell.model.date timeIntervalSince1970]-8*3600;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:cell.model.date];
        if (_delegate && [_delegate respondsToSelector:@selector(selectedItem: date:)]) {
            
            [_delegate selectedItem:[NSString stringWithFormat:@"%.lf",a] date:dateStr];
            [cell setSelected:YES];
        }
        self.lastIndexPath = indexPath;
    }
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}



#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = (SCREEN_W - 30*YAYIScreenScale)/7.0;
    return CGSizeMake(w, 38*YAYIScreenScale);
}
#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YAItemModel *model = self.dataAry[indexPath.item];
    if (model.isBeyond) {
        
        
        NSTimeInterval a=[model.beyonddate timeIntervalSince1970]-8*3600;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:model.beyonddate];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([user valueForKey:selectedDate] != nil) {
            [user removeObjectForKey:selectedDate];
            [user setValue:dateStr forKey:selectedDate];
        }else{
            [user setValue:dateStr forKey:selectedDate];
        }
       // [user setValue:dateStr forKey:selectedDate];
        
         NSLog(@" ======= %@ =======%@======== %@ ",[user valueForKey:selectedDate],dateStr,model.beyonddate);
        if (model.isLastMonth) {
            if (_delegate &&[_delegate respondsToSelector:@selector(selectedItemByBeyond: date: isLast:)]) {
                [_delegate selectedItemByBeyond:[NSString stringWithFormat:@"%.lf",a] date:dateStr isLast:YES];
            }
        }else if (model.isNextMonth){
            if (_delegate &&[_delegate respondsToSelector:@selector(selectedItemByBeyond: date: isNext:)]) {
                [_delegate selectedItemByBeyond:[NSString stringWithFormat:@"%.lf",a] date:dateStr isNext:YES];
            }
        }
        NSLog(@"%@",dateStr);
       
        return;
    }
    YAItemOfdayCell *lastCell = [collectionView cellForItemAtIndexPath:self.lastIndexPath];
    lastCell.iSSelected = false;
    YAItemModel *mdel = self.dataAry[self.lastIndexPath.item];
    mdel.isSelected = false;
    if (lastCell!= nil) {
        [self.collectionView reloadItemsAtIndexPaths:@[self.lastIndexPath]];
    }
    
    YAItemOfdayCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.iSSelected = !cell.iSSelected;
    
    
    
    if (model.isSelected) {
        model.isSelected = false;
    }else{
        model.isSelected = YES;
    }
    
    self.lastIndexPath = indexPath;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    NSTimeInterval a=[model.date timeIntervalSince1970]-8*3600;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:model.date];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedItem: date:)]) {
        
        [_delegate selectedItem:[NSString stringWithFormat:@"%.lf",a] date:dateStr];
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:selectedDate] != nil) {
        [user removeObjectForKey:selectedDate];
    }
    [user setValue:dateStr forKey:selectedDate];
    [user synchronize];
    
    
}


@end
