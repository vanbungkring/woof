//
//  DetailDealViewController.m
//  Chopchop
//
//  Created by Arie on 10/10/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "DetailDealViewController.h"
#import <UIFont+Montserrat.h>
#import "CommonHelper.h"
#import <UIImageView+PINRemoteImage.h>
#import <UIFont+Montserrat.h>
#import "LoginViewController.h"
#import "Response.h"
#import "MapsViewController.h"
@interface DetailDealViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;

@end

@implementation DetailDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail Deal";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont montserratBoldFontOfSize:18],NSFontAttributeName,
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.locationName.text = self.postDetail.location.name;
    self.counterPhone.text = @"021-009328";
    self.relatedBrand.text = self.postDetail.brand.name;
    self.relatedBrand.font = [UIFont montserratBoldFontOfSize:16];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont montserratFontOfSize:18],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
     [self.dealImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/posts/%@",self.postDetail.files]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    if (self.postDetail.brand.related.count<1) {
        self.dealTitle.text =self.postDetail.brand.name;
    }
    else {
        NSMutableString *string = [NSMutableString new];
        [string appendString:self.postDetail.brand.name];
        for (NSDictionary *relatedBrand in self.postDetail.brand.related) {
            Related *related = [[Related alloc]initWithDictionary:relatedBrand];
            [string appendString:[NSString stringWithFormat:@" - %@",related.brand.name]];
        }
        self.dealTitle.text = string;
    }
    self.dealDetail.text = self.postDetail.postsDescription;
    self.reportButton.layer.borderColor = [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00].CGColor;
    self.reportButton.layer.borderWidth = 1.0f;
    self.reportButton.layer.cornerRadius = 3;
    self.website.text = self.postDetail.brand.website;
    [self updateButton];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}
- (IBAction)favoriteDidTapped:(id)sender {
    
    if ([CommonHelper loginUser]) {
        [self updateButton];
        self.postDetail.liked = !self.postDetail.liked;
        [Response postLike:@{@"status":[NSNumber numberWithBool:self.postDetail.liked],@"post_id":[NSNumber numberWithInteger:self.postDetail.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
    }
    else {
        [self showLogin];
    }
}
- (IBAction)wishlistDidTapped:(id)sender {
    
    if ([CommonHelper loginUser]) {
        [self updateButton];
        self.postDetail.wishlist = !self.postDetail.wishlist;
        [Response postWishList:@{@"status":[NSNumber numberWithBool:self.postDetail.wishlist],@"post_id":[NSNumber numberWithInteger:self.postDetail.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
    }
    else {
        [self showLogin];
    }
}
- (IBAction)shareDidtapped:(id)sender {
    NSString *text = @"How to add Facebook and Twitter sharing to an iOS app";
    NSURL *url = [NSURL URLWithString:@"http://roadfiresoftware.com/2014/02/how-to-add-facebook-and-twitter-sharing-to-an-ios-app/"];
    UIImage *image = [UIImage imageNamed:@"roadfire-icon-square-200"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)reportDidTapped:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Report"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Already Expired",
                                  @"Not valid at this location",@"Out of stock",@"Incorrect store details",nil];
    [actionSheet showInView:self.view];
    
}
- (void)showLogin {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)updateButton {
    if (self.postDetail.wishlist) {
        [self.wishListButton setImage:[UIImage imageNamed:@"favoriteActive"] forState:UIControlStateNormal];
    }
    
    if (self.postDetail.liked) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeActive"] forState:UIControlStateNormal];
    }
}
- (IBAction)didTapMap:(id)sender {
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:[self.postDetail.location.longitude floatValue] longitude:[self.postDetail.location.latitude floatValue]];
    MapsViewController *map = [[MapsViewController alloc]initWithNibName:@"MapsViewController" bundle:nil];
    map.locationName = self.postDetail.brand.name;
    map.location = location;
    [self.navigationController pushViewController:map animated:YES];
}
- (IBAction)didTapCalendar:(id)sender {
}
- (IBAction)didTapCall:(id)sender {
}
- (IBAction)didtapwebsite:(id)sender {
    
    NSURL *url = [NSURL URLWithString:self.website.text];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
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
