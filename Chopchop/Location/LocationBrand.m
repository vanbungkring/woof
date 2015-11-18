//
//  LocationBrand.m
//
//  Created by Ratna Kumalasari on 11/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationBrand.h"


NSString *const kLocationBrandName = @"name";
NSString *const kLocationBrandWebsite = @"website";
NSString *const kLocationBrandId = @"id";
NSString *const kLocationBrandFollowed = @"followed";
NSString *const kLocationBrandFollowers = @"followers";
NSString *const kLocationBrandLikes = @"likes";
NSString *const kLocationBrandCover = @"cover";
NSString *const kLocationBrandLogo = @"logo";
NSString *const kLocationBrandActivePosts = @"active_posts";


@interface LocationBrand ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationBrand

@synthesize name = _name;
@synthesize website = _website;
@synthesize brandIdentifier = _brandIdentifier;
@synthesize followed = _followed;
@synthesize followers = _followers;
@synthesize likes = _likes;
@synthesize cover = _cover;
@synthesize logo = _logo;
@synthesize activePosts = _activePosts;


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
            self.name = [self objectOrNilForKey:kLocationBrandName fromDictionary:dict];
            self.website = [self objectOrNilForKey:kLocationBrandWebsite fromDictionary:dict];
            self.brandIdentifier = [[self objectOrNilForKey:kLocationBrandId fromDictionary:dict] doubleValue];
            self.followed = [[self objectOrNilForKey:kLocationBrandFollowed fromDictionary:dict] boolValue];
            self.followers = [[self objectOrNilForKey:kLocationBrandFollowers fromDictionary:dict] doubleValue];
            self.likes = [[self objectOrNilForKey:kLocationBrandLikes fromDictionary:dict] doubleValue];
            self.cover = [self objectOrNilForKey:kLocationBrandCover fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kLocationBrandLogo fromDictionary:dict];
            self.activePosts = [self objectOrNilForKey:kLocationBrandActivePosts fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kLocationBrandName];
    [mutableDict setValue:self.website forKey:kLocationBrandWebsite];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandIdentifier] forKey:kLocationBrandId];
    [mutableDict setValue:[NSNumber numberWithBool:self.followed] forKey:kLocationBrandFollowed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.followers] forKey:kLocationBrandFollowers];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likes] forKey:kLocationBrandLikes];
    [mutableDict setValue:self.cover forKey:kLocationBrandCover];
    [mutableDict setValue:self.logo forKey:kLocationBrandLogo];
    [mutableDict setValue:self.activePosts forKey:kLocationBrandActivePosts];

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

    self.name = [aDecoder decodeObjectForKey:kLocationBrandName];
    self.website = [aDecoder decodeObjectForKey:kLocationBrandWebsite];
    self.brandIdentifier = [aDecoder decodeDoubleForKey:kLocationBrandId];
    self.followed = [aDecoder decodeBoolForKey:kLocationBrandFollowed];
    self.followers = [aDecoder decodeDoubleForKey:kLocationBrandFollowers];
    self.likes = [aDecoder decodeDoubleForKey:kLocationBrandLikes];
    self.cover = [aDecoder decodeObjectForKey:kLocationBrandCover];
    self.logo = [aDecoder decodeObjectForKey:kLocationBrandLogo];
    self.activePosts = [aDecoder decodeObjectForKey:kLocationBrandActivePosts];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kLocationBrandName];
    [aCoder encodeObject:_website forKey:kLocationBrandWebsite];
    [aCoder encodeDouble:_brandIdentifier forKey:kLocationBrandId];
    [aCoder encodeBool:_followed forKey:kLocationBrandFollowed];
    [aCoder encodeDouble:_followers forKey:kLocationBrandFollowers];
    [aCoder encodeDouble:_likes forKey:kLocationBrandLikes];
    [aCoder encodeObject:_cover forKey:kLocationBrandCover];
    [aCoder encodeObject:_logo forKey:kLocationBrandLogo];
    [aCoder encodeObject:_activePosts forKey:kLocationBrandActivePosts];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationBrand *copy = [[LocationBrand alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.brandIdentifier = self.brandIdentifier;
        copy.followed = self.followed;
        copy.followers = self.followers;
        copy.likes = self.likes;
        copy.cover = [self.cover copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.activePosts = [self.activePosts copyWithZone:zone];
    }
    
    return copy;
}


@end
