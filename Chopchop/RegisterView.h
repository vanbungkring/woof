//
//  RegisterView.h
//  Chopchop
//
//  Created by Arie on 11/8/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end
