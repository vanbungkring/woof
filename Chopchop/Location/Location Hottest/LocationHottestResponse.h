//
//  LocationHottestResponse.h
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocationHottestResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getLocationsHottest:(void(^)(NSArray *json,NSError *error))completion;

@end
