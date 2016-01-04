//
//  LocationsActivityLocations.m
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationsActivityLocations.h"
#import "LocationsActivityDistance.h"


NSString *const kLocationsActivityLocationsLocationId = @"location_id";
NSString *const kLocationsActivityLocationsLocationName = @"location_name";
NSString *const kLocationsActivityLocationsCountPosts = @"count_posts";
NSString *const kLocationsActivityLocationsLocationLogo = @"location_logo";
NSString *const kLocationsActivityLocationsDistance = @"distance";


@interface LocationsActivityLocations ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationsActivityLocations

@synthesize locationId = _locationId;
@synthesize locationName = _locationName;
@synthesize countPosts = _countPosts;
@synthesize locationLogo = _locationLogo;
@synthesize distance = _distance;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.locationId = [[self objectOrNilForKey:kLocationsActivityLocationsLocationId fromDictionary:dict] doubleValue];
            self.locationName = [self objectOrNilForKey:kLocationsActivityLocationsLocationName fromDictionary:dict];
            self.countPosts = [[self objectOrNilForKey:kLocationsActivityLocationsCountPosts fromDictionary:dict] doubleValue];
            self.locationLogo = [self objectOrNilForKey:kLocationsActivityLocationsLocationLogo fromDictionary:dict];
            self.distance = [LocationsActivityDistance modelObjectWithDictionary:[dict objectForKey:kLocationsActivityLocationsDistance]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.locationId] forKey:kLocationsActivityLocationsLocationId];
    [mutableDict setValue:self.locationName forKey:kLocationsActivityLocationsLocationName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countPosts] forKey:kLocationsActivityLocationsCountPosts];
    [mutableDict setValue:self.locationLogo forKey:kLocationsActivityLocationsLocationLogo];
    [mutableDict setValue:[self.distance dictionaryRepresentation] forKey:kLocationsActivityLocationsDistance];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.locationId = [aDecoder decodeDoubleForKey:kLocationsActivityLocationsLocationId];
    self.locationName = [aDecoder decodeObjectForKey:kLocationsActivityLocationsLocationName];
    self.countPosts = [aDecoder decodeDoubleForKey:kLocationsActivityLocationsCountPosts];
    self.locationLogo = [aDecoder decodeObjectForKey:kLocationsActivityLocationsLocationLogo];
    self.distance = [aDecoder decodeObjectForKey:kLocationsActivityLocationsDistance];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_locationId forKey:kLocationsActivityLocationsLocationId];
    [aCoder encodeObject:_locationName forKey:kLocationsActivityLocationsLocationName];
    [aCoder encodeDouble:_countPosts forKey:kLocationsActivityLocationsCountPosts];
    [aCoder encodeObject:_locationLogo forKey:kLocationsActivityLocationsLocationLogo];
    [aCoder encodeObject:_distance forKey:kLocationsActivityLocationsDistance];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationsActivityLocations *copy = [[LocationsActivityLocations alloc] init];
    
    if (copy) {

        copy.locationId = self.locationId;
        copy.locationName = [self.locationName copyWithZone:zone];
        copy.countPosts = self.countPosts;
        copy.locationLogo = [self.locationLogo copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
    }
    
    return copy;
}


@end
