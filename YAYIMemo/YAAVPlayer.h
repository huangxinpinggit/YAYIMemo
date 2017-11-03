//
//  YAAVPlayer.h
//  YAYIMemo
//
//  Created by hxp on 17/8/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^YAPlayerCompleted)();



@interface YAAVPlayer : NSObject
@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)AVPlayerItem *item;
@property (nonatomic, copy)YAPlayerCompleted playerCompleted;
+(instancetype)shareInstance;
-(void)pause;
-(void)play;
@end
