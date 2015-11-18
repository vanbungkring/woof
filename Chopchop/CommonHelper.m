//
//  CommonHelper.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "CommonHelper.h"
#import "StaticAndPreferences.h"
@implementation CommonHelper
+ (void)setUserLocationPermission:(BOOL)isAllowed {
    [[NSUserDefaults standardUserDefaults] setBool:isAllowed forKey:PREFS_LOCATION_SERVICE_PERMISSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)storeAppToken:(NSString *)appToken {
    [[NSUserDefaults standardUserDefaults] setObject:appToken forKey:PREFS_API_APP_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)appToken {
    return [[NSUserDefaults standardUserDefaults]stringForKey:PREFS_API_APP_TOKEN];
}
+ (NSString *)userToken {
return [[NSUserDefaults standardUserDefaults]stringForKey:PREFS_USER_TOKEN];
}
+ (BOOL)loginUser {
    NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:PREFS_USER_TOKEN];
    return  userToken.length ? true:false;
}
+ (BOOL)locationUserServicePermission {
    return [[NSUserDefaults standardUserDefaults] boolForKey:PREFS_LOCATION_SERVICE_PERMISSION];
}
@end
