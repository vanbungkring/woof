//
//  WhistlistTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/26/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "WhistlistTableViewController.h"
#import "LoginViewController.h"
#import "Util.h"
#import "SearchByParametersTableViewController.h"
#import "PostDataModels.h"
#import <INTULocationManager.h>
#import "FavoriteTableViewCell.h"
#import "CommonHelper.h"
#import "DetailDealViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface WhistlistTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property  (nonatomic,strong) NSArray *dataArray;
@property  (nonatomic,strong) NSMutableDictionary *params;
@end

@implementation WhistlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.params = [NSMutableDictionary new];
    self.title = @"Wish List";
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if ([CommonHelper loginUser]) {
        [self startSingleLocationRequest];
    }
}
- (void)startSingleLocationRequest {
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             
                                             
                                             if (status == INTULocationStatusSuccess) {
                                                 [self.params setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"longitude"];
                                                 [self.params setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"latitude"];
                                                 [self fetchWishlist];
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 [self fetchWishlist];
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                             }
                                             else {
                                                 [self fetchWishlist];
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
}
- (void)fetchWishlist {
    [Response getAllWishList:self.params completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            self.dataArray = json;
            [self.tableView reloadData];
        }
    }];
    
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
    return self.dataArray.count;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Ooops....you need to login to use this feature!";
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[text rangeOfString:@"Woof"]];
    
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"To show a list of random colors, tap on the refresh icon in the right top corner.\n\nTo clean the list, tap on the trash icon.";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return nil;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"Login or Register";
    UIColor *textColor = (state == UIControlStateNormal) ? [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] : [UIColor colorWithRed:204/255.0 green:228/255.0 blue:255/255.0 alpha:1.0];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName: textColor};
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    if (![CommonHelper loginUser]) {
        return attributedTitle;
    }
    else {
        return nil;
    }
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([CommonHelper loginUser]) {
        return [UIImage imageNamed:@"emptydeal"];
    }
    else {
        return [UIImage imageNamed:@"login"];
    }
    
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.dataArray objectAtIndex:indexPath.row];
    DetailDealViewController *detail = [[DetailDealViewController alloc]initWithNibName:@"DetailDealViewController" bundle:nil];
    detail.postDetail =post;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.dataArray objectAtIndex:indexPath.row];
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.favoriteDidTapped.tag = indexPath.row;
    cell.brandButton.tag = indexPath.row;
    cell.locationButton.tag = indexPath.row;
    [cell setPost:post];
    return cell;
}
- (IBAction)favoriteDidTapped:(id)sender {
    if ([CommonHelper loginUser]) {
        Posts *post = [self.dataArray objectAtIndex:[sender tag]];
        post.wishlist = !post.wishlist;
        [Response postWishList:@{@"status":[NSNumber numberWithBool:post.wishlist],@"post_id":[NSNumber numberWithInteger:post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }
    else {
        [self showLogin];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 417;
}

- (IBAction)likeButtonDidTapped:(id)sender {
    if ([CommonHelper loginUser]) {
        Posts *post = [self.dataArray objectAtIndex:[sender tag]];
        post.liked = !post.liked;
        [Response postLike:@{@"status":[NSNumber numberWithBool:post.liked],@"post_id":[NSNumber numberWithInteger:post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }
    else {
        [self showLogin];
    }
}

- (IBAction)brandDidtapped:(id)sender {
    self.hidesBottomBarWhenPushed = NO;
    Posts *post = [self.dataArray objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 1;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)locationDidTapped:(id)sender {
    self.hidesBottomBarWhenPushed = NO;
    Posts *post = [self.dataArray objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 0;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)showLogin {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)shareButtonDidTapped:(id)sender {
    NSString *text = @"How to add Facebook and Twitter sharing to an iOS app";
    NSURL *url = [NSURL URLWithString:@"http://roadfiresoftware.com/2014/02/how-to-add-facebook-and-twitter-sharing-to-an-ios-app/"];
    UIImage *image = [UIImage imageNamed:@"roadfire-icon-square-200"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text]
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
