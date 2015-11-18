//
//  BrandBrand.m
//
//  Created by Ratna Kumalasari on 11/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandBrand.h"


NSString *const kBrandBrandName = @"name";
NSString *const kBrandBrandWebsite = @"website";
NSString *const kBrandBrandId = @"id";
NSString *const kBrandBrandFollowed = @"followed";
NSString *const kBrandBrandFollowers = @"followers";
NSString *const kBrandBrandLikes = @"likes";
NSString *const kBrandBrandCover = @"cover";
NSString *const kBrandBrandLogo = @"logo";
NSString *const kBrandBrandActivePosts = @"active_posts";


@interface BrandBrand ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandBrand

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
            self.name = [self objectOrNilForKey:kBrandBrandName fromDictionary:dict];
            self.website = [self objectOrNilForKey:kBrandBrandWebsite fromDictionary:dict];
            self.brandIdentifier = [[self objectOrNilForKey:kBrandBrandId fromDictionary:dict] doubleValue];
            self.followed = [[self objectOrNilForKey:kBrandBrandFollowed fromDictionary:dict] boolValue];
            self.followers = [[self objectOrNilForKey:kBrandBrandFollowers fromDictionary:dict] doubleValue];
            self.likes = [[self objectOrNilForKey:kBrandBrandLikes fromDictionary:dict] doubleValue];
            self.cover = [self objectOrNilForKey:kBrandBrandCover fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kBrandBrandLogo fromDictionary:dict];
            self.activePosts = [[self objectOrNilForKey:kBrandBrandActivePosts fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kBrandBrandName];
    [mutableDict setValue:self.website forKey:kBrandBrandWebsite];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandIdentifier] forKey:kBrandBrandId];
    [mutableDict setValue:[NSNumber numberWithBool:self.followed] forKey:kBrandBrandFollowed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.followers] forKey:kBrandBrandFollowers];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likes] forKey:kBrandBrandLikes];
    [mutableDict setValue:self.cover forKey:kBrandBrandCover];
    [mutableDict setValue:self.logo forKey:kBrandBrandLogo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.activePosts] forKey:kBrandBrandActivePosts];

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

    self.name = [aDecoder decodeObjectForKey:kBrandBrandName];
    self.website = [aDecoder decodeObjectForKey:kBrandBrandWebsite];
    self.brandIdentifier = [aDecoder decodeDoubleForKey:kBrandBrandId];
    self.followed = [aDecoder decodeBoolForKey:kBrandBrandFollowed];
    self.followers = [aDecoder decodeDoubleForKey:kBrandBrandFollowers];
    self.likes = [aDecoder decodeDoubleForKey:kBrandBrandLikes];
    self.cover = [aDecoder decodeObjectForKey:kBrandBrandCover];
    self.logo = [aDecoder decodeObjectForKey:kBrandBrandLogo];
    self.activePosts = [aDecoder decodeDoubleForKey:kBrandBrandActivePosts];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kBrandBrandName];
    [aCoder encodeObject:_website forKey:kBrandBrandWebsite];
    [aCoder encodeDouble:_brandIdentifier forKey:kBrandBrandId];
    [aCoder encodeBool:_followed forKey:kBrandBrandFollowed];
    [aCoder encodeDouble:_followers forKey:kBrandBrandFollowers];
    [aCoder encodeDouble:_likes forKey:kBrandBrandLikes];
    [aCoder encodeObject:_cover forKey:kBrandBrandCover];
    [aCoder encodeObject:_logo forKey:kBrandBrandLogo];
    [aCoder encodeDouble:_activePosts forKey:kBrandBrandActivePosts];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandBrand *copy = [[BrandBrand alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.brandIdentifier = self.brandIdentifier;
        copy.followed = self.followed;
        copy.followers = self.followers;
        copy.likes = self.likes;
        copy.cover = [self.cover copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.activePosts = self.activePosts;
    }
    
    return copy;
}


@end
