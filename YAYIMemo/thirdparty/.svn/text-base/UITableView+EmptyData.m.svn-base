//
//  UITableView+EmptyData.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/29.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)
-(void)tableViewDisplayWitMsg:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount
{
    if (rowCount == 0) {
        //Display a message when the table is empty
        //没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
