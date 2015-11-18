//
//  BaseTabbarViewController.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "CategoriesDataModels.h"
#import "StaticAndPreferences.h"
#import "OnboardingModalViewController.h"
#import <SVProgressHUD.h>
@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllCategories {
    
    if ([CategoriesResponse allCategories].count > 0) {
        [SVProgressHUD showErrorWithStatus:@"Setting up chopchop"];
    }
    
    [CategoriesResponse getAllCategories:@{@"token":@"379d1990b8cb00febe08373b944c2d1f"} completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
        }
        
    }];
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
