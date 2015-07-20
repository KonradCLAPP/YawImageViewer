//
//  DemoViewController.m
//  YawImageViewer
//
//  Created by Konrad Gnoinski on 17/07/15.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import "DemoViewController.h"
#import "KGLayoutView.h"

@interface DemoViewController ()

@property (nonatomic, strong) KGLayoutView* motionView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionView = [[KGLayoutView alloc] initWithFrame:self.view.bounds image:[UIImage imageNamed:@"Image.jpg"]];
    [self.motionView setMotionEnabled:YES];
    self.motionView.yawTresholdLevel=[NSNumber numberWithDouble:0.07];
    [self.view addSubview:self.motionView];
    
    // JUST FOR Demo
    self.motionView.articleNumberLabel.text = @"1";
    self.motionView.articleTitleLabel.text = @"Gipfelharmonie";
    self.motionView.articleSubTitleLabel.text = @"und ein kleiner Streit";
    self.motionView.articleBulletFirstLabel.text = @"• Spionageaffäre. Klimaziele, Ukraine-Krise";
    self.motionView.articleBulletSecondLabel.text = @"• Eine Partnerschaft in Auf";
    self.motionView.articleBulletThirdLabel.text = @"• Die Wege haben sich getreent. kljfgk";
    // END JUST FOR Demo
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
