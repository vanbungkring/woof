
#import "AlertHelper.h"
#import <RKDropdownAlert.h>
@implementation AlertHelper
+ (void)showNotificationWithError:(NSString *)title message:(NSString *)message {
    [RKDropdownAlert show];
    [RKDropdownAlert title:title message:message backgroundColor:[UIColor colorWithRed:0.651 green:0.196 blue:0.196 alpha:1] textColor:[UIColor whiteColor]time:3.0];
    
    
}
+ (void)showNotificationWitWarning:(NSString *)title message:(NSString *)message {
    [RKDropdownAlert show];
    [RKDropdownAlert title:title message:message backgroundColor:[UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1] textColor:[UIColor whiteColor]time:3.0];
    
    
}
+ (void)showNotificationWitSucccess:(NSString *)title message:(NSString *)message {
    
    [RKDropdownAlert show];
    [RKDropdownAlert title:title message:message backgroundColor:[UIColor greenColor] textColor:[UIColor whiteColor]time:3.0];
    
}
@end
