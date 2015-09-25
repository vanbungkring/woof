//
//  DataBaseManager.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "DataBaseManager.h"

const NSInteger REALM_SCHEMA_VERSION = 3;

@implementation DataBaseManager

+ (DataBaseManager*)manager {
    static DataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self migrate];
    }
    return self;
}

- (void)migrate {
//    [RLMRealm setSchemaVersion:REALM_SCHEMA_VERSION forRealmAtPath:[RLMRealm defaultRealmPath] withMigrationBlock:^(RLMMigration *migration, uint64_t oldSchemaVersion) {
//        
//        [migration enumerateObjects:Airport.className block:^(RLMObject *oldObject, RLMObject *newObject) {
//            if (oldSchemaVersion < 1) {
//                newObject[@"longitude"] = [NSNumber numberWithDouble:[oldObject[@"longitude"] doubleValue]];
//                newObject[@"latitude"] = [NSNumber numberWithDouble:[oldObject[@"latitude"] doubleValue]];
//            }
//            if (oldSchemaVersion < 2){
//                newObject[@"country"] = @"";
//            }
//        }];
//        
//    }];
//    [RLMRealm defaultRealm];
}

- (void)writeObjects:(NSArray*)objects {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addObjects:objects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)writeObject:(RLMObject*)object {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] addObject:object];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)deleteObjects:(NSArray*) objects {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObjects:objects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)deleteObjectsRLMResults:(RLMResults*)objects {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObjects:objects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)updateWithBlock:(void(^)())updateBlock {
    if (updateBlock) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        updateBlock();
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

- (void)writeOrUpdateObject:(RLMObject *)object {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[object class] createOrUpdateInRealm:[RLMRealm defaultRealm] withObject:object];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

@end
