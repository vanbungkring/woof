//
//  LocationHottestMatchingData.h
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationHottestUsersLocationsFollows;

@interface LocationHottestMatchingData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LocationHottestUsersLocationsFollows *usersLocationsFollows;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
