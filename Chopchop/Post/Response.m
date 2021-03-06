//
//  Response.m
//
//  Created by Ratna Kumalasari on 9/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Response.h"
#import "Posts.h"
#import "CommonHelper.h"
#import "APIManager.h"
#import "StaticAndPreferences.h"
NSString *const kResponseMessage = @"message";
NSString *const kResponsePosts = @"posts";
NSString *const kResponseCode = @"code";


@interface Response ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Response

@synthesize message = _message;
@synthesize posts = _posts;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kResponseMessage fromDictionary:dict];
    NSObject *receivedPosts = [dict objectForKey:kResponsePosts];
    NSMutableArray *parsedPosts = [NSMutableArray array];
    if ([receivedPosts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPosts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPosts addObject:[Posts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPosts isKindOfClass:[NSDictionary class]]) {
       [parsedPosts addObject:[Posts modelObjectWithDictionary:(NSDictionary *)receivedPosts]];
    }

    self.posts = [NSArray arrayWithArray:parsedPosts];
            self.code = [[self objectOrNilForKey:kResponseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kResponseMessage];
    NSMutableArray *tempArrayForPosts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.posts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPosts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPosts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPosts] forKey:kResponsePosts];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kResponseCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kResponseMessage];
    self.posts = [aDecoder decodeObjectForKey:kResponsePosts];
    self.code = [aDecoder decodeDoubleForKey:kResponseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kResponseMessage];
    [aCoder encodeObject:_posts forKey:kResponsePosts];
    [aCoder encodeDouble:_code forKey:kResponseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    Response *copy = [[Response alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.posts = [self.posts copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
+ (NSURLSessionDataTask *)getAllPost:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"posts/get?api_key=%@",API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        for (NSDictionary *attributes in [responseObject valueForKey:@"posts"]) {
            Posts *userData = [[Posts alloc] initWithDictionary:attributes];
            [mutablePosts addObject:userData];
        }
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
    
}

+ (NSURLSessionDataTask *)getAllWishList:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
        [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    return [[APIManager sharedClient] GET:[NSString stringWithFormat:@"posts/wishlisted?api_key=%@",API_KEY] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        for (NSDictionary *attributes in [responseObject valueForKey:@"posts"]) {
            Posts *userData = [[Posts alloc] initWithDictionary:attributes];
            [mutablePosts addObject:userData];
        }
        if (completion) {
            completion([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion([NSArray array], error);
        }
    }];
    
}
+ (NSURLSessionDataTask *)postLike:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
         [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    
    if ([[parameters objectForKey:@"status"] boolValue] == 1) {
        return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"posts/like?api_key=%@&token=%@&post_id=%@",API_KEY,[[NSUserDefaults standardUserDefaults]objectForKey:PREFS_USER_TOKEN],[dict objectForKey:@"post_id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
            if (completion) {
                completion([NSArray arrayWithArray:mutablePosts], nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (completion) {
                completion([NSArray array], error);
            }
        }];
    }
    else {
        return [[APIManager sharedClient] DELETE:[NSString stringWithFormat:@"posts/unlike?api_key=%@&token=%@&post_id=%@",API_KEY,[[NSUserDefaults standardUserDefaults]objectForKey:PREFS_USER_TOKEN],[dict objectForKey:@"post_id"]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
           
            if (completion) {
                completion([NSArray arrayWithArray:mutablePosts], nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (completion) {
                completion([NSArray array], error);
            }
        }];
    }
    
}
+ (NSURLSessionDataTask *)postWishList:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *json,NSError *error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([CommonHelper loginUser]) {
         [dict setObject:[CommonHelper userToken] forKey:@"token"];
    }
    NSLog(@"dict->%@",dict);
    if ([[parameters objectForKey:@"status"] boolValue] == 1) {
        return [[APIManager sharedClient] POST:[NSString stringWithFormat:@"posts/wishlist?api_key=%@&token=%@&post_id=%@",API_KEY,[dict objectForKey:@"token"],[parameters objectForKey:@"post_id"]] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
            if (completion) {
                completion([NSArray arrayWithArray:mutablePosts], nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (completion) {
                completion([NSArray array], error);
            }
        }];
    }
    else {
        return [[APIManager sharedClient] DELETE:[NSString stringWithFormat:@"posts/unwishlist?api_key=%@&token=%@&post_id=%@",API_KEY,[[NSUserDefaults standardUserDefaults]objectForKey:PREFS_USER_TOKEN],[parameters objectForKey:@"post_id"]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
            
            if (completion) {
                completion([NSArray arrayWithArray:mutablePosts], nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (completion) {
                completion([NSArray array], error);
            }
        }];
    }
    
}


@end
