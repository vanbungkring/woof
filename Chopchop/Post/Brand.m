//
//  Brand.m
//
//  Created by Ratna Kumalasari on 10/22/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Brand.h"


NSString *const kBrandRelated = @"related";
NSString *const kBrandId = @"id";
NSString *const kBrandLogo = @"logo";
NSString *const kBrandWebsite = @"website";
NSString *const kBrandName = @"name";
NSString *const kBrandFollower = @"follower";


@interface Brand ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Brand

@synthesize related = _related;
@synthesize brandIdentifier = _brandIdentifier;
@synthesize logo = _logo;
@synthesize website = _website;
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
        self.related = [self objectOrNilForKey:kBrandRelated fromDictionary:dict];
        self.brandIdentifier = [[self objectOrNilForKey:kBrandId fromDictionary:dict] doubleValue];
        self.logo = [self objectOrNilForKey:kBrandLogo fromDictionary:dict];
        self.website = [self objectOrNilForKey:kBrandWebsite fromDictionary:dict];
        self.name = [self objectOrNilForKey:kBrandName fromDictionary:dict];
        self.follower = [[self objectOrNilForKey:kBrandFollower fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRelated = [NSMutableArray array];
    for (NSObject *subArrayObject in self.related) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelated addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelated addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelated] forKey:kBrandRelated];
    [mutableDict setValue:[NSNumber numberWithDouble:self.brandIdentifier] forKey:kBrandId];
    [mutableDict setValue:self.logo forKey:kBrandLogo];
    [mutableDict setValue:self.website forKey:kBrandWebsite];
    [mutableDict setValue:self.name forKey:kBrandName];
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
    
    self.related = [aDecoder decodeObjectForKey:kBrandRelated];
    self.brandIdentifier = [aDecoder decodeDoubleForKey:kBrandId];
    self.logo = [aDecoder decodeObjectForKey:kBrandLogo];
    self.website = [aDecoder decodeObjectForKey:kBrandWebsite];
    self.name = [aDecoder decodeObjectForKey:kBrandName];
    self.follower = [aDecoder decodeDoubleForKey:kBrandFollower];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_related forKey:kBrandRelated];
    [aCoder encodeDouble:_brandIdentifier forKey:kBrandId];
    [aCoder encodeObject:_logo forKey:kBrandLogo];
    [aCoder encodeObject:_website forKey:kBrandWebsite];
    [aCoder encodeObject:_name forKey:kBrandName];
    [aCoder encodeDouble:_follower forKey:kBrandFollower];
}

- (id)copyWithZone:(NSZone *)zone
{
    Brand *copy = [[Brand alloc] init];
    
    if (copy) {
        
        copy.related = [self.related copyWithZone:zone];
        copy.brandIdentifier = self.brandIdentifier;
        copy.logo = [self.logo copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.follower = self.follower;
    }
    
    return copy;
}


@end
