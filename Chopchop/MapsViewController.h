//
//  MapsViewController.h
//  Chopchop
//
//  Created by Arie on 10/22/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapsViewController : UIViewController
@property (nonatomic,strong) CLLocation *location;
@property (nonatomic,strong) NSString *locationName;
@end
