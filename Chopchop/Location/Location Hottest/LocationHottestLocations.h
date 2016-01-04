//
//  LocationHottestLocations.h
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationHottestMatchingData;

@interface LocationHottestLocations : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double locationsIdentifier;
@property (nonatomic, strong) NSString *followers;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) LocationHottestMatchingData *matchingData;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
