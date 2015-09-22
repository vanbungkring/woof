//
//  APIManager.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
+ (NSURLSessionDataTask *)initAppWithDictionary:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion;
@end
