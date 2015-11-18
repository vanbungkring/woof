//
//  Related.m
//
//  Created by Ratna Kumalasari on 10/22/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Related.h"
#import "Brand.h"


NSString *const kRelatedPostId = @"post_id";
NSString *const kRelatedBrand = @"brand";
NSString *const kRelatedBrandId = @"brand_id";


@interface Related ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Related

@synthesize postId = _postId;
@synthesize brand = _brand;
@synthesize brandId = _brandId;


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
            self.postId = [[self objectOrNilForKey:kRelatedPostId fromDictionary:dict] doubleValue];
            self.brand = [Brand modelObjectWithDictionary:[dict objectForKey:kRelatedBrand]];
            self.brandId = [[self objectOrNilForKey:kRelatedBrandId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.postId] forKey:kRelatedPostId];
    [mutableDict setValue:[self.brand dictionaryRepresentation] forKey:kRelatedBrand];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandId] forKey:kRelatedBrandId];

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

    self.postId = [aDecoder decodeDoubleForKey:kRelatedPostId];
    self.brand = [aDecoder decodeObjectForKey:kRelatedBrand];
    self.brandId = [aDecoder decodeDoubleForKey:kRelatedBrandId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_postId forKey:kRelatedPostId];
    [aCoder encodeObject:_brand forKey:kRelatedBrand];
    [aCoder encodeDouble:_brandId forKey:kRelatedBrandId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Related *copy = [[Related alloc] init];
    
    if (copy) {

        copy.postId = self.postId;
        copy.brand = [self.brand copyWithZone:zone];
        copy.brandId = self.brandId;
    }
    
    return copy;
}


@end
