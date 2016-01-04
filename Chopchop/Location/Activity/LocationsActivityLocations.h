//
//  LocationsActivityLocations.h
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationsActivityDistance;

@interface LocationsActivityLocations : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double locationId;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, assign) double countPosts;
@property (nonatomic, strong) NSString *locationLogo;
@property (nonatomic, strong) LocationsActivityDistance *distance;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
