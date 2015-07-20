//
//  KGTiltView.h
//  YawImageViewer
//
//  Created by KonraCLAPP on 07/17/2015.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KGTiltView : UIView<UIScrollViewDelegate,CLLocationManagerDelegate>
{
    UIScrollView *myScrollView;
}

@property (nonatomic, assign, getter = isMotionEnabled) BOOL motionEnabled;
@property (nonatomic, assign, getter = isProgressBarVisable) BOOL progressBarVisable;
@property (strong, nonatomic) NSNumber *yawTresholdLevel;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

@end