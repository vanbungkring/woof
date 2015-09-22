//
//  Posts.m
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Posts.h"
#import "Location.h"
#import "Brand.h"


NSString *const kPostsStatus = @"status";
NSString *const kPostsLocation = @"location";
NSString *const kPostsName = @"name";
NSString *const kPostsId = @"id";
NSString *const kPostsDiscount = @"discount";
NSString *const kPostsBrand = @"brand";
NSString *const kPostsType = @"type";
NSString *const kPostsLiked = @"liked";
NSString *const kPostsExpiredDate = @"expired_time";
NSString *const kPostsFiles = @"files";


@interface Posts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Posts

@synthesize status = _status;
@synthesize location = _location;
@synthesize name = _name;
@synthesize postsIdentifier = _postsIdentifier;
@synthesize discount = _discount;
@synthesize brand = _brand;
@synthesize type = _type;
@synthesize liked = _liked;
@synthesize expiredDate = _expiredDate;
@synthesize files = _files;


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
        self.status = [self objectOrNilForKey:kPostsStatus fromDictionary:dict];
        self.location = [Location modelObjectWithDictionary:[dict objectForKey:kPostsLocation]];
        self.name = [self objectOrNilForKey:kPostsName fromDictionary:dict];
        self.postsIdentifier = [[self objectOrNilForKey:kPostsId fromDictionary:dict] doubleValue];
        self.discount = [[self objectOrNilForKey:kPostsDiscount fromDictionary:dict] doubleValue];
        self.brand = [[Brand alloc]initWithDictionary:[dict objectForKey:kPostsBrand]];
        self.type = [self objectOrNilForKey:kPostsType fromDictionary:dict];
        self.liked = [[self objectOrNilForKey:kPostsLiked fromDictionary:dict] boolValue];
        self.expiredDate = [self objectOrNilForKey:kPostsExpiredDate fromDictionary:dict];
        self.files = [self objectOrNilForKey:kPostsFiles fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kPostsStatus];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kPostsLocation];
    [mutableDict setValue:self.name forKey:kPostsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.postsIdentifier] forKey:kPostsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.discount] forKey:kPostsDiscount];
    // [mutableDict setValue:[self.brand dictionaryRepresentation] forKey:kPostsBrand];
    [mutableDict setValue:self.type forKey:kPostsType];
    [mutableDict setValue:[NSNumber numberWithBool:self.liked] forKey:kPostsLiked];
    [mutableDict setValue:self.expiredDate forKey:kPostsExpiredDate];
    [mutableDict setValue:self.files forKey:kPostsFiles];
    
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
    
    self.status = [aDecoder decodeObjectForKey:kPostsStatus];
    self.location = [aDecoder decodeObjectForKey:kPostsLocation];
    self.name = [aDecoder decodeObjectForKey:kPostsName];
    self.postsIdentifier = [aDecoder decodeDoubleForKey:kPostsId];
    self.discount = [aDecoder decodeDoubleForKey:kPostsDiscount];
    self.brand = [aDecoder decodeObjectForKey:kPostsBrand];
    self.type = [aDecoder decodeObjectForKey:kPostsType];
    self.liked = [aDecoder decodeBoolForKey:kPostsLiked];
    self.expiredDate = [aDecoder decodeObjectForKey:kPostsExpiredDate];
    self.files = [aDecoder decodeObjectForKey:kPostsFiles];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_status forKey:kPostsStatus];
    [aCoder encodeObject:_location forKey:kPostsLocation];
    [aCoder encodeObject:_name forKey:kPostsName];
    [aCoder encodeDouble:_postsIdentifier forKey:kPostsId];
    [aCoder encodeDouble:_discount forKey:kPostsDiscount];
    [aCoder encodeObject:_brand forKey:kPostsBrand];
    [aCoder encodeObject:_type forKey:kPostsType];
    [aCoder encodeBool:_liked forKey:kPostsLiked];
    [aCoder encodeObject:_expiredDate forKey:kPostsExpiredDate];
    [aCoder encodeObject:_files forKey:kPostsFiles];
}

- (id)copyWithZone:(NSZone *)zone
{
    Posts *copy = [[Posts alloc] init];
    
    if (copy) {
        
        copy.status = [self.status copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.postsIdentifier = self.postsIdentifier;
        copy.discount = self.discount;
        copy.type = [self.type copyWithZone:zone];
        copy.liked = self.liked;
        copy.expiredDate = [self.expiredDate copyWithZone:zone];
        copy.files = [self.files copyWithZone:zone];
    }
    
    return copy;
}


@end
