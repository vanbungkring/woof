//
//  LocationsActivityDistance.h
//
//  Created by Ratna Kumalasari on 12/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocationsActivityDistance : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *miles;
@property (nonatomic, assign) double km;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
