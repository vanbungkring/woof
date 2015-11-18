//
//  LocationResponse.m
//
//  Created by Ratna Kumalasari on 11/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationResponse.h"
#import "LocationBrand.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"


NSString *const kLocationResponseMessage = @"message";
NSString *const kLocationResponseBrand = @"brand";
NSString *const kLocationResponseCode = @"code";


@interface LocationResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationResponse

@synthesize message = _message;
@synthesize brand = _brand;
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
            self.message = [self objectOrNilForKey:kLocationResponseMessage fromDictionary:dict];
            self.brand = [LocationBrand modelObjectWithDictionary:[dict objectForKey:kLocationResponseBrand]];
            self.code = [[self objectOrNilForKey:kLocationResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kLocationResponseMessage];
    [mutableDict setValue:[self.brand dictionaryRepresentation] forKey:kLocationResponseBrand];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kLocationResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kLocationResponseMessage];
    self.brand = [aDecoder decodeObjectForKey:kLocationResponseBrand];
    self.code = [aDecoder decodeDoubleForKey:kLocationResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kLocationResponseMessage];
    [aCoder encodeObject:_brand forKey:kLocationResponseBrand];
    [aCoder encodeDouble:_code forKey:kLocationResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationResponse *copy = [[LocationResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"brands/view/%@/?api_key=%@",[parameters objectForKey:@"id"],API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        LocationBrand *userData = [[LocationBrand alloc] initWithDictionary:[responseObject valueForKey:@"brand"]];
        [mutablePosts addObject:userData];
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
