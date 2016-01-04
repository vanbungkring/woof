//
//  BrandFollowingViewController.m
//  Chopchop
//
//  Created by Arie on 12/2/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "BrandFollowingViewController.h"
#import "FollowingBrandDatasource.h"
#import "BrandActivityDataModels.h"
#import "DetailDealViewController.h"
#import "CommonHelper.h"
#import "FollowingBrandTableViewCell.h"
#import <UIFont+Montserrat.h>
@interface BrandFollowingViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) FollowingBrandDatasource *brandDataSource;

@end

@implementation BrandFollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.brandDataSource = [[FollowingBrandDatasource alloc]init];
    self.tableView.delegate =self;
    self.tableView.dataSource = self.brandDataSource;
    self.header =  [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] firstObject];
    [self.header getHottestBrand];
    self.tableView.tableHeaderView  = self.header;

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    [BrandActivitiesResponse getBrandActivity:^(NSArray *json, NSError *error) {
        if (!error) {
            self.brandDataSource.brandArray = json;
            [self.tableView reloadData];
        }
    }];
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
        FollowingBrandTableViewCell *cell = (FollowingBrandTableViewCell*)[self.brandDataSource tableView:self.tableView
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
        FollowingBrandTableViewCell *cell = (FollowingBrandTableViewCell*)[self.brandDataSource tableView:self.tableView
                                                            cellForRowAtIndexPath:indexPath];
        [cell updateConstraintsIfNeeded];
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailDealViewController *detail = [[DetailDealViewController alloc]initWithNibName:@"DetailDealViewController" bundle:nil];
    BrandActivitiesBrands *brands = [self.brandDataSource.brandArray objectAtIndex:indexPath.row];
    detail.postId = [NSString stringWithFormat:@"%0.f",brands.postId];
    [self.navigationController pushViewController:detail animated:YES];

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
