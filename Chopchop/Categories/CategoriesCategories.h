//
//  CategoriesCategories.h
//
//  Created by Ratna Kumalasari on 9/8/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CategoriesCategories : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sequence;
@property (nonatomic, assign) double categoriesIdentifier;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
