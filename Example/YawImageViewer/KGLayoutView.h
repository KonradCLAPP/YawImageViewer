//
//  HBFLayoutView.h
//  YawImageViewer
//
//  Created by Konrad Gnoinski on 20/07/15.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//
#import "KGTiltView.h"

@interface KGLayoutView : KGTiltView

@property (strong, nonatomic) UILabel *articleTitleLabel;
@property (strong, nonatomic) UILabel *articleSubTitleLabel;
@property (strong, nonatomic) UILabel *articleNumberLabel;
@property (strong, nonatomic) UILabel *articleBulletFirstLabel;
@property (strong, nonatomic) UILabel *articleBulletSecondLabel;
@property (strong, nonatomic) UILabel *articleBulletThirdLabel;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;


@end
