//
//  BrandActivitiesResponse.h
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandActivitiesResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getBrandActivity:(void(^)(NSArray *json,NSError *error))completion;
@end
