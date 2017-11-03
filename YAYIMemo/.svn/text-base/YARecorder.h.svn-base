//
//  YARecorder.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SCListener.h"
//application/octet-stream
@protocol YARecorderDelegate <NSObject>
-(void)stopAnimal;
-(void)filepath:(NSData *)data duration:(NSInteger)duration;
@end

@interface YARecorder : NSObject
@property (nonatomic, weak)id <YARecorderDelegate>delegate;
@property(nonatomic, strong)AVAudioSession *session;
@property(nonatomic, strong)AVAudioRecorder *recorder;//录音器
+(instancetype)shareInstance;
-(void)startrecorder;
-(void)stopRecorder;
-(void)cancellRecorder;
@end
