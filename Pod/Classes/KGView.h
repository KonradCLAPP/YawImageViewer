//
//  KGViewController.h
//  YawImageViewer
//
//  Created by KonraCLAPP on 07/17/2015.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KGViewController : UIViewController<UIScrollViewDelegate,CLLocationManagerDelegate>
{
    UIScrollView *myScrollView;
}

@property (strong, nonatomic) NSString *articlePhoto;
@property (strong, nonatomic) NSString *articleNumber;
@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) NSString *articleSubTitle;
@property (strong, nonatomic) NSString *articleBulletFirst;
@property (strong, nonatomic) NSString *articleBulletSecond;
@property (strong, nonatomic) NSString *articleBulletThird;
@property (strong, nonatomic) NSNumber *yawLevel;

@end
