//
//  YARecorderView.h
//  YAYIMemo
//
//  Created by MR.H on 2017/9/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YARecorder.h"

@protocol  YARecorderViewDelegate <NSObject>

-(void)recorderFinished:(NSData *)data duration:(NSInteger)duration;

@end

@interface YARecorderView : UIView<YARecorderDelegate>
{
    NSTimer *_timer;
    NSInteger _duration;
}
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, strong)YARecorder *recorder;
@property (nonatomic, weak)UIView *circleView;
@property (nonatomic, weak)id<YARecorderViewDelegate> delegate;
-(void)show;
-(void)dismiss;
@end
