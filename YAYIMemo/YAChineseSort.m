//
//  YAChineseSort.m
//  YAYIMemo
//
//  Created by hxp on 17/8/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAChineseSort.h"

@implementation YAChineseSort
/*
+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array{
    NSMutableArray *ans = [[NSMutableArray alloc] init];
    
    NSArray *serializeArray = [(NSArray *)array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {//排序
        int i;
        NSString *strA = ((YAYIMyPatientItem *)obj1).pinyin;
        NSString *strB = ((YAYIMyPatientItem *)obj2).pinyin;
        for (i = 0; i < strA.length && i < strB.length; i++) {
            char a = [strA characterAtIndex:i];
            char b = [strB characterAtIndex:i];
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;//上升
            }
            else if (a < b)
            {
                return (NSComparisonResult)NSOrderedAscending;//下降
            }
        }
        
        if (strA.length > strB.length)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }else if (strA.length < strB.length)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    char lastC = '1';
    NSMutableArray *data;
    NSMutableArray *oth = [[NSMutableArray alloc] init];
    for (YAYIMyPatientItem *user in serializeArray)
    {
        char c = [user.pinyin characterAtIndex:0];
        if (!isalpha(c)) {
            [oth addObject:user];
        }
        else if (c != lastC){
            lastC = c;
            if (data && data.count > 0) {
                [ans addObject:data];
            }
            
            data = [[NSMutableArray alloc] init];
            [data addObject:user];
        }
        else {
            [data addObject:user];
        }
    }
    if (data && data.count > 0)
    {
        [ans addObject:data];
    }
    if (oth.count > 0)
    {
        [ans addObject:oth];
    }
    return ans;
}


+ (NSMutableArray *)getFriendListSectionBy:(NSMutableArray *)array{
    
    NSMutableArray *section = [[NSMutableArray alloc] init];
    [section addObject:UITableViewIndexSearch];
    for (NSArray *item in array)
    {
        YAYIMyPatientItem *user = [item objectAtIndex:0];
        char c = [user.pinyin characterAtIndex:0];
        if (!isalpha(c)) {
            c = '#';
        }
        [section addObject:[NSString stringWithFormat:@"%c", toupper(c)]];
    }
    return section;
    
}
 */
@end
