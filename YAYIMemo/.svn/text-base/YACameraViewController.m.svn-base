//
//  YAPhotoViewController.m
//  YAYIMemo
//
//  Created by hxp on 17/9/11.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YACameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YACameraView.h"
#import "CCMotionManager.h"
#import "YACameraImageController.h"
@interface YACameraViewController ()<YACameraViewDelegate,TZImagePickerControllerDelegate>
{
    // 输入
    AVCaptureDeviceInput      *_deviceInput;
}

@property (nonatomic, strong)AVCaptureSession *captureSession;
@property (nonatomic, strong)YACameraView *cameraView;
@property (nonatomic, strong)AVCaptureStillImageOutput *imageOutput;
@property(nonatomic, strong) AVCaptureDevice *activeCamera;     // 当前输入设备
@property(nonatomic, strong) AVCaptureDevice *inactiveCamera;   // 不活跃的设备(这里指前摄像头或后摄像头，不包括外接输入设备)
@property(nonatomic, assign) AVCaptureVideoOrientation	referenceOrientation; // 视频播放方向
@property(nonatomic, strong) CCMotionManager *motionManager;
@end

@implementation YACameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _referenceOrientation = AVCaptureVideoOrientationPortrait;
    
    self.captureSession = [[AVCaptureSession alloc]init];
    [self.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
    //显示视图
    self.cameraView = [[YACameraView alloc] initWithFrame:self.view.bounds];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         // 处理耗时操作的代码块...
        NSError *error;
        [self setupSession:&error];
        if (!error) {
            [self.cameraView.previewView setCaptureSessionsion:_captureSession];
            [self startCaptureSession];
        }
        else{
            YA_LOG(error);
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            
        });
        
    });
    
    
    for (UIGestureRecognizer *gesture in self.navigationController.view.gestureRecognizers) {
        [self.navigationController.view removeGestureRecognizer:gesture];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}

#pragma mark - 输入设备(摄像头)
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)activeCamera
{
    return _deviceInput.device;
}

- (AVCaptureDevice *)inactiveCamera
{
    AVCaptureDevice *device = nil;
    if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }
        else{
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

#pragma mark - AVCaptureSession
// 配置会话
- (void)setupSession:(NSError **)error
{
    _captureSession = [[AVCaptureSession alloc]init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [self setupSessionInputs:error];
    [self setupSessionOutputs:error];
    
}
// 添加输入
- (void)setupSessionInputs:(NSError **)error
{
    // 添加输入设备
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_captureSession canAddInput:videoInput]){
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        }
    }
}
// 添加输出
- (void)setupSessionOutputs:(NSError **)error
{
   
    
    // 静态图片输出
    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
    imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([_captureSession canAddOutput:imageOutput]) {
        [_captureSession addOutput:imageOutput];
        _imageOutput = imageOutput;
    }
}
// 开启捕捉
- (void)startCaptureSession
{
    if (!_captureSession.isRunning){
        [_captureSession startRunning];
    }
}

// 停止捕捉
- (void)stopCaptureSession
{
    if (_captureSession.isRunning){
        [_captureSession stopRunning];
    }
}

#pragma mark - 拍摄照片
-(void)takePictureImage{
    __weak typeof(self) weaKSelf = self;
    AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection.isVideoOrientationSupported) {
        connection.videoOrientation = [self currentVideoOrientation];
    }
    id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
        if (sampleBuffer == NULL) {
    
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
        UIImage *image = [[UIImage alloc]initWithData:imageData];
        __weak typeof(self) weakSelf = self;
        YACameraImageController *vc = [[YACameraImageController alloc] initWithImage:image frame:self.cameraView.previewView.frame];
        vc.userid = weaKSelf.userid;
        vc.camareOperation = ^{
            [weaKSelf.captureSession startRunning];
        };
        vc.refreshedOperation = ^{
            if (weakSelf.refreshedOperation) {
                weakSelf.refreshedOperation();
            }
        
        };
        [self.navigationController pushViewController:vc animated:YES];
        [self.captureSession stopRunning];
        
    };
    [_imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:takePictureSuccess];
}
#pragma mark - 转换前后摄像头
- (void)swicthCameraAction:(YACameraView *)cameraView succ:(void (^)(void))succ fail:(void (^)(NSError *))fail
{
    id error = [self switchCameras];
    error?!fail?:fail(error):!succ?:succ();
}
- (BOOL)canSwitchCameras
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

- (id)switchCameras
{
    if (![self canSwitchCameras]) return nil;
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        [_captureSession beginConfiguration];
        [_captureSession removeInput:_deviceInput];
        if ([_captureSession canAddInput:videoInput]) {
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        }
        [_captureSession commitConfiguration];
        
        
        
        // 由于前置摄像头不支持视频，所以当你转换到前置摄像头时，视频输出就无效了，所以在转换回来时，需要把原来的删除了，在重新加一个新的进去
        [_captureSession beginConfiguration];
        
        
        AVCaptureVideoDataOutput *videoOut = [[AVCaptureVideoDataOutput alloc] init];
        [videoOut setAlwaysDiscardsLateVideoFrames:YES];
        [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
        dispatch_queue_t videoCaptureQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
        [videoOut setSampleBufferDelegate:self queue:videoCaptureQueue];
        
       
        [_captureSession commitConfiguration];
        return nil;
    }
    return error;
}
#pragma mark - 取消拍照
- (void)cancelAction:(YACameraView *)cameraView{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 打开相册
-(void)takePhotoLibarray
{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [self.captureSession stopRunning];
    imagePicker.barItemTextColor = YAColor(@"#424242");
    imagePicker.naviTitleColor = YAColor(@"#424242");
    imagePicker.naviBgColor = [UIColor whiteColor];
    //[self.navigationController pushViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];

    

}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {

    [self commitNet:photos];
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{

    [self.captureSession startRunning];
}
#pragma mark - 拍照/录影点击事件
- (void)takePhotoAction:(YACameraView *)cameraView
{
    [self takePictureImage];
}
#pragma mark - Private methods
// 调整设备取向
- (AVCaptureVideoOrientation)currentVideoOrientation{
    AVCaptureVideoOrientation orientation;
    switch (self.motionManager.deviceOrientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
    }
    return orientation;
}


-(void)commitNet:(NSArray *)imageAry{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"0";
    param[@"userid"]= self.userid;
    
    
    
    
    
    NSLog(@"%ld",imageAry.count);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableString *str = [NSMutableString string];
        for (int i=0;i<imageAry.count;i++) {
            UIImage *image = imageAry[i];
            NSString *imageStr = [self return32LetterAndNumber];
            NSData *data =   UIImageJPEGRepresentation(image, 0.5);
            [[AliyunOSSObject sharedInstance] uploadObjectAsyc:nil imageData:data file:imageStr success:^(NSString *url) {
                NSLog(@"%@",url);
                [str appendString:url];
                NSArray *ary = [str componentsSeparatedByString:@","];
                if (ary.count == imageAry.count) {
                    param[@"info"] = str;
                    NSLog(@"============================%@",str);
                    [YAHttpBase POST:case_insert_url parameters:param success:^(id responseObject, int code) {
                        NSString *message = responseObject[@"message"];
                        [SVProgressHUD showSuccessWithStatus:message];
                        if (weakSelf.refreshedOperation) {
                            weakSelf.refreshedOperation();
                        }
                        
                        
                    } failure:^(NSError *error) {
                        
                    }];
                    
                }else{
                   [str appendString:@","];
                }
                
            } fail:^(BOOL fal) {
                
            }];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.refreshedOperation) {
                self.refreshedOperation();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        });
        
    });
    
    
    
    
    
    
    
}
-(NSString *)return32LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 32; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}


@end
