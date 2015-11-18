//
//  Posts.m
//
//  Created by Ratna Kumalasari on 10/22/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Posts.h"
#import "Brand.h"
#import "Location.h"


NSString *const kPostsId = @"id";
NSString *const kPostsDiscount = @"discount";
NSString *const kPostsExpiredTime = @"expired_time";
NSString *const kPostsDescription = @"description";
NSString *const kPostsBrand = @"brand";
NSString *const kPostsType = @"type";
NSString *const kPostsFiles = @"files";
NSString *const kPostsExpiredDate = @"expired_date";
NSString *const kPostsLocation = @"location";
NSString *const kPostsWishlist = @"wishlist";
NSString *const kPostsLiked = @"liked";
NSString *const kPostsStatus = @"status";


@interface Posts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Posts

@synthesize postsIdentifier = _postsIdentifier;
@synthesize discount = _discount;
@synthesize expiredTime = _expiredTime;
@synthesize postsDescription = _postsDescription;
@synthesize brand = _brand;
@synthesize type = _type;
@synthesize files = _files;
@synthesize expiredDate = _expiredDate;
@synthesize location = _location;
@synthesize wishlist = _wishlist;
@synthesize liked = _liked;
@synthesize status = _status;


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
        self.postsIdentifier = [[self objectOrNilForKey:kPostsId fromDictionary:dict] doubleValue];
        self.discount = [[self objectOrNilForKey:kPostsDiscount fromDictionary:dict] doubleValue];
        self.expiredTime = [self objectOrNilForKey:kPostsExpiredTime fromDictionary:dict];
        self.postsDescription = [self objectOrNilForKey:kPostsDescription fromDictionary:dict];
        self.brand = [Brand modelObjectWithDictionary:[dict objectForKey:kPostsBrand]];
        self.type = [self objectOrNilForKey:kPostsType fromDictionary:dict];
        self.files = [self objectOrNilForKey:kPostsFiles fromDictionary:dict];
        self.expiredDate = [self objectOrNilForKey:kPostsExpiredDate fromDictionary:dict];
        self.location = [Location modelObjectWithDictionary:[dict objectForKey:kPostsLocation]];
        self.wishlist = [[self objectOrNilForKey:kPostsWishlist fromDictionary:dict] boolValue];
        self.liked = [[self objectOrNilForKey:kPostsLiked fromDictionary:dict] boolValue];
        self.status = [self objectOrNilForKey:kPostsStatus fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.postsIdentifier] forKey:kPostsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.discount] forKey:kPostsDiscount];
    [mutableDict setValue:self.expiredTime forKey:kPostsExpiredTime];
    [mutableDict setValue:self.postsDescription forKey:kPostsDescription];
    [mutableDict setValue:[self.brand dictionaryRepresentation] forKey:kPostsBrand];
    [mutableDict setValue:self.type forKey:kPostsType];
    [mutableDict setValue:self.files forKey:kPostsFiles];
    [mutableDict setValue:self.expiredDate forKey:kPostsExpiredDate];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kPostsLocation];
    [mutableDict setValue:[NSNumber numberWithBool:self.wishlist] forKey:kPostsWishlist];
    [mutableDict setValue:[NSNumber numberWithBool:self.liked] forKey:kPostsLiked];
    [mutableDict setValue:self.status forKey:kPostsStatus];
    
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
    
    self.postsIdentifier = [aDecoder decodeDoubleForKey:kPostsId];
    self.discount = [aDecoder decodeDoubleForKey:kPostsDiscount];
    self.expiredTime = [aDecoder decodeObjectForKey:kPostsExpiredTime];
    self.postsDescription = [aDecoder decodeObjectForKey:kPostsDescription];
    self.brand = [aDecoder decodeObjectForKey:kPostsBrand];
    self.type = [aDecoder decodeObjectForKey:kPostsType];
    self.files = [aDecoder decodeObjectForKey:kPostsFiles];
    self.expiredDate = [aDecoder decodeObjectForKey:kPostsExpiredDate];
    self.location = [aDecoder decodeObjectForKey:kPostsLocation];
    self.wishlist = [aDecoder decodeBoolForKey:kPostsWishlist];
    self.liked = [aDecoder decodeBoolForKey:kPostsLiked];
    self.status = [aDecoder decodeObjectForKey:kPostsStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_postsIdentifier forKey:kPostsId];
    [aCoder encodeDouble:_discount forKey:kPostsDiscount];
    [aCoder encodeObject:_expiredTime forKey:kPostsExpiredTime];
    [aCoder encodeObject:_postsDescription forKey:kPostsDescription];
    [aCoder encodeObject:_brand forKey:kPostsBrand];
    [aCoder encodeObject:_type forKey:kPostsType];
    [aCoder encodeObject:_files forKey:kPostsFiles];
    [aCoder encodeObject:_expiredDate forKey:kPostsExpiredDate];
    [aCoder encodeObject:_location forKey:kPostsLocation];
    [aCoder encodeBool:_wishlist forKey:kPostsWishlist];
    [aCoder encodeBool:_liked forKey:kPostsLiked];
    [aCoder encodeObject:_status forKey:kPostsStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    Posts *copy = [[Posts alloc] init];
    
    if (copy) {
        
        copy.postsIdentifier = self.postsIdentifier;
        copy.discount = self.discount;
        copy.expiredTime = [self.expiredTime copyWithZone:zone];
        copy.postsDescription = [self.postsDescription copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.files = [self.files copyWithZone:zone];
        copy.expiredDate = [self.expiredDate copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.wishlist = self.wishlist;
        copy.liked = self.liked;
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}
@end