//
//  AlertHelper.h
//  Shoot Your Dream
//
//  Created by Arie on 8/22/15.
//  Copyright (c) 2015 Arie Prasetyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertHelper : NSObject
+ (void)showNotificationWithError:(NSString *)title message:(NSString *)message;
+ (void)showNotificationWitWarning:(NSString *)title message:(NSString *)message;
+ (void)showNotificationWitSucccess:(NSString *)title message:(NSString *)message;
@end
