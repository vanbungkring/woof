//
//  OnboardingViewController.h
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, OnboardingScreenType) {
    OnboardingScreenTypeWelcome,
    OnboardingScreenTypeWhatsNew,
    OnboardingScreenTypeSendEticket,
    OnboardingScreenTypePushNotif,
    OnboardingScreenTypeLocation,
    OnboardingScreenTypeCountry
};
@class OnboardingViewController;

@protocol OnboardingViewControllerDelegate <NSObject>

- (void)onboardingViewControllerNext:(OnboardingViewController*)onboardingViewController;
- (void)onboardingViewControllerDismiss:(OnboardingViewController*)onboardingViewController;
- (void)onboardingViewControllerSkip:(OnboardingViewController*)onboardingViewController;

@end

@interface OnboardingViewController : UIViewController
- (instancetype)initWithOnboardingScreenType:(OnboardingScreenType)screenType;

@property (assign, nonatomic) OnboardingScreenType screenType;
@property (strong, nonatomic) id<OnboardingViewControllerDelegate> delegate;

@end
