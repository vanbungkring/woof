//
//  BrandHottestUsersBrandsFollows.m
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandHottestUsersBrandsFollows.h"


NSString *const kBrandHottestUsersBrandsFollowsCreatedAt = @"created_at";


@interface BrandHottestUsersBrandsFollows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandHottestUsersBrandsFollows

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
            self.createdAt = [self objectOrNilForKey:kBrandHottestUsersBrandsFollowsCreatedAt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdAt forKey:kBrandHottestUsersBrandsFollowsCreatedAt];

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

    self.createdAt = [aDecoder decodeObjectForKey:kBrandHottestUsersBrandsFollowsCreatedAt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdAt forKey:kBrandHottestUsersBrandsFollowsCreatedAt];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandHottestUsersBrandsFollows *copy = [[BrandHottestUsersBrandsFollows alloc] init];
    
    if (copy) {

        copy.createdAt = [self.createdAt copyWithZone:zone];
    }
    
    return copy;
}


@end
