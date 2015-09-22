//
//  DeviceHelper.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "DeviceHelper.h"
#import "Util.h"
@implementation DeviceHelper

+ (NSString *)bundleId {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)timezoneUTC {
    NSDate *currentDate = [NSDate date];
    NSString *timezoneUTC = [NSString stringWithFormat:@"%@", [Util dateStringFromDate:currentDate withFormat:@"OOOO"]];
    return timezoneUTC;
}

+ (NSString *)deviceId {
    return [Util uniqueIdentifier];
}

+ (NSString *)platform {
    return @"IOS";
}

+ (NSString *)platformVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)applicationVersion {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+ (NSString *)model {
    return [Util hardwareString];
}

+ (CGFloat)screenHeight {
    return [Util screenSize].height;
}

+ (CGFloat)screenWidth {
    return [Util screenSize].width;
}

@end
