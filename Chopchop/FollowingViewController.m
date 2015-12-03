//
//  FollowingViewController.m
//  Chopchop
//
//  Created by Arie on 11/23/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowingViewController.h"
#import "FollowingLocationDatasouce.h"
#import <HMSegmentedControl.h>
#import "FollowHeaderView.h"
#import "CommonHelper.h"
#import <UIFont+Montserrat.h>
#import "BrandFollowingViewController.h"
#import "LocationFollowingViewController.h"
const int leadingReset = 0;
@interface FollowingViewController () <UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabContainer;
@property (nonatomic,strong) FollowingLocationDatasouce *locationDataSource;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;
@property (nonatomic) CGFloat constDefault;
@property (nonatomic) NSInteger state;
@property (weak, nonatomic) IBOutlet UIScrollView *followingScrollView;
@property (nonatomic,strong) BrandFollowingViewController *brandController;
@property (nonatomic,strong) LocationFollowingViewController *locationController;
@property (weak, nonatomic) IBOutlet UIView *containerContent;

@end

@implementation FollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.followingScrollView.delegate = self;
    self.brandController = [[BrandFollowingViewController alloc] initWithNibName:@"BrandFollowingViewController" bundle:[NSBundle mainBundle]];
    [self addChildViewController:self.brandController];
    [self addBrandView:self.brandController.view];
    
    self.locationController = [[LocationFollowingViewController alloc] initWithNibName:@"LocationFollowingViewController" bundle:[NSBundle mainBundle]];
    [self addChildViewController:self.locationController];
    [self addlocationFollowing:self.locationController.view];
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Location", @"Brand"]];
    self.segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, self.tabContainer.frame.size.height);
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00];
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:0.5],NSFontAttributeName:[UIFont montserratFontOfSize:15]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00]};
    //    self.segmentedControl.verticalDividerEnabled = YES;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.tabContainer addSubview:self.segmentedControl];
}


- (void)addBrandView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerContent addSubview:view];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:2.0f constant:0.0f]];
}


- (void)addlocationFollowing:(UIView*)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerContent addSubview:view];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.containerContent addConstraint:[NSLayoutConstraint constraintWithItem:self.containerContent attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:2.0f constant:0.0f]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.followingScrollView) {
        //self.activeTabLineCenterXConstraint.constant = (scrollView.contentOffset.x - CGRectGetWidth(scrollView.frame)) / 3.0f;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (self.followingScrollView.contentOffset.x == 0.0f) {
            [self.segmentedControl setSelectedSegmentIndex:0 animated:YES];
        }
        else if (self.followingScrollView.contentOffset.x > self.view.frame.size.width - 10) {
            [self.segmentedControl setSelectedSegmentIndex:1 animated:YES];
        }    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.followingScrollView.contentOffset.x == 0.0f) {
        [self.segmentedControl setSelectedSegmentIndex:0 animated:YES];
    }
    else if (self.followingScrollView.contentOffset.x > self.view.frame.size.width - 10) {
        [self.segmentedControl setSelectedSegmentIndex:1 animated:YES];
    }

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    self.state = segmentedControl.selectedSegmentIndex;
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self.followingScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else {
        [self.followingScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    }
    
}

//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (IS_IOS8_OR_ABOVE) {
//        return UITableViewAutomaticDimension;
//    }
//    else {
//        if (self.state ==0) {
//            UITableViewCell *cell = (UITableViewCell*)[self.brandDataSource tableView:self.tableView
//                                                                cellForRowAtIndexPath:indexPath];
//            [cell updateConstraintsIfNeeded];
//            [cell layoutIfNeeded];
//            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            return height;
//        }
//        else {
//            UITableViewCell *cell = (UITableViewCell*)[self.brandDataSource tableView:self.tableView
//                                                                cellForRowAtIndexPath:indexPath];
//            [cell updateConstraintsIfNeeded];
//            [cell layoutIfNeeded];
//            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            return height;
//        }
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (IS_IOS8_OR_ABOVE) {
//        return UITableViewAutomaticDimension;
//    }
//    else {
//        if (self.state ==0) {
//            UITableViewCell *cell = (UITableViewCell*)[self.brandDataSource tableView:self.tableView
//                                                                cellForRowAtIndexPath:indexPath];
//            [cell updateConstraintsIfNeeded];
//            [cell layoutIfNeeded];
//            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            return height;
//        }
//        else {
//            UITableViewCell *cell = (UITableViewCell*)[self.brandDataSource tableView:self.tableView
//                                                                cellForRowAtIndexPath:indexPath];
//            [cell updateConstraintsIfNeeded];
//            [cell layoutIfNeeded];
//            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            return height;
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
