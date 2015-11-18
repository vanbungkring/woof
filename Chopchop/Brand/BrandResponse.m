//
//  BrandResponse.m
//
//  Created by Ratna Kumalasari on 11/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandResponse.h"
#import "BrandBrand.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"

NSString *const kBrandResponseMessage = @"message";
NSString *const kBrandResponseBrand = @"brand";
NSString *const kBrandResponseCode = @"code";


@interface BrandResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandResponse

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
        self.message = [self objectOrNilForKey:kBrandResponseMessage fromDictionary:dict];
        self.brand = [BrandBrand modelObjectWithDictionary:[dict objectForKey:kBrandResponseBrand]];
        self.code = [[self objectOrNilForKey:kBrandResponseCode fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kBrandResponseMessage];
    [mutableDict setValue:[self.brand dictionaryRepresentation] forKey:kBrandResponseBrand];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBrandResponseCode];
    
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
    
    self.message = [aDecoder decodeObjectForKey:kBrandResponseMessage];
    self.brand = [aDecoder decodeObjectForKey:kBrandResponseBrand];
    self.code = [aDecoder decodeDoubleForKey:kBrandResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_message forKey:kBrandResponseMessage];
    [aCoder encodeObject:_brand forKey:kBrandResponseBrand];
    [aCoder encodeDouble:_code forKey:kBrandResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandResponse *copy = [[BrandResponse alloc] init];
    
    if (copy) {
        
        copy.message = [self.message copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"brands/view/%@/?api_key=%@",[parameters objectForKey:@"id"],API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        BrandBrand *userData = [[BrandBrand alloc] initWithDictionary:[responseObject valueForKey:@"brand"]];
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

+ (NSURLSessionDataTask *)followBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"brands/follow/?api_key=%@&token=%@&brand_id=%@",API_KEY,[CommonHelper userToken],[parameters objectForKey:@"id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
}
+ (NSURLSessionDataTask *)unFollowBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] DELETE:[NSString stringWithFormat:@"brands/unfollow/?api_key=%@&token=%@&brand_id=%@",API_KEY,[CommonHelper userToken],[parameters objectForKey:@"id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
}
+ (NSURLSessionDataTask *)followLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"location/follow/?api_key=%@&token=%@&brand_id=%@",API_KEY,[CommonHelper userToken],[parameters objectForKey:@"id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];

}
+ (NSURLSessionDataTask *)unFollowLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] DELETE:[NSString stringWithFormat:@"location/unfollow/?api_key=%@&token=%@&brand_id=%@",API_KEY,[CommonHelper userToken],[parameters objectForKey:@"id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
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
