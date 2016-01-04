//
//  LocationHottestLocations.m
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationHottestLocations.h"
#import "LocationHottestMatchingData.h"


NSString *const kLocationHottestLocationsId = @"id";
NSString *const kLocationHottestLocationsFollowers = @"followers";
NSString *const kLocationHottestLocationsName = @"name";
NSString *const kLocationHottestLocationsCover = @"cover";
NSString *const kLocationHottestLocationsMatchingData = @"_matchingData";


@interface LocationHottestLocations ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationHottestLocations

@synthesize locationsIdentifier = _locationsIdentifier;
@synthesize followers = _followers;
@synthesize name = _name;
@synthesize cover = _cover;
@synthesize matchingData = _matchingData;


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
            self.locationsIdentifier = [[self objectOrNilForKey:kLocationHottestLocationsId fromDictionary:dict] doubleValue];
            self.followers = [self objectOrNilForKey:kLocationHottestLocationsFollowers fromDictionary:dict];
            self.name = [self objectOrNilForKey:kLocationHottestLocationsName fromDictionary:dict];
            self.cover = [self objectOrNilForKey:kLocationHottestLocationsCover fromDictionary:dict];
            self.matchingData = [LocationHottestMatchingData modelObjectWithDictionary:[dict objectForKey:kLocationHottestLocationsMatchingData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.locationsIdentifier] forKey:kLocationHottestLocationsId];
    [mutableDict setValue:self.followers forKey:kLocationHottestLocationsFollowers];
    [mutableDict setValue:self.name forKey:kLocationHottestLocationsName];
    [mutableDict setValue:self.cover forKey:kLocationHottestLocationsCover];
    [mutableDict setValue:[self.matchingData dictionaryRepresentation] forKey:kLocationHottestLocationsMatchingData];

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

    self.locationsIdentifier = [aDecoder decodeDoubleForKey:kLocationHottestLocationsId];
    self.followers = [aDecoder decodeObjectForKey:kLocationHottestLocationsFollowers];
    self.name = [aDecoder decodeObjectForKey:kLocationHottestLocationsName];
    self.cover = [aDecoder decodeObjectForKey:kLocationHottestLocationsCover];
    self.matchingData = [aDecoder decodeObjectForKey:kLocationHottestLocationsMatchingData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_locationsIdentifier forKey:kLocationHottestLocationsId];
    [aCoder encodeObject:_followers forKey:kLocationHottestLocationsFollowers];
    [aCoder encodeObject:_name forKey:kLocationHottestLocationsName];
    [aCoder encodeObject:_cover forKey:kLocationHottestLocationsCover];
    [aCoder encodeObject:_matchingData forKey:kLocationHottestLocationsMatchingData];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationHottestLocations *copy = [[LocationHottestLocations alloc] init];
    
    if (copy) {

        copy.locationsIdentifier = self.locationsIdentifier;
        copy.followers = [self.followers copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.cover = [self.cover copyWithZone:zone];
        copy.matchingData = [self.matchingData copyWithZone:zone];
    }
    
    return copy;
}


@end
