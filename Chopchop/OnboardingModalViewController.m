//
//  OnboardingModalViewController.m
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "OnboardingModalViewController.h"
#import "OnboardingViewController.h"
#import "LocationManager.h"
#import "StaticAndPreferences.h"

@interface OnboardingModalViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, OnboardingViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (assign, nonatomic) NSInteger numOfPage;
@property (assign, nonatomic) BOOL showPushNotification;
@property (assign, nonatomic) BOOL showLocation;

@end

@implementation OnboardingModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl = [UIPageControl appearanceWhenContainedIn:[OnboardingModalViewController class], nil];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    self.numOfPage = 4;
    if (![LocationManager isLocationServiceDetermined]) {
        self.numOfPage++;
        self.showLocation = YES;
    }
    //no way to determine if user denied push notif permission or have never been requested
    //push notif permission is asked on first time app launch -> assumption: app have requested permission if PREFS_LAST_TIMER_DATE exists
    if (![[NSUserDefaults standardUserDefaults] objectForKey:PREFS_LAST_TIMER_DATE]) {
        self.numOfPage++;
        self.showPushNotification = YES;
    }
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    
    OnboardingViewController *initialChildViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialChildViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *view = self.pageViewController.view;
    [self.view addSubview:view];
    NSDictionary *dictionary = NSDictionaryOfVariableBindings(view);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:dictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:dictionary]];
    [self.pageViewController didMoveToParentViewController:self];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREFS_ONBOARDING_SHOWN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (OnboardingViewController *)viewControllerAtIndex:(NSInteger)index {
    OnboardingViewController *childVC = [[OnboardingViewController alloc] initWithOnboardingScreenType:index];
    childVC.delegate = self;
    return childVC;
}

#pragma mark - UIPageViewController Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(OnboardingViewController *)viewController screenType];
    if (index == 0) {
        return nil;
    }
    if (index == OnboardingScreenTypeLocation) {
        if (self.showPushNotification) {
            return [self viewControllerAtIndex:OnboardingScreenTypePushNotif];
        }
        else {
            return [self viewControllerAtIndex:OnboardingScreenTypeSendEticket];
        }
    }
    else if (index == OnboardingScreenTypeCountry) {
        if (self.showLocation) {
            return [self viewControllerAtIndex:OnboardingScreenTypeLocation];
        }
        else if (self.showPushNotification) {
            return [self viewControllerAtIndex:OnboardingScreenTypePushNotif];
        }
        else {
            return [self viewControllerAtIndex:OnboardingScreenTypeSendEticket];
        }
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(OnboardingViewController *)viewController screenType];
    if (index == OnboardingScreenTypeCountry) {
        return nil;
    }
    else if (index == OnboardingScreenTypeSendEticket) {
        if (self.showPushNotification) {
            return [self viewControllerAtIndex:OnboardingScreenTypePushNotif];
        }
        else if (self.showLocation) {
            return [self viewControllerAtIndex:OnboardingScreenTypeLocation];
        }
        else {
            return [self viewControllerAtIndex:OnboardingScreenTypeCountry];
        }
    }
    else if (index == OnboardingScreenTypePushNotif) {
        if (!self.showLocation) {
            return [self viewControllerAtIndex:OnboardingScreenTypeCountry];
        }
    }
    index++;
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.numOfPage;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    OnboardingViewController *viewController = pageViewController.viewControllers[0];
    if (viewController) {
        NSInteger page = viewController.screenType;
        if (page > OnboardingScreenTypeLocation) {
            page = self.showLocation ? page-- : page;
        }
        if (page > OnboardingScreenTypePushNotif) {
            page = self.showPushNotification ? page-- : page;
        }
        return page;
    }
    else {
        return 0;
    }
}

- (void)onboardingViewControllerDismiss:(OnboardingViewController *)onboardingViewController {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onboardingViewControllerNext:(OnboardingViewController *)onboardingViewController {
    NSInteger index = onboardingViewController.screenType + 1;
    [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)onboardingViewControllerSkip:(OnboardingViewController *)onboardingViewController {
    if (self.showPushNotification) {
        [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:OnboardingScreenTypePushNotif]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else if (self.showLocation) {
        [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:OnboardingScreenTypeLocation]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else {
        [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:OnboardingScreenTypeCountry]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}
@end

