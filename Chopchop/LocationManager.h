//
//  LocationManager.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>

- (void)locationManagerDelegateLocationUpdated:(CLLocation *)currentLocation
                        lastUpdateTimeInterval:(NSTimeInterval)lastUpdatedTimeInterval;
- (void)locationmanagerDelegateLocationFailed;

@end

@interface LocationManager : NSObject
@property (nonatomic, weak) id<LocationManagerDelegate> delegate;

+ (LocationManager *)sharedInstance;
+ (BOOL)isLocationServiceDetermined;
+ (BOOL)isLocationServiceAuthorized;
- (void)updateLocation;

@end

