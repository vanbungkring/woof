//
//  LocationHottestResponse.m
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationHottestResponse.h"
#import "LocationHottestLocations.h"
#import "CommonHelper.h"
#import "StaticAndPreferences.h"
#import "APIManager.h"

NSString *const kLocationHottestResponseMessage = @"message";
NSString *const kLocationHottestResponseLocations = @"locations";
NSString *const kLocationHottestResponseCode = @"code";


@interface LocationHottestResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationHottestResponse

@synthesize message = _message;
@synthesize locations = _locations;
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
            self.message = [self objectOrNilForKey:kLocationHottestResponseMessage fromDictionary:dict];
    NSObject *receivedLocationHottestLocations = [dict objectForKey:kLocationHottestResponseLocations];
    NSMutableArray *parsedLocationHottestLocations = [NSMutableArray array];
    if ([receivedLocationHottestLocations isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLocationHottestLocations) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLocationHottestLocations addObject:[LocationHottestLocations modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLocationHottestLocations isKindOfClass:[NSDictionary class]]) {
       [parsedLocationHottestLocations addObject:[LocationHottestLocations modelObjectWithDictionary:(NSDictionary *)receivedLocationHottestLocations]];
    }

    self.locations = [NSArray arrayWithArray:parsedLocationHottestLocations];
            self.code = [[self objectOrNilForKey:kLocationHottestResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kLocationHottestResponseMessage];
    NSMutableArray *tempArrayForLocations = [NSMutableArray array];
    for (NSObject *subArrayObject in self.locations) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLocations addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLocations addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLocations] forKey:kLocationHottestResponseLocations];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kLocationHottestResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kLocationHottestResponseMessage];
    self.locations = [aDecoder decodeObjectForKey:kLocationHottestResponseLocations];
    self.code = [aDecoder decodeDoubleForKey:kLocationHottestResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kLocationHottestResponseMessage];
    [aCoder encodeObject:_locations forKey:kLocationHottestResponseLocations];
    [aCoder encodeDouble:_code forKey:kLocationHottestResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationHottestResponse *copy = [[LocationHottestResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.locations = [self.locations copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getLocationsHottest:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"locations/hottest/?api_key=%@&token=%@",API_KEY,[CommonHelper userToken]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        NSLog(@"response object->%@",responseObject);
        
        for (NSDictionary *brand in [responseObject valueForKey:@"locations"]) {
            LocationHottestLocations *userData = [[LocationHottestLocations alloc] initWithDictionary:brand];
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
