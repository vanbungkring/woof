//
//  SearchByParametersTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/21/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "SearchByParametersTableViewController.h"
#import "PostDataModels.h"
#import <INTULocationManager.h>
#import "Util.h"
#import "DetailDealViewController.h"
#import "DataModels.h"
#import "CommonHelper.h"
#import "LoginViewController.h"
#import "LocationHeader.h"
#import "LocationDataModels.h"
#import "StaticAndPreferences.h"
#import <UIImageView+PINRemoteImage.h>
#import <MZFormSheetPresentationController.h>
#import "FavoriteDetailViewController.h"
#import "DataModels.h"
#import "FavoriteTableViewCell.h"
@interface SearchByParametersTableViewController ()<locationHeaderDelegate>
@property (nonatomic,strong)NSArray *favoriteData;
@property (nonatomic,strong)LocationHeader *header;
@property (nonatomic,strong) BrandBrand *brandResponse;
@property (nonatomic,strong) NSMutableDictionary *parameters;
@end

@implementation SearchByParametersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.parameters = [NSMutableDictionary new];
    if ([CommonHelper loginUser]) {
        [ self.parameters  setObject:[CommonHelper userToken] forKey:@"token"];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(followButtonDidTapped) name:NOTIFICATION_FOLLOW object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self startSingleLocationRequest];
    });
    self.header =  [[[NSBundle mainBundle] loadNibNamed:@"LocationHeader" owner:self options:nil] firstObject];;
    self.header.delegate = self;
    self.tableView.tableHeaderView = self.header;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.isBrand) {
        self.title = self.post.brand.name;
        [self.navigationController.navigationBar setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont systemFontOfSize:18],
          NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
        self.brandName.text = [NSString stringWithFormat:@"Brand : %@",self.post.brand.name];
        self.additionalInformation.text = [NSString stringWithFormat:@"Website : %@",self.post.brand.website];
        self.nearestStore.text =[NSString stringWithFormat:@"Brand : %@",self.post.location.name];
        [self.avatarImageView pin_setImageFromURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://%@/img/brands/%@",API_URL,self.post.brand.logo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self getBrandDetails];
        [ self.parameters  setObject:[NSString stringWithFormat:@"%0.f",self.post.brand.brandIdentifier] forKey:@"brand_id"];
    }
    else {
        self.title = self.post.location.name;
        [self getLocationDetails];
        self.brandName.text = [NSString stringWithFormat:@"Location : %@",self.post.location.name];
        self.additionalInformation.text = [NSString stringWithFormat:@"Distance : %@",[Util stringWithDistance:self.post.location.distance.km]];
        self.nearestStore.text =@"";
        [ self.parameters  setObject:[NSString stringWithFormat:@"%0.f",self.post.location.locationIdentifier] forKey:@"location_id"];
        [self getLocationDetails];
    }
}
- (void)startSingleLocationRequest {
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             
                                             
                                             if (status == INTULocationStatusSuccess) {
                                                 [self.parameters setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"longitude"];
                                                 [self.parameters setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"latitude"];
                                                 if (self.locationId) {
                                                     [self.parameters setObject:self.locationId forKey:@"location_id"];
                                                 }
                                                 [self getList];
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 if (self.locationId) {
                                                     [self.parameters setObject:self.locationId forKey:@"location_id"];
                                                 }
                                                 [self getList];
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                             }
                                             else {
                                                 if (self.locationId) {
                                                     [self.parameters setObject:self.locationId forKey:@"location_id"];
                                                 }
                                                 [self getList];
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
}
- (void)getList {
    [Response getAllPost:self.parameters  completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            
            self.favoriteData = json;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            [self setDataForBrand];
        }
    }];
}
- (void)setDataForBrand {
    if (self.favoriteData.count >0) {
        Posts *post = [self.favoriteData firstObject];
        self.title = post.location.name;
        self.brandName.text = [NSString stringWithFormat:@"Location : %@",post.location.name];
        self.additionalInformation.text = [NSString stringWithFormat:@"Distance : %@",[Util stringWithDistance:post.location.distance.km]];
        self.nearestStore.text =@"";
       // [ self.parameters  setObject:[NSString stringWithFormat:@"%0.f",post.location.locationIdentifier] forKey:@"location_id"];
    }

}
- (void)followButtonDidTapped {
    if (self.isBrand) {
        if ([CommonHelper loginUser]) {
            if (self.brandResponse.followed) {
                self.brandResponse.followed = 0;
                self.brandResponse.followers -=1;
                [self.header.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
                [BrandResponse unFollowBrand:@{@"id":[NSNumber numberWithDouble:self.post.brand.brandIdentifier]} completionBlock:nil];
            }
            else {
                self.brandResponse.followed = 1;
                self.brandResponse.followers +=1;
                [BrandResponse followBrand:@{@"id":[NSNumber numberWithDouble:self.post.brand.brandIdentifier]} completionBlock:nil];
                [self.header.followButton setTitle:@"+ Unfollow" forState:UIControlStateNormal];
            }
            [self.tableView reloadData];
        }
        else {
            [self openLogin];
        }
    }
    else {
        if ([CommonHelper loginUser]) {
            if (self.brandResponse.followed) {
                self.brandResponse.followed = 0;
                self.brandResponse.followers -=1;
                [self.header.followButton setTitle:@"+ Follow" forState:UIControlStateNormal];
                [BrandResponse unFollowLocation:@{@"id":[NSNumber numberWithDouble:self.post.location.locationIdentifier]} completionBlock:nil];
            }
            else {
                self.brandResponse.followed = 1;
                self.brandResponse.followers +=1;
                [BrandResponse followLocation:@{@"id":[NSNumber numberWithDouble:self.post.location.locationIdentifier]} completionBlock:nil];
                [self.header.followButton setTitle:@"+ Unfollow" forState:UIControlStateNormal];
            }
            [self.tableView reloadData];
        }
        else {
            [self openLogin];
        }
    }
    
}

- (void)getBrandDetails {
    [BrandResponse getBrand:@{@"id":[NSString stringWithFormat:@"%0.f",self.post.brand.brandIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            NSLog(@"hson->%@", json[0]);
            self.brandResponse = json[0];
            self.header.brandLikePost.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.likes];
            self.header.brandTotalFollower.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.followers];
            self.header.brandTotalActivePost.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.activePosts];
            self.header.brandWebsite.text = self.brandResponse.website;
            if (self.brandResponse.followed) {
                [self.header.followButton setTitle:@"+ Unfollow" forState:UIControlStateNormal];
            }
            [self.tableView reloadData];
            [self.header setNeedsDisplay];
        }
    }];
}
- (void)getLocationDetails {
    [LocationResponse getLocation:@{@"id":[NSString stringWithFormat:@"%0.f",self.post.location.locationIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
        NSLog(@"json->%@",json);
        if (!error) {
            self.brandResponse = json[0];
            self.header.brandLikePost.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.likes];
            self.header.brandTotalFollower.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.followers];
            self.header.brandTotalActivePost.text = [NSString stringWithFormat:@"%0.f",self.brandResponse.activePosts];
            self.header.brandWebsite.text = self.brandResponse.website;
            if (self.brandResponse.followed) {
                [self.header.followButton setTitle:@"+ Unfollow" forState:UIControlStateNormal];
            }
            [self.tableView reloadData];
            [self.header setNeedsDisplay];
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
    return self.favoriteData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.post = [self.favoriteData objectAtIndex:indexPath.row];
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.favoriteDidTapped.tag = indexPath.row;
    cell.favoriteDidTapped.tag = indexPath.row;
    cell.brandButton.tag = indexPath.row;
    cell.locationButton.tag = indexPath.row;
    [cell setPost:self.post];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 419;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    DetailDealViewController *detail = [[DetailDealViewController alloc]initWithNibName:@"DetailDealViewController" bundle:nil];
    detail.postDetail =post;
    self.title = @"";
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)openLogin {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)brandDidtapped:(id)sender {
    self.hidesBottomBarWhenPushed = NO;
     self.title = @"";
    Posts *post = [self.favoriteData objectAtIndex:[sender tag]];
    SearchByParametersTableViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 1;
    search.post = post;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)locationDidTapped:(id)sender {
    
    self.hidesBottomBarWhenPushed = NO;
    self.title = @"";
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
- (IBAction)likeButtonDidTapped:(id)sender {
    if ([CommonHelper loginUser]) {
       self.post = [self.favoriteData objectAtIndex:[sender tag]];
        self.post.liked = !self.post.liked;
        [Response postLike:@{@"status":[NSNumber numberWithBool:self.post.liked],@"post_id":[NSNumber numberWithInteger:self.post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
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
        self.post = [self.favoriteData objectAtIndex:[sender tag]];
        self.post.wishlist = !self.post.wishlist;
        [Response postWishList:@{@"status":[NSNumber numberWithBool:self.post.wishlist],@"post_id":[NSNumber numberWithInteger:self.post.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self.tableView reloadData];
    }
    else {
        [self showLogin];
    }
}
@end
