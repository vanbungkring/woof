//
//  BrandHottestResponse.m
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BrandHottestResponse.h"
#import "BrandHottestBrands.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "DataModels.h"
#import "StaticAndPreferences.h"

NSString *const kBrandHottestResponseMessage = @"message";
NSString *const kBrandHottestResponseBrands = @"brands";
NSString *const kBrandHottestResponseCode = @"code";


@interface BrandHottestResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BrandHottestResponse

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
            self.message = [self objectOrNilForKey:kBrandHottestResponseMessage fromDictionary:dict];
    NSObject *receivedBrandHottestBrands = [dict objectForKey:kBrandHottestResponseBrands];
    NSMutableArray *parsedBrandHottestBrands = [NSMutableArray array];
    if ([receivedBrandHottestBrands isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBrandHottestBrands) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBrandHottestBrands addObject:[BrandHottestBrands modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBrandHottestBrands isKindOfClass:[NSDictionary class]]) {
       [parsedBrandHottestBrands addObject:[BrandHottestBrands modelObjectWithDictionary:(NSDictionary *)receivedBrandHottestBrands]];
    }

    self.brands = [NSArray arrayWithArray:parsedBrandHottestBrands];
            self.code = [[self objectOrNilForKey:kBrandHottestResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kBrandHottestResponseMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBrands] forKey:kBrandHottestResponseBrands];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBrandHottestResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kBrandHottestResponseMessage];
    self.brands = [aDecoder decodeObjectForKey:kBrandHottestResponseBrands];
    self.code = [aDecoder decodeDoubleForKey:kBrandHottestResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kBrandHottestResponseMessage];
    [aCoder encodeObject:_brands forKey:kBrandHottestResponseBrands];
    [aCoder encodeDouble:_code forKey:kBrandHottestResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    BrandHottestResponse *copy = [[BrandHottestResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.brands = [self.brands copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getBrandHottest:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    
    return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"brands/hottest/?api_key=%@&token=%@",API_KEY,[CommonHelper userToken]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        NSLog(@"response object->%@",responseObject);
        
        for (NSDictionary *brand in [responseObject valueForKey:@"brands"]) {
            BrandHottestBrands *userData = [[BrandHottestBrands alloc] initWithDictionary:brand];
            [mutablePosts addObject:userData];
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
