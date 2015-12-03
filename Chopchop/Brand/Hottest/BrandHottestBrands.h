//
//  BrandHottestBrands.h
//
//  Created by Ratna Kumalasari on 12/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrandHottestMatchingData;

@interface BrandHottestBrands : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double brandsIdentifier;
@property (nonatomic, strong) NSString *followers;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) BrandHottestMatchingData *matchingData;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
