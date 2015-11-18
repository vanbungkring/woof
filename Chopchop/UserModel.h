//
//  UserModel.h
//  Chopchop
//
//  Created by Arie on 10/3/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
+ (NSURLSessionDataTask *)registerUser:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
+ (NSURLSessionDataTask *)loginUser:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
@end
