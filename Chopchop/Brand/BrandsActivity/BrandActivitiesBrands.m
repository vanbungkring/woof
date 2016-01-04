//
//  BrandActivitiesBrands.m
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandActivitiesBrands.h"


NSString *const kBrandActivitiesBrandsBrandName = @"brand_name";
NSString *const kBrandActivitiesBrandsPostCreatedTime = @"post_created_time";
NSString *const kBrandActivitiesBrandsPostId = @"post_id";
NSString *const kBrandActivitiesBrandsPostFile = @"post_file";
NSString *const kBrandActivitiesBrandsBrandId = @"brand_id";
NSString *const kBrandActivitiesBrandsPostCreatedAt = @"post_created_at";
NSString *const kBrandActivitiesBrandsBrandLogo = @"brand_logo";


@interface BrandActivitiesBrands ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandActivitiesBrands

@synthesize brandName = _brandName;
@synthesize postCreatedTime = _postCreatedTime;
@synthesize postId = _postId;
@synthesize postFile = _postFile;
@synthesize brandId = _brandId;
@synthesize postCreatedAt = _postCreatedAt;
@synthesize brandLogo = _brandLogo;


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
            self.brandName = [self objectOrNilForKey:kBrandActivitiesBrandsBrandName fromDictionary:dict];
            self.postCreatedTime = [self objectOrNilForKey:kBrandActivitiesBrandsPostCreatedTime fromDictionary:dict];
            self.postId = [[self objectOrNilForKey:kBrandActivitiesBrandsPostId fromDictionary:dict] doubleValue];
            self.postFile = [self objectOrNilForKey:kBrandActivitiesBrandsPostFile fromDictionary:dict];
            self.brandId = [[self objectOrNilForKey:kBrandActivitiesBrandsBrandId fromDictionary:dict] doubleValue];
            self.postCreatedAt = [self objectOrNilForKey:kBrandActivitiesBrandsPostCreatedAt fromDictionary:dict];
            self.brandLogo = [self objectOrNilForKey:kBrandActivitiesBrandsBrandLogo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.brandName forKey:kBrandActivitiesBrandsBrandName];
    [mutableDict setValue:self.postCreatedTime forKey:kBrandActivitiesBrandsPostCreatedTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.postId] forKey:kBrandActivitiesBrandsPostId];
    [mutableDict setValue:self.postFile forKey:kBrandActivitiesBrandsPostFile];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandId] forKey:kBrandActivitiesBrandsBrandId];
    [mutableDict setValue:self.postCreatedAt forKey:kBrandActivitiesBrandsPostCreatedAt];
    [mutableDict setValue:self.brandLogo forKey:kBrandActivitiesBrandsBrandLogo];

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

    self.brandName = [aDecoder decodeObjectForKey:kBrandActivitiesBrandsBrandName];
    self.postCreatedTime = [aDecoder decodeObjectForKey:kBrandActivitiesBrandsPostCreatedTime];
    self.postId = [aDecoder decodeDoubleForKey:kBrandActivitiesBrandsPostId];
    self.postFile = [aDecoder decodeObjectForKey:kBrandActivitiesBrandsPostFile];
    self.brandId = [aDecoder decodeDoubleForKey:kBrandActivitiesBrandsBrandId];
    self.postCreatedAt = [aDecoder decodeObjectForKey:kBrandActivitiesBrandsPostCreatedAt];
    self.brandLogo = [aDecoder decodeObjectForKey:kBrandActivitiesBrandsBrandLogo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_brandName forKey:kBrandActivitiesBrandsBrandName];
    [aCoder encodeObject:_postCreatedTime forKey:kBrandActivitiesBrandsPostCreatedTime];
    [aCoder encodeDouble:_postId forKey:kBrandActivitiesBrandsPostId];
    [aCoder encodeObject:_postFile forKey:kBrandActivitiesBrandsPostFile];
    [aCoder encodeDouble:_brandId forKey:kBrandActivitiesBrandsBrandId];
    [aCoder encodeObject:_postCreatedAt forKey:kBrandActivitiesBrandsPostCreatedAt];
    [aCoder encodeObject:_brandLogo forKey:kBrandActivitiesBrandsBrandLogo];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandActivitiesBrands *copy = [[BrandActivitiesBrands alloc] init];
    
    if (copy) {

        copy.brandName = [self.brandName copyWithZone:zone];
        copy.postCreatedTime = [self.postCreatedTime copyWithZone:zone];
        copy.postId = self.postId;
        copy.postFile = [self.postFile copyWithZone:zone];
        copy.brandId = self.brandId;
        copy.postCreatedAt = [self.postCreatedAt copyWithZone:zone];
        copy.brandLogo = [self.brandLogo copyWithZone:zone];
    }
    
    return copy;
}


@end
