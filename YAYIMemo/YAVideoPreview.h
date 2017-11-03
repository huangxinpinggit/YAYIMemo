//
//  YAVideoPreview.h
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface YAVideoPreview : UIView
@property (strong, nonatomic) AVCaptureSession *captureSessionsion;

- (CGPoint)captureDevicePointForPoint:(CGPoint)point;

@end
