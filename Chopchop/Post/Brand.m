//
//  Brand.m
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Brand.h"


NSString *const kBrandId = @"id";
NSString *const kBrandName = @"name";
NSString *const kBrandFollower = @"follower";
NSString *const kBrandLogo = @"logo";


@interface Brand ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Brand

@synthesize brandIdentifier = _brandIdentifier;
@synthesize name = _name;
@synthesize follower = _follower;


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
        self.brandIdentifier = [[self objectOrNilForKey:kBrandId fromDictionary:dict] doubleValue];
        self.name = [self objectOrNilForKey:kBrandName fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kBrandLogo fromDictionary:dict];
        self.follower = [[self objectOrNilForKey:kBrandFollower fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandIdentifier] forKey:kBrandId];
    [mutableDict setValue:self.name forKey:kBrandName];
    [mutableDict setValue:self.logo forKey:kBrandLogo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.follower] forKey:kBrandFollower];
    
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
    
    self.brandIdentifier = [aDecoder decodeDoubleForKey:kBrandId];
    self.name = [aDecoder decodeObjectForKey:kBrandName];
    self.logo = [aDecoder decodeObjectForKey:kBrandLogo];
    self.follower = [aDecoder decodeDoubleForKey:kBrandFollower];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_brandIdentifier forKey:kBrandId];
    [aCoder encodeObject:_name forKey:kBrandName];
    [aCoder encodeDouble:_follower forKey:kBrandFollower];
}

- (id)copyWithZone:(NSZone *)zone
{
    Brand *copy = [[Brand alloc] init];
    
    if (copy) {
        
        copy.brandIdentifier = self.brandIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.follower = self.follower;
    }
    
    return copy;
}


@end
