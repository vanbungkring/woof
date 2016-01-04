//
//  LocationsActivityResponse.m
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LocationsActivityResponse.h"
#import "LocationsActivityLocations.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"

NSString *const kLocationsActivityResponseMessage = @"message";
NSString *const kLocationsActivityResponseLocations = @"locations";
NSString *const kLocationsActivityResponseCode = @"code";


@interface LocationsActivityResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LocationsActivityResponse

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
            self.message = [self objectOrNilForKey:kLocationsActivityResponseMessage fromDictionary:dict];
    NSObject *receivedLocationsActivityLocations = [dict objectForKey:kLocationsActivityResponseLocations];
    NSMutableArray *parsedLocationsActivityLocations = [NSMutableArray array];
    if ([receivedLocationsActivityLocations isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLocationsActivityLocations) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLocationsActivityLocations addObject:[LocationsActivityLocations modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLocationsActivityLocations isKindOfClass:[NSDictionary class]]) {
       [parsedLocationsActivityLocations addObject:[LocationsActivityLocations modelObjectWithDictionary:(NSDictionary *)receivedLocationsActivityLocations]];
    }

    self.locations = [NSArray arrayWithArray:parsedLocationsActivityLocations];
            self.code = [[self objectOrNilForKey:kLocationsActivityResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kLocationsActivityResponseMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLocations] forKey:kLocationsActivityResponseLocations];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kLocationsActivityResponseCode];

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

    self.message = [aDecoder decodeObjectForKey:kLocationsActivityResponseMessage];
    self.locations = [aDecoder decodeObjectForKey:kLocationsActivityResponseLocations];
    self.code = [aDecoder decodeDoubleForKey:kLocationsActivityResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kLocationsActivityResponseMessage];
    [aCoder encodeObject:_locations forKey:kLocationsActivityResponseLocations];
    [aCoder encodeDouble:_code forKey:kLocationsActivityResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    LocationsActivityResponse *copy = [[LocationsActivityResponse alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.locations = [self.locations copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}

+ (NSURLSessionDataTask *)getLocationActivity:(NSDictionary *)params completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:params];
    
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"locations/activity?api_key=%@",API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in [responseObject objectForKey:@"locations"]) {
            LocationsActivityLocations *locations = [[LocationsActivityLocations alloc]initWithDictionary:dict];
            [mutablePosts addObject:locations];
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
