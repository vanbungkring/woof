//
//  CategoriesCategories.m
//
//  Created by Ratna Kumalasari on 9/8/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CategoriesCategories.h"


NSString *const kCategoriesCategoriesSequence = @"sequence";
NSString *const kCategoriesCategoriesId = @"id";
NSString *const kCategoriesCategoriesIcon = @"icon";
NSString *const kCategoriesCategoriesName = @"name";


@interface CategoriesCategories ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoriesCategories

@synthesize sequence = _sequence;
@synthesize categoriesIdentifier = _categoriesIdentifier;
@synthesize icon = _icon;
@synthesize name = _name;


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
            self.sequence = [[self objectOrNilForKey:kCategoriesCategoriesSequence fromDictionary:dict] doubleValue];
            self.categoriesIdentifier = [[self objectOrNilForKey:kCategoriesCategoriesId fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kCategoriesCategoriesIcon fromDictionary:dict];
            self.name = [self objectOrNilForKey:kCategoriesCategoriesName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sequence] forKey:kCategoriesCategoriesSequence];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoriesIdentifier] forKey:kCategoriesCategoriesId];
    [mutableDict setValue:self.icon forKey:kCategoriesCategoriesIcon];
    [mutableDict setValue:self.name forKey:kCategoriesCategoriesName];

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

    self.sequence = [aDecoder decodeDoubleForKey:kCategoriesCategoriesSequence];
    self.categoriesIdentifier = [aDecoder decodeDoubleForKey:kCategoriesCategoriesId];
    self.icon = [aDecoder decodeObjectForKey:kCategoriesCategoriesIcon];
    self.name = [aDecoder decodeObjectForKey:kCategoriesCategoriesName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sequence forKey:kCategoriesCategoriesSequence];
    [aCoder encodeDouble:_categoriesIdentifier forKey:kCategoriesCategoriesId];
    [aCoder encodeObject:_icon forKey:kCategoriesCategoriesIcon];
    [aCoder encodeObject:_name forKey:kCategoriesCategoriesName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CategoriesCategories *copy = [[CategoriesCategories alloc] init];
    
    if (copy) {

        copy.sequence = self.sequence;
        copy.categoriesIdentifier = self.categoriesIdentifier;
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
