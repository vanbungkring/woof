//
//  BrandResponse.h
//
//  Created by Ratna Kumalasari on 11/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrandBrand;

@interface BrandResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) BrandBrand *brand;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (NSURLSessionDataTask *)followBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (NSURLSessionDataTask *)unFollowBrand:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (NSURLSessionDataTask *)followLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (NSURLSessionDataTask *)unFollowLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
@end
