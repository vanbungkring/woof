//
//  OnboardingView.h
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardingView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *onboardingImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *startSearchButton;
@end
