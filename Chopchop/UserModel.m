//
//  UserModel.m
//  Chopchop
//
//  Created by Arie on 10/3/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "UserModel.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"
@implementation UserModel
+ (NSURLSessionDataTask *)registerUser:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"users/register?api_key=%@",API_KEY] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (completion) {
            completion([NSArray arrayWithObject:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}
+ (NSURLSessionDataTask *)loginUser:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"users/login?api_key=%@",API_KEY] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (completion) {
            completion([NSArray arrayWithObject:responseObject], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}
@end
