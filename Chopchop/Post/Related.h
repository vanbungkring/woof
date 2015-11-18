//
//  Related.h
//
//  Created by Ratna Kumalasari on 10/22/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Brand;

@interface Related : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double postId;
@property (nonatomic, strong) Brand *brand;
@property (nonatomic, assign) double brandId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
