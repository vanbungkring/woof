//
//  CommonHelper.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
@interface CommonHelper : NSObject
+ (void)setUserLocationPermission:(BOOL)isAllowed;
+ (void)storeAppToken:(NSString *)appToken;
+ (NSString *)appToken;
+ (NSString *)userToken;
+ (BOOL)loginUser;
+ (BOOL)locationUserServicePermission;
@end
