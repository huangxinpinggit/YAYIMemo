//
//  NSArray+YA.m
//  YAYIMemo
//
//  Created by hxp on 17/9/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "NSArray+YA.h"

@implementation NSArray (YA)
- (id)h_safeObjectAtIndex:(NSUInteger)index{
    if(self.count ==0) {
        NSLog(@"--- mutableArray have no objects ---");
        return (nil);
    }
    if(index >MAX(self.count -1,0)) {
        NSLog(@"--- index:%li out of mutableArray range ---", (long)index);
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

@end
