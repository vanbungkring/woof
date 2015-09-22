//
//  Response.h
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Response : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getAllPost:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
@end
