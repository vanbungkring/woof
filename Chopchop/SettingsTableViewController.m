//
//  SettingsTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/26/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "CommonHelper.h"
#import "StaticAndPreferences.h"
#import "CategoriesDataModels.h"
#import "AboutTableViewController.h"
#import "CategoriesCollectionViewController.h"
#import "LoginViewController.h"
#import <ActionSheetPicker.h>
#import "TOCViewController.h"
#import <MessageUI/MessageUI.h>
@interface SettingsTableViewController () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *loginString;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (strong, nonatomic) NSArray *country;

@end

@implementation SettingsTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"Settings";
    if ([CommonHelper loginUser]) {
        self.loginString.text = @"Logout";
        self.categoriesLabel.text = @"Categories";
    }
    
    else {
        self.categoriesLabel.text = @"Login";
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if ([CommonHelper loginUser]) {
        return 7;
    }
    else {
        return 6;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self openAbout];
    }
    if (indexPath.row ==1) {
        [self tellFriend];
    }
    if (indexPath.row == 3) {
        [self openTOC];
    }
    if (indexPath.row ==4) {
        [self openFeedBack];
    }
    if (![CommonHelper loginUser]) {
        [self openLogin];
        if (indexPath.row==5) {
            [self openLogin];
        }
    }
    else {
        if (indexPath.row == 5) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CategoriesCollectionViewController *categoriesVC =[storyboard instantiateViewControllerWithIdentifier:@"categoriesVC"];
            categoriesVC.selectionCategory = 2;
            categoriesVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:categoriesVC animated:YES];
        }
        if (indexPath.row == 6) {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:PREFS_USER_TOKEN];
            [[NSUserDefaults standardUserDefaults]synchronize];
            self.categoriesLabel.text = @"Login";
            [CategoriesResponse getAllCategories:@{@"token":@"379d1990b8cb00febe08373b944c2d1f"} completionBlock:nil];
            [self.tableView reloadData];

        }
        
    }
    
    

}
- (void)openAbout {
    self.hidesBottomBarWhenPushed = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutTableViewController *about = [storyboard instantiateViewControllerWithIdentifier:@"aboutVC"];
    [self.navigationController pushViewController:about animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)openTOC {
    TOCViewController *tocViewController = [[TOCViewController alloc]initWithNibName:@"TOCViewController" bundle:nil];
    [self.navigationController pushViewController:tocViewController animated:YES];
}
- (void)openLogin {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
- (void)openFeedBack {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"admin@chopchop-app.com"]];
        [composeViewController setSubject:@"Feedback to chopchop"];
        [self presentViewController:composeViewController animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tellFriend {
    NSString *text = @"Hi, check out chopchop app to get the latest discounts on all of your favorite brands";
    UIImage *image = [UIImage imageNamed:@"sianyin"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
