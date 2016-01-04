//
//  LocationHottestUsersLocationsFollows.h
//
//  Created by Ratna Kumalasari on 12/10/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocationHottestUsersLocationsFollows : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdAt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
