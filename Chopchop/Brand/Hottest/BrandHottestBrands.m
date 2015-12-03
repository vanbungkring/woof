//
//  BrandHottestBrands.m
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandHottestBrands.h"
#import "BrandHottestMatchingData.h"


NSString *const kBrandHottestBrandsId = @"id";
NSString *const kBrandHottestBrandsFollowers = @"followers";
NSString *const kBrandHottestBrandsName = @"name";
NSString *const kBrandHottestBrandsCover = @"cover";
NSString *const kBrandHottestBrandsMatchingData = @"_matchingData";


@interface BrandHottestBrands ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandHottestBrands

@synthesize brandsIdentifier = _brandsIdentifier;
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
            self.brandsIdentifier = [[self objectOrNilForKey:kBrandHottestBrandsId fromDictionary:dict] doubleValue];
            self.followers = [self objectOrNilForKey:kBrandHottestBrandsFollowers fromDictionary:dict];
            self.name = [self objectOrNilForKey:kBrandHottestBrandsName fromDictionary:dict];
            self.cover = [self objectOrNilForKey:kBrandHottestBrandsCover fromDictionary:dict];
            self.matchingData = [BrandHottestMatchingData modelObjectWithDictionary:[dict objectForKey:kBrandHottestBrandsMatchingData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandsIdentifier] forKey:kBrandHottestBrandsId];
    [mutableDict setValue:self.followers forKey:kBrandHottestBrandsFollowers];
    [mutableDict setValue:self.name forKey:kBrandHottestBrandsName];
    [mutableDict setValue:self.cover forKey:kBrandHottestBrandsCover];
    [mutableDict setValue:[self.matchingData dictionaryRepresentation] forKey:kBrandHottestBrandsMatchingData];

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

    self.brandsIdentifier = [aDecoder decodeDoubleForKey:kBrandHottestBrandsId];
    self.followers = [aDecoder decodeObjectForKey:kBrandHottestBrandsFollowers];
    self.name = [aDecoder decodeObjectForKey:kBrandHottestBrandsName];
    self.cover = [aDecoder decodeObjectForKey:kBrandHottestBrandsCover];
    self.matchingData = [aDecoder decodeObjectForKey:kBrandHottestBrandsMatchingData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_brandsIdentifier forKey:kBrandHottestBrandsId];
    [aCoder encodeObject:_followers forKey:kBrandHottestBrandsFollowers];
    [aCoder encodeObject:_name forKey:kBrandHottestBrandsName];
    [aCoder encodeObject:_cover forKey:kBrandHottestBrandsCover];
    [aCoder encodeObject:_matchingData forKey:kBrandHottestBrandsMatchingData];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandHottestBrands *copy = [[BrandHottestBrands alloc] init];
    
    if (copy) {

        copy.brandsIdentifier = self.brandsIdentifier;
        copy.followers = [self.followers copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.cover = [self.cover copyWithZone:zone];
        copy.matchingData = [self.matchingData copyWithZone:zone];
    }
    
    return copy;
}


@end
