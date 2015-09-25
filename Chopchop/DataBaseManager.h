//
//  DataBaseManager.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface DataBaseManager : NSObject

/**
 * Get shared instance of RealmManager
 * @return shared instance of RealmManager
 */
+ (DataBaseManager*)manager;

/**
 * Run schema migration. Used for updating realm database.
 */
- (void)migrate;

/**
 * Write array of objects to the default realm.
 */
- (void)writeObjects:(NSArray*)objects;

/**
 * Write an object to the default realm.
 */
- (void)writeObject:(RLMObject*)object;

/**
 * Delete collection of object from the default realm.
 */
- (void)deleteObjects:(NSArray*) objects;

- (void)deleteObjectsRLMResults:(RLMResults*)objects;

/**
 * Run the given block in realm transaction block.
 */
- (void)updateWithBlock:(void(^)())updateBlock;

/**
 * Write / update realm object
 * This function is available to model class which has primaryKey
 */
- (void)writeOrUpdateObject:(RLMObject *)object;

@end
