//
//  KGTiltView.m
//  YawImageViewer
//
//  Created by KonraCLAPP on 07/17/2015.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import "KGTiltView.h"
#import <CoreMotion/CoreMotion.h>

@interface KGTiltView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIView *progresBarEntire;
@property (strong, nonatomic) UIView *progresBarLine;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *deviceQueue;
@property (nonatomic) float motionLastYaw;
@end

@implementation KGTiltView

- (void)commonInit
{
    [self addScrollView];
    [self progressBar];
    [self setUpMotionManager];
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setScrollImage:image];
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    [self.motionManager stopDeviceMotionUpdates];
}

-(void)addScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.self.bounds.size.width, self.self.bounds.size.height)];
    [self.scrollView addSubview:self.imgView];
    self.scrollView.contentSize = self.imgView.frame.size;
    self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/2) - (self.scrollView.bounds.size.width/2),0);
    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    [self.self addSubview:self.scrollView];
}

- (void)progressBar{
    self.progresBarEntire = [[UIView alloc]initWithFrame:CGRectMake(10, self.self.bounds.size.height-25, self.self.bounds.size.width-20, 2)];
    self.progresBarEntire.backgroundColor = [UIColor lightGrayColor];
    [self.self addSubview:self.progresBarEntire];
    
    CGFloat progressBarLineWidth = ceil(self.self.bounds.size.width/3);
    self.progresBarLine = [[UIView alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.progresBarEntire.bounds) - progressBarLineWidth/2,0, progressBarLineWidth, CGRectGetHeight(self.progresBarEntire.bounds))];
    self.progresBarLine.backgroundColor = [UIColor whiteColor];
    [self.progresBarEntire addSubview:self.progresBarLine];
}

- (void)setUpMotionManager{
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical];
}


- (void)setScrollImage:(UIImage *)image
{
    self.imgView = [[UIImageView alloc]initWithImage:image];
    [self.imgView setFrame: CGRectMake(0, 0, image.size.width/image.size.height*self.self.bounds.size.height, self.self.bounds.size.height)];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setMotionEnabled:(BOOL)motionEnabled
{
    _motionEnabled = motionEnabled;
    if (_motionEnabled) {
        [self startMonitoring];
    } else {
        [self stopMonitoring];
    }
}

- (void)setProgressBarVisable:(BOOL)progressBarVisable
{
    _progressBarVisable = progressBarVisable;
    if (_progressBarVisable) {
        self.progresBarEntire.alpha = 1.0;
        self.progresBarLine.alpha = 1.0;
    } else {
        self.progresBarEntire.alpha = 0.0;
        self.progresBarLine.alpha = 0.0;
    }
}

- (void)startMonitoring{
    self.deviceQueue = [[NSOperationQueue alloc] init];
    NSError *error = nil;
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                                            toQueue:self.deviceQueue
                                                        withHandler:^(CMDeviceMotion *motion, NSError *error)
     {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             CMQuaternion Quaternion = self.motionManager.deviceMotion.attitude.quaternion;
             double yaw = asin(2*(Quaternion.x*Quaternion.z - Quaternion.w*Quaternion.y));
             
             if (self.motionLastYaw == 0) {
                 self.motionLastYaw = yaw;
             }
             
             // kalman filtering
             static float q = 0.1;   // process noise
             static float r = 0.1;   // sensor noise
             static float p = 0.1;   // estimated error
             static float k = 0.5;   // kalman filter gain
             
             float x = self.motionLastYaw;
             p = p + q;
             k = p / (p + r);
             x = x + k*(yaw - x);
             p = (1 - k)*p;
             self.motionLastYaw = x;
             //NSLog(@"yaw: %f  %f", yaw, x);
             
             if (yaw > [self.yawTresholdLevel doubleValue]) {//works great till 0.01
                 [self AnimateLeft];
             }else if (yaw < -[self.yawTresholdLevel doubleValue]){//works great till -0.01
                 [self AnimateRight];
             }else{
                 [self AnimateCenter];
             }
             
             //             }
         }];
     }];
    if (error) {
        NSLog(@"There is some problem with motion manager");
    }
}

-(void) stopMonitoring{
    [self.motionManager stopDeviceMotionUpdates];
}

- (void) AnimateLeft{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0,0);
        self.progresBarLine.transform = CGAffineTransformMakeTranslation(self.progresBarEntire.bounds.size.width/3, 0);
    }];
}

- (void) AnimateRight{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/self.imgView.bounds.size.height*self.self.bounds.size.height)-self.self.bounds.size.width,0);
        self.progresBarLine.transform = CGAffineTransformMakeTranslation(-self.progresBarEntire.bounds.size.width/3, 0);
    }];
}

- (void) AnimateCenter{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/2) - (self.scrollView.bounds.size.width/2),0);
        self.progresBarLine.transform = CGAffineTransformIdentity;
    }];
}


@end
