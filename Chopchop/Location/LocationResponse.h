//
//  LocationResponse.h
//
//  Created by Ratna Kumalasari on 11/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationBrand;

@interface LocationResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) LocationBrand *brand;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getLocation:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
@end
