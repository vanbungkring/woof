//
//  OnboardingViewController.m
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "OnboardingViewController.h"
#import "OnboardingView.h"
#import "LocationManager.h"
#import "AppDelegate.h"

@interface OnboardingViewController ()<LocationManagerDelegate>

@property (strong, nonatomic) OnboardingView *view;
@property (strong, nonatomic) LocationManager *locationManager;

@end

@implementation OnboardingViewController

@dynamic view;

- (instancetype)initWithOnboardingScreenType:(OnboardingScreenType)screenType {
    self = [super initWithNibName:@"OnboardingViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.screenType = screenType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.screenType) {
        case OnboardingScreenTypeWelcome:
            self.view.titleLabel.text = NSLocalizedString(@"Welcome!", nil);
            self.view.descriptionLabel.text = NSLocalizedString(@"With the new Chopchop app, you're just a few steps away from finding the best prices of deals in your city and also worldwide.", nil);
            [self.view.leftButton setTitle:NSLocalizedString(@"Skip", nil) forState:UIControlStateNormal];
            [self.view.rightButton setTitle:NSLocalizedString(@"What's New?", nil) forState:UIControlStateNormal];
            break;
        case OnboardingScreenTypeWhatsNew:
            self.view.titleLabel.text = NSLocalizedString(@"What's New (and Cool)?", nil);
            self.view.descriptionLabel.text = NSLocalizedString(@"Through Bookmark, accessing your saved deals is now easier than ever.", nil);
            [self.view.leftButton setTitle:NSLocalizedString(@"Skip", nil) forState:UIControlStateNormal];
            [self.view.rightButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
            break;
        case OnboardingScreenTypeSendEticket:
            self.view.titleLabel.text = @"";
            self.view.descriptionLabel.text = NSLocalizedString(@"Need a discount alert? yes we're awesome on it", nil);
            [self.view.leftButton setTitle:NSLocalizedString(@"Skip", nil) forState:UIControlStateNormal];
            [self.view.rightButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
            break;
        case OnboardingScreenTypePushNotif:
            self.view.titleLabel.text = NSLocalizedString(@"Be the First to Know", nil);
            self.view.descriptionLabel.text = NSLocalizedString(@"Do you want to receive updates about app-only deals and special promotions?", nil);
            [self.view.leftButton setTitle:NSLocalizedString(@"Not Now", nil) forState:UIControlStateNormal];
            //            UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
            //            if (![UIApplication sharedApplication].isRegisteredForRemoteNotifications) {
            [self.view.rightButton setTitle:NSLocalizedString(@"Yes, Please!", nil) forState:UIControlStateNormal];
            //            }
            //            else if (types == UIRemoteNotificationTypeAlert || types == UIRemoteNotificationTypeBadge) {
            //                [self.view.rightButton setTitle:NSLocalizedString(@"Activated!", nil) forState:UIControlStateNormal];
            //            }
            break;
        case OnboardingScreenTypeLocation:
            self.view.titleLabel.text = NSLocalizedString(@"Get Accurate & Faster Result", nil);
            self.view.descriptionLabel.text = NSLocalizedString(@"Would you like to accurately determine your location to get accurate and faster search results?", nil);
            [self.view.leftButton setTitle:NSLocalizedString(@"Not Now", nil) forState:UIControlStateNormal];
            if (![LocationManager isLocationServiceDetermined]) {
                [self.view.rightButton setTitle:NSLocalizedString(@"Sounds Good!", nil) forState:UIControlStateNormal];
            }
            else if ([LocationManager isLocationServiceAuthorized]){
                [self.view.rightButton setTitle:NSLocalizedString(@"Authorized!", nil) forState:UIControlStateNormal];
            }
            else {
                [self.view.rightButton setTitle:NSLocalizedString(@"Not Authorized!", nil) forState:UIControlStateNormal];
            }
            break;
        case OnboardingScreenTypeCountry:
            self.view.titleLabel.text = NSLocalizedString(@"Customize Your Experience!", nil);
//            self.view.descriptionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Your location is detected as: %@\nTo ensure that you get relevant deals and pay in your local currency, simply change your preferred country in Settings. ", nil), [PreferredCountryResponse currentPreferredCountry].label];
            [self.view.leftButton setTitle:@"" forState:UIControlStateNormal];
            [self.view.rightButton setTitle:@"" forState:UIControlStateNormal];
            self.view.startSearchButton.hidden = NO;
            break;
        default:
            break;
    }
    self.view.onboardingImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"screen_%u", self.screenType + 1]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)leftButtonTapped:(id)sender {
    switch (self.screenType) {
        case OnboardingScreenTypePushNotif:
            if ([self.delegate respondsToSelector:@selector(onboardingViewControllerNext:)]) {
                [self.delegate onboardingViewControllerNext:self];
            }
            break;
        case OnboardingScreenTypeLocation:
            if ([self.delegate respondsToSelector:@selector(onboardingViewControllerNext:)]) {
                [self.delegate onboardingViewControllerNext:self];
            }
            break;
        default:
            if ([self.delegate respondsToSelector:@selector(onboardingViewControllerSkip:)]) {
                [self.delegate onboardingViewControllerSkip:self];
            }
            break;
    }
}

- (IBAction)rightButtonTapped:(id)sender {
    switch (self.screenType) {
        case OnboardingScreenTypePushNotif:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotifDidRegistered) name:nil object:nil];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                // iOS >= 8.0
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            else {
                // iOS < 8.0
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge];
            }
            break;
        case OnboardingScreenTypeLocation:
            if (![LocationManager isLocationServiceDetermined]) {
                self.locationManager = [[LocationManager alloc] init];
                self.locationManager.delegate = self;
                [self.locationManager updateLocation];
            }
            break;
        default:
            if ([self.delegate respondsToSelector:@selector(onboardingViewControllerNext:)]) {
                [self.delegate onboardingViewControllerNext:self];
            }
            break;
    }
}

- (IBAction)startSearch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onboardingViewControllerDismiss:)]) {
        [self.delegate onboardingViewControllerDismiss:self];
    }
    else {
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)pushNotifDidRegistered {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([self.delegate respondsToSelector:@selector(onboardingViewControllerNext:)]) {
        [self.delegate onboardingViewControllerNext:self];
    }
}

- (void)locationManagerDelegateLocationUpdated:(CLLocation *)currentLocation lastUpdateTimeInterval:(NSTimeInterval)lastUpdatedTimeInterval {
    
}

- (void)locationmanagerDelegateLocationFailed {
    
}

- (void)locationManagerAuthStatusChanged:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if ([self.delegate respondsToSelector:@selector(onboardingViewControllerNext:)]) {
            [self.delegate onboardingViewControllerNext:self];
        }
    }
}

@end