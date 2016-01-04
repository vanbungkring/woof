//
//  BrandActivitiesResponse.m
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandActivitiesResponse.h"
#import "BrandActivitiesBrands.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"
NSString *const kBrandActivitiesResponseMessage = @"message";
NSString *const kBrandActivitiesResponseBrands = @"brands";
NSString *const kBrandActivitiesResponseCode = @"code";


@interface BrandActivitiesResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandActivitiesResponse

@synthesize message = _message;
@synthesize brands = _brands;
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
            self.message = [self objectOrNilForKey:kBrandActivitiesResponseMessage fromDictionary:dict];
    NSObject *receivedBrandActivitiesBrands = [dict objectForKey:kBrandActivitiesResponseBrands];
    NSMutableArray *parsedBrandActivitiesBrands = [NSMutableArray array];
    if ([receivedBrandActivitiesBrands isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandActivitiesBrands) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandActivitiesBrands addObject:[BrandActivitiesBrands modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandActivitiesBrands isKindOfClass:[NSDictionary class]]) {
       [parsedBrandActivitiesBrands addObject:[BrandActivitiesBrands modelObjectWithDictionary:(NSDictionary *)receivedBrandActivitiesBrands]];
    }

    self.brands = [NSArray arrayWithArray:parsedBrandActivitiesBrands];
            self.code = [[self objectOrNilForKey:kBrandActivitiesResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kBrandActivitiesResponseMessage];
    NSMutableArray *tempArrayForBrands = [NSMutableArray array];
    for (NSObject *subArrayObject in self.brands) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBrands addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBrands addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBrands] forKey:kBrandActivitiesResponseBrands];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBrandActivitiesResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kBrandActivitiesResponseMessage];
    self.brands = [aDecoder decodeObjectForKey:kBrandActivitiesResponseBrands];
    self.code = [aDecoder decodeDoubleForKey:kBrandActivitiesResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kBrandActivitiesResponseMessage];
    [aCoder encodeObject:_brands forKey:kBrandActivitiesResponseBrands];
    [aCoder encodeDouble:_code forKey:kBrandActivitiesResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandActivitiesResponse *copy = [[BrandActivitiesResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.brands = [self.brands copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getBrandActivity:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"brands/activity?api_key=%@",API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in [responseObject objectForKey:@"brands"]) {
            BrandActivitiesBrands *brands = [[BrandActivitiesBrands alloc]initWithDictionary:dict];
            [mutablePosts addObject:brands];
        }
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
}

@end
