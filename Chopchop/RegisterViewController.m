//
//  RegisterViewController.m
//  Chopchop
//
//  Created by Arie on 11/8/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "AlertHelper.h"
#import "UserModel.h"
#import <SVProgressHUD.h>
@interface RegisterViewController ()

@property (nonatomic,strong)RegisterView *view;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)haveAccountDidTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registerButtonDidTapped:(id)sender {
    if (self.view.fullNameTextField.text.length < 1) {
        [AlertHelper showNotificationWithError:@"Error" message:@"Full Name is Mandatory"];
        return;
    }
    else if (self.view.userNameTextField.text.length <1) {
        [AlertHelper showNotificationWithError:@"Error" message:@"Username Is Mandatory"];
        return;
    }
    else if (self.view.emailTextField.text.length <1) {
        [AlertHelper showNotificationWithError:@"Error" message:@"Email Is Mandatory"];
        return;
    }
    else if (self.view.emailTextField.text.length <1) {
        [AlertHelper showNotificationWithError:@"Error" message:@"Password Is Mandatory"];
        return;
    }
    else if (self.view.phoneTextField.text.length <1) {
        [AlertHelper showNotificationWithError:@"Error" message:@"Password Is Mandatory"];
        return;
    }
    else {
        NSMutableDictionary *parameters  = [NSMutableDictionary new];
        [parameters setObject:self.view.fullNameTextField.text forKey:@"fullname"];
        [parameters setObject:self.view.userNameTextField.text forKey:@"username"];
        [parameters setObject:self.view.passwordTextField.text forKey:@"password"];
        [parameters setObject:self.view.passwordTextField.text forKey:@"password_confirm"];
        [parameters setObject:self.view.emailTextField.text forKey:@"email"];
        [parameters setObject:self.view.phoneTextField.text forKey:@"phone"];
#if TARGET_IPHONE_SIMULATOR
        [parameters setObject:@"Simulatro" forKey:@"device_id"];
#else
        
        [parameters setObject:[UIDevice currentDevice].identifierForVendor forKey:@"device_id"];
#endif
        [SVProgressHUD showWithStatus:@"Logging In" maskType:SVProgressHUDMaskTypeGradient];
        [UserModel registerUser:parameters completionBlock:^(NSArray *json, NSError *error) {
            if (!error) {
                [SVProgressHUD dismiss];
                NSInteger errorCode = [[[json objectAtIndex:0]objectForKey:@"code"] integerValue];
                if (errorCode == 400) {
                    [SVProgressHUD showErrorWithStatus:@"Error" maskType:SVProgressHUDMaskTypeGradient];
                }
                else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else {
                [SVProgressHUD showErrorWithStatus:@"Error" maskType:SVProgressHUDMaskTypeGradient];
            }
        }];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
