//
//  LocationManager.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "LocationManager.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Util.h"
@interface LocationManager() <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) NSTimeInterval lastUpdatedTimeInterval;

@end

@implementation LocationManager
@synthesize delegate = _delegate;

#pragma mark - Singleton
+ (LocationManager *)sharedInstance {
    static LocationManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
        self.currentLocation = [[CLLocation alloc] init];
        self.lastUpdatedTimeInterval = -1.0f;
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

#pragma mark - Public Method
+ (BOOL)isLocationServiceDetermined {
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    return (authStatus != kCLAuthorizationStatusNotDetermined);
}

+ (BOOL)isLocationServiceAuthorized {
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        return (authStatus == kCLAuthorizationStatusAuthorizedAlways || authStatus == kCLAuthorizationStatusAuthorizedWhenInUse);
    } else {
        return (authStatus == kCLAuthorizationStatusAuthorizedAlways);
    }
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Private Method
- (void)updatingLocation:(CLLocation *)newLocation {
    self.currentLocation = newLocation;
    self.lastUpdatedTimeInterval = [Util getCurrentTime];
    
    if ([self.delegate respondsToSelector:@selector(locationManagerDelegateLocationUpdated:lastUpdateTimeInterval:)]) {
        [self.delegate locationManagerDelegateLocationUpdated:newLocation lastUpdateTimeInterval:self.lastUpdatedTimeInterval];
    }
}

#pragma mark - Delegate
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    [self updatingLocation:(CLLocation *)[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    
    if ([self.delegate respondsToSelector:@selector(locationmanagerDelegateLocationFailed)]) {
        [self.delegate locationmanagerDelegateLocationFailed];
    }
}

@end
