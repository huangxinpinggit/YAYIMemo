//
//  YARecorderView.m
//  YAYIMemo
//
//  Created by MR.H on 2017/9/17.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YARecorderView.h"

@implementation YARecorderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    self.recorder = [YARecorder shareInstance];
        NSLog(@"%@",self.recorder);
    self.recorder.delegate = self;
        
    }
    return self;
}

-(void)startAnimal{
    /*
    CALayer * spreadLayer;
    spreadLayer = [CALayer layer];
    CGFloat diameter = 80;  //扩散的大小
    spreadLayer.bounds = CGRectMake(0,0, diameter, diameter);
    spreadLayer.cornerRadius = diameter/2; //设置圆角变为圆形
    spreadLayer.position = CGPointMake(SCREEN_W/2.0, 100);
    spreadLayer.backgroundColor = [YA_ALPHA_COLOR(0, 0, 0, 0.3) CGColor];
    [self.contentView.layer insertSublayer:spreadLayer below:self.imageView.layer];//把扩散层放到头像按钮下面
    CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 4;
    animationGroup.repeatCount = INFINITY;//重复无限次
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = defaultCurve;
    //尺寸比例动画

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7;//开始的大小
    scaleAnimation.toValue = @2.2;//最后的大小
    
    scaleAnimation.duration = 4.0;//动画持续时间
     
    
//    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
//    scaleAnimation.values = @[@0.7,@0.9,@1.2,@2.2];
//    scaleAnimation.keyTimes =@[@0, @0.5,@0.5,@1];
//    scaleAnimation.duration = 2;
    //透明度动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 4;
    opacityAnimation.values = @[@0.4, @0.45,@0.4,@0];//透明度值的设置
    opacityAnimation.keyTimes = @[@0, @0.5,@0.5,@1];//关键帧
    opacityAnimation.removedOnCompletion = NO;
    animationGroup.animations = @[scaleAnimation, opacityAnimation];//添加到动画组
    [spreadLayer addAnimation:animationGroup forKey:@"pulse"];
    [self performSelector:@selector(removeRippleLayer:) withObject:spreadLayer afterDelay:5.0];
     */
    UIView *circleView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_W/2.0, 40, 200, 200)];
   
    circleView.center = CGPointMake(SCREEN_W/2.0, 100*YAYIScreenScale);
    self.circleView = circleView;
    [self.contentView addSubview:circleView];
    [self.contentView.layer insertSublayer:circleView.layer below:self.imageView.layer];
    
    circleView.layer.backgroundColor = [UIColor clearColor].CGColor;
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = circleView.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = [YA_ALPHA_COLOR(0, 0, 0, 0.3) CGColor];//填充色
    pulseLayer.opacity = 0.0;
    
    //可以复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = circleView.bounds;
    replicatorLayer.instanceCount = 4;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [circleView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
    
    
}
- (void)removeRippleLayer:(CALayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

-(UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.alpha = 1;
        _bgView.frame = [UIScreen mainScreen].bounds;
        _bgView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.0];
       
        _bgView.userInteractionEnabled = YES;
        
    }
    return _bgView;
}

-(void)createRecoderView{
    UIImageView *voice = [[UIImageView alloc]init];
    voice.image = [UIImage imageNamed:@"two"];
    voice.userInteractionEnabled = NO;
    voice.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:voice];
    voice.frame = CGRectMake(0, 0, voice.image.size.width, voice.image.size.height);
    voice.center = CGPointMake(SCREEN_W/2.0, 100*YAYIScreenScale);
    
    self.imageView = voice;
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"正在录音...";
    titleLab.textColor = YAColor(@"#8a8a8a");
    titleLab.font = YAFont(15);
    [self.contentView addSubview:titleLab];
    [titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-53*YAYIScreenScale));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    NSArray *titleAry = @[@"取消",@"发布"];
    for (int i = 0; i< 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        [button setTitleColor:YAColor(@"#424242") forState:UIControlStateNormal];
        button.titleLabel.font = YAFont(15);
        button.tag = 101+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(i*((SCREEN_W-100)/2.0+70)+15, 200*YAYIScreenScale, (SCREEN_W -100)/2.0, 40*YAYIScreenScale);
    }
    
}

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [UIView  new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(0, SCREEN_H - 240*YAYIScreenScale, SCREEN_W, 240*YAYIScreenScale);
    }
    return _contentView;

}
-(void)addTimer{

    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(startAnimal) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
-(void)show{

    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    
    [self createRecoderView];
    [self startAnimal];
    //[self addTimer];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    gesture.numberOfTapsRequired = 1;
    [self.bgView addGestureRecognizer:gesture];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
    }];
    self.contentView.transform = CGAffineTransformMakeTranslation(0.01, SCREEN_H);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
        
    }];
    
     [self.recorder  startrecorder];
   

}
-(void)dismiss{
    [_timer invalidate];
    _timer = nil;
    self.circleView.alpha = 0;
    [self.circleView.layer removeAllAnimations];
    [self.circleView.layer removeFromSuperlayer];
    [self.circleView removeFromSuperview];
    [self.imageView stopAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0.01, SCREEN_H);
        self.contentView.alpha = 0.2;
        self.imageView.alpha = 0.2;
        self.bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        
        [self.bgView removeFromSuperview];
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
    }];


}

-(void)buttonAction:(UIButton *)sender{
    if (sender.tag == 101) {
        [self.recorder cancellRecorder];
        [self dismiss];
        
        //取消
    }else{
        [self.recorder stopRecorder];
        [self dismiss];
        //提交
    }

}
-(void)stopAnimal
{
    [self dismiss];
    self.recorder = nil;
}
-(void)filepath:(NSData *)data duration:(NSInteger)duration
{
    
    if(_delegate && [_delegate respondsToSelector:@selector(recorderFinished: duration:)]){
        [_delegate recorderFinished:data duration:duration];
    }
}
@end
