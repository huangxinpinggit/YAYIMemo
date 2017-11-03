//
//  YARecorder.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YARecorder.h"

@interface YARecorder ()<AVAudioRecorderDelegate>
{
    NSTimer *_timer; //定时器
    NSInteger countDown;  //倒计时
    NSString *filePath;
    SCListener *listener;
    NSInteger _delayTime;
    NSInteger _audioduration;
}

@property(nonatomic, strong)NSURL *recordFileUrl;
@end

@implementation YARecorder

+(instancetype)shareInstance{
    static  YARecorder *recorder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recorder = [[YARecorder alloc] init];
    });
    return recorder;

}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _audioduration = 0;
    }
    return self;
}

-(AVAudioSession *)session
{
    NSError *sessionError;
    if (_session == nil) {
        _session = [AVAudioSession sharedInstance];
        [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
    }
    return _session;
}

-(AVAudioRecorder *)recorder
{
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];

    if (_recorder == nil) {
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
        _recorder.meteringEnabled = YES;
        _recorder.delegate = self;
        [_recorder prepareToRecord];
        [self.session setActive:YES error:nil];
    }
    return _recorder;
}

-(void)startrecorder{
    [self.recorder  record];
}
-(void)stopRecorder{
    [self.recorder stop];
    _recorder=nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];  //此处需要恢复设置回放标志，否则会导致其它播放声音也会变小
   

}

-(void)cancellRecorder{
    [self.recorder  deleteRecording];
    self.recorder.delegate = nil;
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    self.recorder = nil;
   [[AVAudioSession sharedInstance] setActive:NO error:nil];
    
}

#pragma mark ===================

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSURL *url = recorder.url;
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"%lf",data.length/1024.0);
     NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset*audioAsset=[AVURLAsset URLAssetWithURL:url options:opts];
    CMTime audioDuration=audioAsset.duration;
    NSInteger second= 0;
    second = ceil(CMTimeGetSeconds(audioDuration));
    if (second >2) {
        if (_delegate && [_delegate respondsToSelector:@selector(filepath: duration:)]) {
            [_delegate filepath:data duration:second];
        }
    }else{
        [NSString showInfoWithStatus:@"录音时间太短无法正常提交"];
    }
   

}
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{

}
@end
