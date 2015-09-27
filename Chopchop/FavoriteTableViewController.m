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
#import "CommonHelper.h"
#import "DeviceHelper.h"
#import "Util.h"
#import "LocationManager.h"
#import "SearchByParametersTableViewController.h"
#import <MZFormSheetPresentationController.h>
@interface FavoriteTableViewController () <UIActionSheetDelegate,LocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic,strong) NSArray *favoriteData;
@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Util logAllFontFamiliesAndName];
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
    [self refreshControl:self];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self requestLocationPermission];
}
- (IBAction)refreshControl:(id)sender {
    [self.refreshControl beginRefreshing];
    [self getAllFavorite];
}

- (void)getAllFavorite {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    if (self.categoryId.length>1) {
        [dictionary setObject:self.categoryId forKey:@"category_id"];
    }
    [dictionary setObject:@"379d1990b8cb00febe08373b944c2d1f" forKey:@"token"];
    
    [Response getAllPost:dictionary completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            self.favoriteData = json;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}
- (void)requestLocationPermission {
    if (![LocationManager isLocationServiceDetermined]) {
        [LocationManager sharedInstance].delegate = self;
        [[LocationManager sharedInstance] updateLocation];
    }
    else {
        [LocationManager sharedInstance].delegate = self;
        [[LocationManager sharedInstance] updateLocation];
    }
    
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
    FavoriteDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailFavorite"];
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    detail.brandName = post.brand.name;
    detail.website = post.location.website;
    detail.location = post.location.name;
    detail.content = post.name;
    detail.imageUrl  = post.files;
    MZFormSheetPresentationController *formSheetController = [[MZFormSheetPresentationController alloc] initWithContentViewController:detail];
    formSheetController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.contentViewSize = CGSizeMake(300, 250);
    [self presentViewController:formSheetController animated:YES completion:nil];
    
}
- (IBAction)likeButtonDidTapped:(id)sender {
    
    
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
        NSString *phoneNumber = [@"tel://" stringByAppendingString:@"02126535555"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}
- (IBAction)favoriteDidTapped:(id)sender {
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
    
}
- (IBAction)brandDidtapped:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 1;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)locationDidTapped:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 0;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
