//
//  CategoriesCategories.h
//
//  Created by Ratna Kumalasari on 9/8/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface CategoriesCategories : RLMObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sequence;
@property (nonatomic) BOOL isActive;
@property (nonatomic, assign) NSInteger categoriesIdentifier;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL selected;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
