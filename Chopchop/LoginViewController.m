//
//  LoginViewController.m
//  Chopchop
//
//  Created by Arie on 9/26/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CategoriesCollectionViewController.h"
#import "UserModel.h"
#import "AlertHelper.h"
#import "StaticAndPreferences.h"
#import <IQToolbar.h>
#import <SVProgressHUD.h>
#import <Parse.h>
#import <FBSDKCoreKit.h>
@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textfieldWrapper;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *chopchopLogo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldWrapperBottomConstraints;

@end
#define kOFFSET_FOR_KEYBOARD 180
@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.chopchopLogo.font = [UIFont fontWithName:@"Cooper-Heavy" size:33];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.passwordTextField.delegate = self;
    self.usernameTextfield.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonDidTapped:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginWithFacebook:(id)sender {
}

- (IBAction)registerDidTapped:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:registerController animated:YES];
}
- (void)loginUser {
    if (self.usernameTextfield.text.length < 1) {
          [AlertHelper showNotificationWithError:@"Error" message:@"Username / Email Is Mandatory"];
        return;
    }
    else if (self.passwordTextField.text.length < 1) {
           [AlertHelper showNotificationWithError:@"Error" message:@"Password Is Mandatory"];
        return;
    }
    else {
        [SVProgressHUD showWithStatus:@"Logging In" maskType:SVProgressHUDMaskTypeGradient];
        [UserModel loginUser:@{@"username":self.usernameTextfield.text,
                               @"password":self.passwordTextField.text} completionBlock:^(NSArray *json, NSError *error) {
                                   if (!error) {
                                       if ([[[json objectAtIndex:0]objectForKey:@"code"]integerValue] == 200 ) {
                                           [[NSUserDefaults standardUserDefaults]setObject:[[json objectAtIndex:0]objectForKey:@"token"] forKey:PREFS_USER_TOKEN];
                                           //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                           [self openTheCategories];
                                       }
                                       else {
                                           [AlertHelper showNotificationWithError:@"Error" message:[json[0] valueForKey:@"message"]];
                                       }
                                       [SVProgressHUD dismiss];
                                   }
                                   else {
                                    [SVProgressHUD dismiss];
                                   }
                               }];
    }
}
- (void)openTheCategories{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoriesCollectionViewController *categoriesVC =[storyboard instantiateViewControllerWithIdentifier:@"categoriesVC"];
    categoriesVC.selectionCategory = 1;
    [self.navigationController pushViewController:categoriesVC animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField ==self.passwordTextField) {
        [self loginUser];
    }
    return YES;
}
- (IBAction)forgotPassword:(id)sender {
}
-(void)fabookLogin {

}
- (IBAction)manualLogin:(id)sender {
    [self loginUser];
}

@end
