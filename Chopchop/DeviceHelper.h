//
//  DeviceHelper.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DeviceHelper : NSObject
+ (NSString *)bundleId;
+ (NSString *)timezoneUTC;
+ (NSString *)deviceId;
+ (NSString *)platform;
+ (NSString *)platformVersion;
+ (NSString *)applicationVersion;
+ (NSString *)model;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;
@end
