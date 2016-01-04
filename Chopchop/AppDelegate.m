//
//  AppDelegate.m
//  Chopchop
//
//  Created by Arie on 9/5/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonHelper.h"
#import <UIFont+Montserrat.h>
#import <AFNetworking.h>
#import <AFNetworkActivityLogger.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "LocationManager.h"
#import <Parse.h>
#import "APIManager.h"
#import "Util.h"
#import "DeviceHelper.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "StaticAndPreferences.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [AFNetworkActivityLogger sharedLogger].level = AFLoggerLevelDebug;
    [Fabric with:@[[Crashlytics class]]];
    
    [Parse setApplicationId:@"6ncBJMg1WccQ1X30i7nfXBrgu92fBVirA66WAFab"
                  clientKey:@"ZTKKLSxZ58quvh3n4KZGGRgN9FuPP6eYXjcLhS2X"];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    //[self firstSetup];
    
    UIFont *titleFontType = [UIFont montserratFontOfSize:18.0f];
    
    NSDictionary *titleFontAttributes = [NSDictionary dictionaryWithObjects:@[titleFontType, [UIColor whiteColor]]
                                                                    forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleFontAttributes];
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"HelveticaNeue" size:10], NSFontAttributeName,
                                                      [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                                       nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"HelveticaNeue" size:10], NSFontAttributeName,
                                                       [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00], NSForegroundColorAttributeName,
                                                       nil]
                                             forState:UIControlStateSelected];
    
    
    // set the selected icon color
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00]];
    // remove the shadow
    [[UITabBar appearance] setShadowImage:nil];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)firstSetup {
    if (![CommonHelper appToken].length) {
        [APIManager initAppWithDictionary:@{@"device_id":[DeviceHelper deviceId],@"api_key":API_KEY} completionBlock:^(NSArray *json, NSError *error) {
            if (!error) {
                [CommonHelper storeAppToken:[json[0] valueForKey:@"token"]];
            }
        }];
    }
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current Installation and save it to Parse
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)locationmanagerDelegateLocationFailed {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
