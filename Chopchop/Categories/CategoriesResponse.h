//
//  CategoriesResponse.h
//
//  Created by Ratna Kumalasari on 9/8/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface CategoriesResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)getAllCategories:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (void)storeToDb:(NSArray *)categories;
+ (NSArray *)allCategories;
@end
