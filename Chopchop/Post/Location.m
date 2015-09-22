//
//  Location.m
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Location.h"
#import "Distance.h"


NSString *const kLocationPhone = @"phone";
NSString *const kLocationFollower = @"follower";
NSString *const kLocationDetail = @"detail";
NSString *const kLocationWebsite = @"website";
NSString *const kLocationId = @"id";
NSString *const kLocationLongitude = @"longitude";
NSString *const kLocationDistance = @"distance";
NSString *const kLocationLatitude = @"latitude";
NSString *const kLocationName = @"name";


@interface Location ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Location

@synthesize phone = _phone;
@synthesize follower = _follower;
@synthesize detail = _detail;
@synthesize website = _website;
@synthesize locationIdentifier = _locationIdentifier;
@synthesize longitude = _longitude;
@synthesize distance = _distance;
@synthesize latitude = _latitude;
@synthesize name = _name;


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
            self.phone = [self objectOrNilForKey:kLocationPhone fromDictionary:dict];
            self.follower = [[self objectOrNilForKey:kLocationFollower fromDictionary:dict] doubleValue];
            self.detail = [self objectOrNilForKey:kLocationDetail fromDictionary:dict];
            self.website = [self objectOrNilForKey:kLocationWebsite fromDictionary:dict];
            self.locationIdentifier = [[self objectOrNilForKey:kLocationId fromDictionary:dict] doubleValue];
            self.longitude = [self objectOrNilForKey:kLocationLongitude fromDictionary:dict];
            self.distance = [Distance modelObjectWithDictionary:[dict objectForKey:kLocationDistance]];
            self.latitude = [self objectOrNilForKey:kLocationLatitude fromDictionary:dict];
            self.name = [self objectOrNilForKey:kLocationName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kLocationPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.follower] forKey:kLocationFollower];
    [mutableDict setValue:self.detail forKey:kLocationDetail];
    [mutableDict setValue:self.website forKey:kLocationWebsite];
    [mutableDict setValue:[NSNumber numberWithDouble:self.locationIdentifier] forKey:kLocationId];
    [mutableDict setValue:self.longitude forKey:kLocationLongitude];
    [mutableDict setValue:[self.distance dictionaryRepresentation] forKey:kLocationDistance];
    [mutableDict setValue:self.latitude forKey:kLocationLatitude];
    [mutableDict setValue:self.name forKey:kLocationName];

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

    self.phone = [aDecoder decodeObjectForKey:kLocationPhone];
    self.follower = [aDecoder decodeDoubleForKey:kLocationFollower];
    self.detail = [aDecoder decodeObjectForKey:kLocationDetail];
    self.website = [aDecoder decodeObjectForKey:kLocationWebsite];
    self.locationIdentifier = [aDecoder decodeDoubleForKey:kLocationId];
    self.longitude = [aDecoder decodeObjectForKey:kLocationLongitude];
    self.distance = [aDecoder decodeObjectForKey:kLocationDistance];
    self.latitude = [aDecoder decodeObjectForKey:kLocationLatitude];
    self.name = [aDecoder decodeObjectForKey:kLocationName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kLocationPhone];
    [aCoder encodeDouble:_follower forKey:kLocationFollower];
    [aCoder encodeObject:_detail forKey:kLocationDetail];
    [aCoder encodeObject:_website forKey:kLocationWebsite];
    [aCoder encodeDouble:_locationIdentifier forKey:kLocationId];
    [aCoder encodeObject:_longitude forKey:kLocationLongitude];
    [aCoder encodeObject:_distance forKey:kLocationDistance];
    [aCoder encodeObject:_latitude forKey:kLocationLatitude];
    [aCoder encodeObject:_name forKey:kLocationName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Location *copy = [[Location alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.follower = self.follower;
        copy.detail = [self.detail copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.locationIdentifier = self.locationIdentifier;
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
