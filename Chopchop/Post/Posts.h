//
//  Posts.h
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location, Brand;

@interface Posts : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double postsIdentifier;
@property (nonatomic, assign) double discount;
@property (nonatomic, strong) NSString *expiredTime;
@property (nonatomic, strong) NSString *postsDescription;
@property (nonatomic, strong) Brand *brand;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *files;
@property (nonatomic, strong) NSString *expiredDate;
@property (nonatomic, strong) Location *location;
@property (nonatomic, assign) BOOL wishlist;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, strong) NSString *status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
