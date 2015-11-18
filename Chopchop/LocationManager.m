
#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import <INTULocationManager.h>
#import <INTULocationRequest.h>
#import "Util.h"

@interface LocationManager()

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
+ (BOOL)isLocationServiceAuthorized {
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        return (authStatus == kCLAuthorizationStatusAuthorizedAlways || authStatus == kCLAuthorizationStatusAuthorizedWhenInUse);
    } else {
        return (authStatus == kCLAuthorizationStatusAuthorized);
    }
}

+ (BOOL)isLocationServiceDetermined {
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    return (authStatus != kCLAuthorizationStatusNotDetermined);
}

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
        [[LocationManager sharedInstance] startMonitoringSignificantLocationChanges];
    }
    return self;
}
#pragma mark - Private Method
- (void)updatingLocation:(CLLocation *)newLocation {
    self.currentLocation = newLocation;
    self.lastUpdatedTimeInterval = [Util getCurrentTime];
    
    if ([self.delegate respondsToSelector:@selector(locationManagerDelegateLocationUpdated:)]) {
        [self.delegate locationManagerDelegateLocationUpdated:newLocation];
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
    
    
}
- (void)didReceiveError {
    if ([self.delegate respondsToSelector:@selector(locationmanagerDelegateLocationFailed)]) {
        [self.delegate locationmanagerDelegateLocationFailed];
    }
}
+ (NSString *)getErrorDescription:(INTULocationStatus)status
{
    if (status == INTULocationStatusServicesNotDetermined) {
        return @"Error: User has not responded to the permissions alert.";
    }
    if (status == INTULocationStatusServicesDenied) {
        return @"Error: User has denied this app permissions to access device location.";
    }
    if (status == INTULocationStatusServicesRestricted) {
        return @"Error: User is restricted from using location services by a usage policy.";
    }
    if (status == INTULocationStatusServicesDisabled) {
        return @"Error: Location services are turned off for all apps on this device.";
    }
    return @"An unknown error occurred.\n(Are you using iOS Simulator with location set to 'None'?)";
}

- (void)startMonitoringSignificantLocationChanges {
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr subscribeToLocationUpdatesWithBlock:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            [[LocationManager sharedInstance]updatingLocation:currentLocation];
        }
        else {
            [[LocationManager sharedInstance] didReceiveError];
        }
        
    }];

}

@end
