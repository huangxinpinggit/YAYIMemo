//
//  YAAVPlayer.m
//  YAYIMemo
//
//  Created by hxp on 17/8/25.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAAVPlayer.h"

@implementation YAAVPlayer
+(instancetype)shareInstance
{
    static YAAVPlayer *managerPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (managerPlayer == nil) {
            managerPlayer = [[YAAVPlayer alloc] init];
        }
    });
    return managerPlayer;

}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self play];
        
    }
    return self;
}

-(AVPlayer *)player{
  if (_player == nil) {
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_url]];        //通过AVPlayerItem初始化player
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    }
    return _player;

}

-(void)setUrl:(NSString *)url
{
    _url = url;
    if (_player) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_url]];
        [_player replaceCurrentItemWithPlayerItem:item];
        [self.player play];
        
    }
}

-(void)play{
    if (_player != nil) {
        
         [self.player play];
    }
    //停止播放
}

-(void)pause{
   [self.player pause];
}

//观察者回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{   //注意这里查看的是self.player.status属性
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:{
                NSLog(@"未知转态");
            }
                break;
            case AVPlayerStatusReadyToPlay:{
                NSLog(@"准备播放");
            }
                break;
            case AVPlayerStatusFailed:{
                NSLog(@"加载失败");
            }
                break;
            default:
                break;
        }
    }
}

-(void)dealloc
{
   [self.player.currentItem removeObserver:self forKeyPath:@"status"];
}
-(void)playerItemDidReachEnd:(NSNotification *)notification{
    if (_playerCompleted) {
        self.playerCompleted();
    }
//    if (_delegate && [_delegate respondsToSelector:@selector(playerFinished)]) {
//        [_delegate playerFinished];
//    }
}
@end
