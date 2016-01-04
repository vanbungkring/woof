//
//  LocationHottestMatchingData.m
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationHottestMatchingData.h"
#import "LocationHottestUsersLocationsFollows.h"


NSString *const kLocationHottestMatchingDataUsersLocationsFollows = @"UsersLocationsFollows";


@interface LocationHottestMatchingData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationHottestMatchingData

@synthesize usersLocationsFollows = _usersLocationsFollows;


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
            self.usersLocationsFollows = [LocationHottestUsersLocationsFollows modelObjectWithDictionary:[dict objectForKey:kLocationHottestMatchingDataUsersLocationsFollows]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.usersLocationsFollows dictionaryRepresentation] forKey:kLocationHottestMatchingDataUsersLocationsFollows];

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

    self.usersLocationsFollows = [aDecoder decodeObjectForKey:kLocationHottestMatchingDataUsersLocationsFollows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_usersLocationsFollows forKey:kLocationHottestMatchingDataUsersLocationsFollows];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationHottestMatchingData *copy = [[LocationHottestMatchingData alloc] init];
    
    if (copy) {

        copy.usersLocationsFollows = [self.usersLocationsFollows copyWithZone:zone];
    }
    
    return copy;
}


@end
