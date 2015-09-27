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
+ (BOOL)loginUser {
    return false;
}
+ (BOOL)locationUserServicePermission {
    return [[NSUserDefaults standardUserDefaults] boolForKey:PREFS_LOCATION_SERVICE_PERMISSION];
}
@end
