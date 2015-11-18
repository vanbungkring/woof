//
//  Brand.h
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Brand : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *related;
@property (nonatomic, assign) double follower;
@property (nonatomic, assign) double brandIdentifier;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logo;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
