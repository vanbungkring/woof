//
//  FavoriteTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteTableViewCell.h"
#import "FavoriteDetailViewController.h"
#import "PostDataModels.h"
#import "LoginViewController.h"
#import "OnboardingModalViewController.h"
#import "StaticAndPreferences.h"
#import "CommonHelper.h"
#import "DeviceHelper.h"
#import "Util.h"
#import <INTULocationManager.h>
#import "DetailDealViewController.h"
#import "LocationManager.h"
#import "SearchByParametersTableViewController.h"
#import <MZFormSheetPresentationController.h>
@interface FavoriteTableViewController () <UIActionSheetDelegate,LocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (nonatomic,strong) NSArray *favoriteData;
@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:PREFS_ONBOARDING_SHOWN] boolValue]) {
        OnboardingModalViewController *onboardingModalVC = [[OnboardingModalViewController alloc] initWithNibName:@"OnboardingModalViewController" bundle:[NSBundle mainBundle]];
        [self presentViewController:onboardingModalVC animated:YES completion:nil];
    }
    
    self.params = [NSMutableDictionary new];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.refreshControl addTarget:self action:@selector(refreshControl:) forControlEvents:UIControlEventValueChanged];
    
    
    if (!self.title.length) {
        self.title = @"chopchop";
        [self.navigationController.navigationBar setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont fontWithName:@"Cooper-Heavy" size:21],NSFontAttributeName,
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
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
                                                 [self getAllFavorite];
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 [self getAllFavorite];
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                             }
                                             else {
                                                 [self getAllFavorite];
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
}

- (void)locationManagerDelegateLocationUpdated:(CLLocation *)currentLocation{
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self startSingleLocationRequest];
    
}
- (IBAction)refreshControl:(id)sender {
    [self.refreshControl beginRefreshing];
    [self startSingleLocationRequest];
}

- (void)getAllFavorite {
    if (self.categoryId.length>1) {
        [self.params setObject:self.categoryId forKey:@"category_id"];
    }
    [Response getAllPost:self.params completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            self.favoriteData = json;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}



- (void)locationManagerDelegateLocationUpdated:(CLLocation *)currentLocation
                        lastUpdateTimeInterval:(NSTimeInterval)lastUpdatedTimeInterval {
}
- (void)locationmanagerDelegateLocationFailed {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.favoriteData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.favoriteDidTapped.tag = indexPath.row;
    cell.brandButton.tag = indexPath.row;
    cell.locationButton.tag = indexPath.row;
    [cell setPost:post];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    DetailDealViewController *detail = [[DetailDealViewController alloc]initWithNibName:@"DetailDealViewController" bundle:nil];
    detail.postDetail =post;
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (IBAction)likeButtonDidTapped:(id)sender {
    if ([CommonHelper loginUser]) {
        Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
        post.liked = !post.liked;
        [Response postLike:@{@"status":[NSNumber numberWithBool:post.liked],@"post_id":[NSNumber numberWithInteger:post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }
    else {
        [self showLogin];
    }
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
- (IBAction)favoriteDidTapped:(id)sender {
    if ([CommonHelper loginUser]) {
        Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
        post.wishlist = !post.wishlist;
        [Response postWishList:@{@"status":[NSNumber numberWithBool:post.wishlist],@"post_id":[NSNumber numberWithInteger:post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }
    else {
        [self showLogin];
    }
}
- (IBAction)moreButtonDidTapped:(id)sender {
    [self openActionSheet];
}
- (void)openActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Report"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Already Expired",
                                  @"Not valid at this location",@"Out of stock",@"Incorrect store details",nil];
    [actionSheet showInView:self.view];
}
- (IBAction)searchButtonDidTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"SearchNavigation"];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //        NSString *phoneNumber = [@"tel://" stringByAppendingString:@"02126535555"];
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 419;
}
- (IBAction)brandDidtapped:(id)sender {
    self.hidesBottomBarWhenPushed = NO;
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 1;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)locationDidTapped:(id)sender {
    
    self.hidesBottomBarWhenPushed = NO;
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
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
@end
