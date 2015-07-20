//
//  KGViewController.m
//  YawImageViewer
//
//  Created by KonraCLAPP on 07/17/2015.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import "KGViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface KGViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleBulletFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleBulletSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleBulletThirdLabel;
@property (strong, nonatomic) UIView *progresBarEntire;
@property (strong, nonatomic) UIView *progresBarLine;
@property (weak, nonatomic) UIImage *image;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *deviceQueue;
@property (nonatomic) float motionLastYaw;
@end

@implementation KGViewController
bool isAnimationFinished = true;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // JUST FOR TESTING
    self.articleNumber = @"1";
    self.articleTitle = @"Gipfelharmonie";
    self.articleSubTitle = @"und ein kleiner Streit";
    self.articleBulletFirst = @"• Spionageaffäre. Klimaziele, Ukraine-Krise";
    self.articleBulletSecond = @"• Eine Partnerschaft in Auflösung";
    self.articleBulletThird = @"• Die Wege haben sich getreent.";
    self.articlePhoto = @"Image.jpg";
    self.yawLevel = [NSNumber numberWithFloat: 0.04];
    // END JUST FOR TESTING
    
    [self addScrollView];
    [self fillLabels];
    [self progressBar];
    [self setUpMotionManager];
}

- (void)dealloc {
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)addScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    self.image = [UIImage imageNamed:self.articlePhoto];
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.image.size.width/self.image.size.height*self.view.bounds.size.height, self.view.bounds.size.height)];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgView setImage:self.image];
    [self.scrollView addSubview:self.imgView];
    
    self.scrollView.contentSize = self.imgView.frame.size;
    self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/2) - (self.scrollView.bounds.size.width/2),0);
    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

-(void)fillLabels{
    [self.articleNumberLabel setFont:[UIFont systemFontOfSize:68]];
    self.articleNumberLabel.text = self.articleNumber;
    self.articleNumberLabel.textColor=[UIColor whiteColor];
    
    [self.articleTitleLabel setFont:[UIFont systemFontOfSize:24]];
    self.articleTitleLabel.text = self.articleTitle;
    self.articleTitleLabel.textColor=[UIColor whiteColor];
    
    [self.articleSubTitleLabel setFont:[UIFont systemFontOfSize:20]];
    self.articleSubTitleLabel.text = self.articleSubTitle;
    self.articleSubTitleLabel.textColor=[UIColor whiteColor];
    
    [self.articleBulletFirstLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletFirstLabel.text = self.articleBulletFirst;
    self.articleBulletFirstLabel.textColor=[UIColor whiteColor];
    
    [self.articleBulletSecondLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletSecondLabel.text = self.articleBulletSecond;
    self.articleBulletSecondLabel.textColor=[UIColor whiteColor];
    
    [self.articleBulletThirdLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletThirdLabel.text = self.articleBulletThird;
    self.articleBulletThirdLabel.textColor=[UIColor whiteColor];
}

- (void)progressBar{
    self.progresBarEntire = [[UIView alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height-25, self.view.bounds.size.width-20, 2)];
    self.progresBarEntire.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.progresBarEntire];
    
    CGFloat progressBarLineWidth = ceil(self.view.bounds.size.width/3);
    self.progresBarLine = [[UIView alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.progresBarEntire.bounds) - progressBarLineWidth/2,0, progressBarLineWidth, CGRectGetHeight(self.progresBarEntire.bounds))];
    self.progresBarLine.backgroundColor = [UIColor whiteColor];
    [self.progresBarEntire addSubview:self.progresBarLine];
}

- (void)setUpMotionManager{
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical];
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
             NSLog(@"yaw: %f  %f", yaw, x);
             
             if (isAnimationFinished) {
                 
                 isAnimationFinished = false;
                 if (yaw > [self.yawLevel doubleValue]) {//works great till 0.01
                     [self AnimateLeft];
                 }else if (yaw < -[self.yawLevel doubleValue]){//works great till -0.01
                     [self AnimateRight];
                 }else{
                     [self AnimateCenter];
                 }
                 
             }
         }];
     }];
    if (error) {
        NSLog(@"There is some problem with motion manager");
    }
}

- (void) AnimateLeft{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0,0);
        self.progresBarLine.transform = CGAffineTransformMakeTranslation(self.progresBarEntire.bounds.size.width/3, 0);
    } completion:^(BOOL finished) {
        isAnimationFinished = true;
    }];
}

- (void) AnimateRight{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/self.imgView.bounds.size.height*self.view.bounds.size.height)-self.view.bounds.size.width,0);
        self.progresBarLine.transform = CGAffineTransformMakeTranslation(-self.progresBarEntire.bounds.size.width/3, 0);
    } completion:^(BOOL finished) {
        isAnimationFinished = true;
    }];
}

- (void) AnimateCenter{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width/2) - (self.scrollView.bounds.size.width/2),0);
        self.progresBarLine.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        isAnimationFinished = true;
    }];
}

@end
