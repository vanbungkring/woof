//
//  BrandHottestMatchingData.m
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandHottestMatchingData.h"
#import "BrandHottestUsersBrandsFollows.h"


NSString *const kBrandHottestMatchingDataUsersBrandsFollows = @"UsersBrandsFollows";


@interface BrandHottestMatchingData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandHottestMatchingData

@synthesize usersBrandsFollows = _usersBrandsFollows;


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
            self.usersBrandsFollows = [BrandHottestUsersBrandsFollows modelObjectWithDictionary:[dict objectForKey:kBrandHottestMatchingDataUsersBrandsFollows]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.usersBrandsFollows dictionaryRepresentation] forKey:kBrandHottestMatchingDataUsersBrandsFollows];

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

    self.usersBrandsFollows = [aDecoder decodeObjectForKey:kBrandHottestMatchingDataUsersBrandsFollows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_usersBrandsFollows forKey:kBrandHottestMatchingDataUsersBrandsFollows];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandHottestMatchingData *copy = [[BrandHottestMatchingData alloc] init];
    
    if (copy) {

        copy.usersBrandsFollows = [self.usersBrandsFollows copyWithZone:zone];
    }
    
    return copy;
}


@end
