//
//  LocationBrand.h
//
//  Created by Ratna Kumalasari on 11/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocationBrand : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, assign) double brandIdentifier;
@property (nonatomic, assign) BOOL followed;
@property (nonatomic, assign) double followers;
@property (nonatomic, assign) double likes;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *activePosts;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
