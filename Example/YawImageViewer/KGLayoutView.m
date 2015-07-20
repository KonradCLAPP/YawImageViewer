//
//  HBFLayoutView.m
//  YawImageViewer
//
//  Created by Konrad Gnoinski on 20/07/15.
//  Copyright (c) 2015 KonraCLAPP. All rights reserved.
//

#import "KGLayoutView.h"
#import "KGTiltView.h"

@implementation KGLayoutView

int spaceFromLeft = 8;
int spaceFromRight = -8;
int spaceBetweenHedlines = -4;
int spaceBeetweenHeadlinesAndTitles = -20;
int spaceBeetwenNumberAndTitle = 20;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self=[super initWithFrame:frame image:image];
    
    [self fillLabels];
    [self addConstraints];
    
    return self;
}


-(void)fillLabels{
    self.articleNumberLabel = [[UILabel alloc]init];
    [self.articleNumberLabel setFont:[UIFont systemFontOfSize:68]];
    self.articleNumberLabel.textColor=[UIColor whiteColor];
    [self.self addSubview: self.articleNumberLabel];
    //[self.self addCompactConstraint:@"articleNumberLabel.down = botto-50" metrics:nil views:nil];
    
    self.articleTitleLabel = [[UILabel alloc]init];
    [self.articleTitleLabel setFont:[UIFont systemFontOfSize:24]];
    self.articleTitleLabel.textColor=[UIColor whiteColor];
    [self.self addSubview: self.articleTitleLabel];
    
    self.articleSubTitleLabel = [[UILabel alloc]init];
    [self.articleSubTitleLabel setFont:[UIFont systemFontOfSize:20]];
    self.articleSubTitleLabel.textColor=[UIColor whiteColor];
    [self.self addSubview: self.articleSubTitleLabel];
    
    self.articleBulletFirstLabel = [[UILabel alloc]init];
    [self.articleBulletFirstLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletFirstLabel.textColor=[UIColor whiteColor];
    self.articleBulletFirstLabel.numberOfLines = 0;
    [self.self addSubview: self.articleBulletFirstLabel];
    
    self.articleBulletSecondLabel = [[UILabel alloc]init];
    [self.articleBulletSecondLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletSecondLabel.textColor=[UIColor whiteColor];
    self.articleBulletSecondLabel.numberOfLines = 0;
    [self.self addSubview: self.articleBulletSecondLabel];
    
    self.articleBulletThirdLabel = [[UILabel alloc]init];
    [self.articleBulletThirdLabel setFont:[UIFont systemFontOfSize:15]];
    self.articleBulletThirdLabel.textColor=[UIColor whiteColor];
    self.articleBulletThirdLabel.numberOfLines = 0;
    [self.self addSubview: self.articleBulletThirdLabel];
    
}

-(void) addConstraints{
    
    //    [self.articleBulletThirdLabel setBackgroundColor: [UIColor greenColor]];
    
    self.articleBulletThirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletThirdLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:-40]];
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletThirdLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:spaceFromLeft]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletThirdLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:spaceFromRight]];
    
    
    
    
    //    [self.articleBulletSecondLabel setBackgroundColor: [UIColor yellowColor]];
    
    self.articleBulletSecondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletSecondLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleBulletThirdLabel
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:spaceBetweenHedlines]];
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletSecondLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:spaceFromLeft]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletSecondLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:spaceFromRight]];
    
    
    
    //    [self.articleBulletFirstLabel setBackgroundColor: [UIColor blueColor]];
    self.articleBulletFirstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletFirstLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleBulletSecondLabel
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:spaceBetweenHedlines]];
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletFirstLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:spaceFromLeft]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleBulletFirstLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:spaceFromRight]];
    
    
    
    
    //    [self.articleNumberLabel setBackgroundColor:[UIColor redColor]];
    self.articleNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleBulletFirstLabel
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:spaceBeetweenHeadlinesAndTitles]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:spaceFromLeft]];
    
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint constraintWithItem:self.articleNumberLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.self
                                 attribute:NSLayoutAttributeWidth
                                multiplier:0.1
                                  constant:0.0];
    
    constraint.priority = 800;
    
    [self addConstraint:constraint];
    
    [self.articleNumberLabel setContentCompressionResistancePriority:900 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    
    //        [self.articleSubTitleLabel setBackgroundColor:[UIColor orangeColor]];
    self.articleSubTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleSubTitleLabel
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:0.5
                                                            constant:0]];
    
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleSubTitleLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleBulletFirstLabel
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:spaceBeetweenHeadlinesAndTitles]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleSubTitleLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:spaceBeetwenNumberAndTitle]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleSubTitleLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:spaceFromRight]];
    
    
    
    
    //    [self.articleTitleLabel setBackgroundColor:[UIColor purpleColor]];
    self.articleTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleTitleLabel
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:0.5
                                                            constant:0]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleTitleLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleSubTitleLabel
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleTitleLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.articleNumberLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:spaceBeetwenNumberAndTitle]];
    
    [self.self addConstraint: [NSLayoutConstraint constraintWithItem:self.articleTitleLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:spaceFromRight]];
    
}

@end
