//
//  BrandHottestMatchingData.h
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrandHottestUsersBrandsFollows;

@interface BrandHottestMatchingData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) BrandHottestUsersBrandsFollows *usersBrandsFollows;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
