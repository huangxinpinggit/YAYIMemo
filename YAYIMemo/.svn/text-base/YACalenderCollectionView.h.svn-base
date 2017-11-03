//
//  YACalenderCollectionView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAItemOfdayCell.h"

@protocol YACalenderCollectionViewDelegate <NSObject>

-(void)selectedItem:(NSString *)worktime date:(NSString *)date;
-(void)selectedItemByBeyond:(NSString *)worktime date:(NSString *)date isNext:(BOOL)isNext;
-(void)selectedItemByBeyond:(NSString *)worktime date:(NSString *)date isLast:(BOOL)isLast;
@end

@interface YACalenderCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)NSMutableArray *dateArray;
@property (nonatomic, weak)id<YACalenderCollectionViewDelegate> delegate;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, strong)NSDate *date;
@property (nonatomic, assign)NSInteger year;
@property (nonatomic,  strong)NSIndexPath *lastIndexPath;
-(void)loadData:(NSDate *)date;
@end
