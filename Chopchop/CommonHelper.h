//
//  CommonHelper.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject
+ (void)setUserLocationPermission:(BOOL)isAllowed;
+ (void)storeAppToken:(NSString *)appToken;
+ (NSString *)appToken;
+ (BOOL)loginUser;
+ (BOOL)locationUserServicePermission;
@end
