//
//  LocationHottestUsersLocationsFollows.m
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationHottestUsersLocationsFollows.h"


NSString *const kLocationHottestUsersLocationsFollowsCreatedAt = @"created_at";


@interface LocationHottestUsersLocationsFollows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationHottestUsersLocationsFollows

@synthesize createdAt = _createdAt;


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
            self.createdAt = [self objectOrNilForKey:kLocationHottestUsersLocationsFollowsCreatedAt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdAt forKey:kLocationHottestUsersLocationsFollowsCreatedAt];

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

    self.createdAt = [aDecoder decodeObjectForKey:kLocationHottestUsersLocationsFollowsCreatedAt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdAt forKey:kLocationHottestUsersLocationsFollowsCreatedAt];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationHottestUsersLocationsFollows *copy = [[LocationHottestUsersLocationsFollows alloc] init];
    
    if (copy) {

        copy.createdAt = [self.createdAt copyWithZone:zone];
    }
    
    return copy;
}


@end
