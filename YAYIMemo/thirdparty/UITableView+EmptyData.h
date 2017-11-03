//
//  UITableView+EmptyData.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)
-(void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;
@end
