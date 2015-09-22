//
//  Location.h
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Distance;

@interface Location : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double follower;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, assign) double locationIdentifier;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) Distance *distance;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
