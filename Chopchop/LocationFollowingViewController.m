//
//  LocationFollowingViewController.m
//  Chopchop
//
//  Created by Arie on 12/2/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "LocationFollowingViewController.h"
#import "FollowingLocationDatasouce.h"
#import "FollowHeaderView.h"
#import "CommonHelper.h"
#import "FollowingTableViewCell.h"
#import <UIFont+Montserrat.h>
@interface LocationFollowingViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationDataSource = [[FollowingLocationDatasouce alloc]init];
    self.tableView.delegate =self;
    self.tableView.dataSource = self.locationDataSource;
    FollowHeaderView *header =  [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] firstObject];

    self.tableView.tableHeaderView  = header;
    // Do any additional setup after loading the view from its nib.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
