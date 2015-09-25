//
//  CategoriesResponse.m
//
//  Created by Ratna Kumalasari on 9/8/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CategoriesResponse.h"
#import "CategoriesCategories.h"
#import "DataBaseManager.h"
#import "APIManager.h"
#import <Realm.h>
NSString *const kCategoriesResponseMessage = @"message";
NSString *const kCategoriesResponseCategories = @"categories";
NSString *const kCategoriesResponseCode = @"code";


@interface CategoriesResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoriesResponse

@synthesize message = _message;
@synthesize categories = _categories;
@synthesize code = _code;


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
            self.message = [self objectOrNilForKey:kCategoriesResponseMessage fromDictionary:dict];
    NSObject *receivedCategoriesCategories = [dict objectForKey:kCategoriesResponseCategories];
    NSMutableArray *parsedCategoriesCategories = [NSMutableArray array];
    if ([receivedCategoriesCategories isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCategoriesCategories) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCategoriesCategories addObject:[CategoriesCategories modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCategoriesCategories isKindOfClass:[NSDictionary class]]) {
       [parsedCategoriesCategories addObject:[CategoriesCategories modelObjectWithDictionary:(NSDictionary *)receivedCategoriesCategories]];
    }

    self.categories = [NSArray arrayWithArray:parsedCategoriesCategories];
            self.code = [[self objectOrNilForKey:kCategoriesResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kCategoriesResponseMessage];
    NSMutableArray *tempArrayForCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategories] forKey:kCategoriesResponseCategories];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kCategoriesResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kCategoriesResponseMessage];
    self.categories = [aDecoder decodeObjectForKey:kCategoriesResponseCategories];
    self.code = [aDecoder decodeDoubleForKey:kCategoriesResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kCategoriesResponseMessage];
    [aCoder encodeObject:_categories forKey:kCategoriesResponseCategories];
    [aCoder encodeDouble:_code forKey:kCategoriesResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    CategoriesResponse *copy = [[CategoriesResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.categories = [self.categories copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getAllCategories:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    return [[APIManager sharedClient] GET:@"categories" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        for (NSDictionary *attributes in [responseObject valueForKey:@"categories"]) {
            CategoriesCategories *userData = [[CategoriesCategories alloc] initWithDictionary:attributes];
            [mutablePosts addObject:userData];
        }
        if (completion) {
            [CategoriesResponse storeToDb:mutablePosts];
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
}
+ (NSArray *)allCategories {
    RLMResults *resultsRealm = [CategoriesCategories allObjectsInRealm:[RLMRealm defaultRealm]];
    NSMutableArray *result = [NSMutableArray array];
    for (RLMObject *obj in resultsRealm) {
        [result addObject:obj];
    }
    
    return result;
}

+ (void)storeToDb:(NSArray *)categories {
    for (int i = 0; i < categories.count; i++) {
        CategoriesCategories *category = (CategoriesCategories *)[categories objectAtIndex:i];
        [[DataBaseManager manager] writeOrUpdateObject:category];
    }
}
@end
