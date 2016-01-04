//
//  LocationsActivityDistance.m
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationsActivityDistance.h"


NSString *const kLocationsActivityDistanceMiles = @"miles";
NSString *const kLocationsActivityDistanceKm = @"km";


@interface LocationsActivityDistance ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationsActivityDistance

@synthesize miles = _miles;
@synthesize km = _km;


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
            self.miles = [self objectOrNilForKey:kLocationsActivityDistanceMiles fromDictionary:dict];
            self.km = [[self objectOrNilForKey:kLocationsActivityDistanceKm fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.miles forKey:kLocationsActivityDistanceMiles];
    [mutableDict setValue:[NSNumber numberWithDouble:self.km] forKey:kLocationsActivityDistanceKm];

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

    self.miles = [aDecoder decodeObjectForKey:kLocationsActivityDistanceMiles];
    self.km = [aDecoder decodeDoubleForKey:kLocationsActivityDistanceKm];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_miles forKey:kLocationsActivityDistanceMiles];
    [aCoder encodeDouble:_km forKey:kLocationsActivityDistanceKm];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationsActivityDistance *copy = [[LocationsActivityDistance alloc] init];
    
    if (copy) {

        copy.miles = [self.miles copyWithZone:zone];
        copy.km = self.km;
    }
    
    return copy;
}


@end
