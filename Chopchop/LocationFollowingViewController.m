//
//  LocationFollowingViewController.m
//  Chopchop
//
//  Created by Arie on 12/2/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "LocationFollowingViewController.h"
#import "FollowingLocationHeaderView.h"
#import "FollowingLocationDatasouce.h"
#import "FollowHeaderView.h"
#import "CommonHelper.h"
#import "LocationsAcityDataModels.h"
#import <INTULocationManager.h>
#import "FollowingTableViewCell.h"
#import "SearchByParametersTableViewController.h"
#import <UIFont+Montserrat.h>
@interface LocationFollowingViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (nonatomic,strong) FollowingLocationDatasouce *locationDataSource;
@end

@implementation LocationFollowingViewController

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 0)];
    header.translatesAutoresizingMaskIntoConstraints = NO;
    
    // [add subviews and their constraints to header]
    
    NSLayoutConstraint *headerWidthConstraint = [NSLayoutConstraint
                                                 constraintWithItem:header attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:size.width
                                                 ];
    [header addConstraint:headerWidthConstraint];
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [header removeConstraint:headerWidthConstraint];
    
    header.frame = CGRectMake(0, 0, size.width, height);
    header.translatesAutoresizingMaskIntoConstraints = YES;
    self.tableView.tableHeaderView = header;
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
                                                 [self getAllLocationActivity];
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 [self getAllLocationActivity];
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                             }
                                             else {
                                                 [self getAllLocationActivity];
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
}

- (void)viewDidLoad {
    self.params = [NSMutableDictionary new];
    [super viewDidLoad];
    self.locationDataSource = [[FollowingLocationDatasouce alloc]init];
    self.tableView.delegate =self;
    self.tableView.dataSource = self.locationDataSource;
    FollowingLocationHeaderView *header =  [[[NSBundle mainBundle] loadNibNamed:@"FollowingLocationHeader" owner:self options:nil] firstObject];
    self.tableView.tableHeaderView  = header;
    [header getHottestLocation];
    [self startSingleLocationRequest];
    // Do any additional setup after loading the view from its nib.
}
- (void)getAllLocationActivity {
    [LocationsActivityResponse getLocationActivity:self.params completionBlock:^(NSArray *json, NSError *error){
        if (!error) {
            self.locationDataSource.locationArray = json;
            [self.tableView reloadData];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.parentViewController.title = @"Following";
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    else {
        FollowingTableViewCell *cell = (FollowingTableViewCell*)[self.locationDataSource tableView:self.tableView
                                                            cellForRowAtIndexPath:indexPath];
        [cell updateConstraintsIfNeeded];
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    else {
        FollowingTableViewCell *cell = (FollowingTableViewCell*)[self.locationDataSource tableView:self.tableView
                                                            cellForRowAtIndexPath:indexPath];
        [cell updateConstraintsIfNeeded];
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = NO;
    self.parentViewController.title = @"";
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchByParametersTableViewController *search = [stb instantiateViewControllerWithIdentifier:@"searchByParams"];
    search.brand = 0;
    LocationsActivityLocations *locations = [self.locationDataSource.locationArray objectAtIndex:indexPath.row];
    search.locationId =[NSString stringWithFormat:@"%0.f",locations.locationId];
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}
- (IBAction)openMap:(id)sender {
    
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
