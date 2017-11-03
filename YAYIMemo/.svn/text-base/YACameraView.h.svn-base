//
//  YACameraView.h
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAVideoPreview.h"
@class YACameraView;
@protocol YACameraViewDelegate <NSObject>

/// 转换摄像头
-(void)swicthCameraAction:(YACameraView *)cameraView succ:(void(^)(void))succ fail:(void(^)(NSError *error))fail;
/// 取消
-(void)cancelAction:(YACameraView *)cameraView;
/// 拍照
-(void)takePhotoAction:(YACameraView *)cameraView;
/// 打开相册
-(void)takePhotoLibarray;

@end

@interface YACameraView : UIView
@property(nonatomic, weak) id <YACameraViewDelegate> delegate;
@property(nonatomic, strong) YAVideoPreview *previewView;
@end
