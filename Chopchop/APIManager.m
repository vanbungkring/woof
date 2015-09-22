//
//  APIManager.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "APIManager.h"
#import "StaticAndPreferences.h"
@implementation APIManager
+ (instancetype)sharedClient {
    static APIManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:API_URL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //application/json
    });
    
    return _sharedClient;
}
+ (NSURLSessionDataTask *)initAppWithDictionary:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    return [[APIManager sharedClient] GET:@"tokens/get" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion([NSArray arrayWithObject:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], nil);
        }
    }];
    
}
@end
