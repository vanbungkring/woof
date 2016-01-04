//
//  BrandActivitiesBrands.h
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BrandActivitiesBrands : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *postCreatedTime;
@property (nonatomic, assign) double postId;
@property (nonatomic, strong) NSString *postFile;
@property (nonatomic, assign) double brandId;
@property (nonatomic, strong) NSString *postCreatedAt;
@property (nonatomic, strong) NSString *brandLogo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
