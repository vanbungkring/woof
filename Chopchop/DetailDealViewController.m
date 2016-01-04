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
#import "Post/PostDataModels.h"
#import "Response.h"
#import "MapsViewController.h"
@interface DetailDealViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@property (weak, nonatomic) IBOutlet UIButton *visitWebsite;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@end

@implementation DetailDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail Deal";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont montserratBoldFontOfSize:18],NSFontAttributeName,
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    if (self.postId) {
        [Response getAllPost:@{@"post_id":self.postId} completionBlock:^(NSArray *json, NSError *error) {
            if (!error) {
                if (json.count>0) {
                    self.postDetail = json[0];
                    [self drawDetailData];
                }
                
            }
        }];
    }
    
    [self drawDetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)drawDetailData {
    if (self.postDetail.location.distance.km > 40) {
        self.locationName.text = [NSString stringWithFormat:@"Online (%@)",self.postDetail.location.name];
    }
    else {
        self.locationName.text = [NSString stringWithFormat:@"%@ (%0.1f Km)",self.postDetail.location.name,self.postDetail.location.distance.km];
    }
    
    self.counterPhone.text = self.postDetail.location.phone;
    self.relatedBrand.text = self.postDetail.brand.name;
    self.relatedBrand.font = [UIFont montserratBoldFontOfSize:16];
    self.counterPhone.text = self.postDetail.location.phone;
    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont montserratFontOfSize:18],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [self.dealImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/posts/%@",self.postDetail.files]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    if (self.postDetail.brand.related.count < 1) {
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
    
    if (self.postDetail.brand.website.length) {
        self.website.text = self.postDetail.brand.website;
    }
    else {
        self.website.text = @"Not Available";
        self.visitWebsite.enabled = false;
    }
    
    if (self.postDetail.location.phone.length) {
        self.counterPhone.text = self.postDetail.location.phone;
    }
    else {
        self.website.text = @"Not Available";
        self.callButton.enabled = false;
    }
    
    [self updateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (IBAction)favoriteDidTapped:(id)sender {
    
    if ([CommonHelper loginUser]) {
        
        self.postDetail.liked = !self.postDetail.liked;
        [Response postLike:@{@"status":[NSNumber numberWithBool:self.postDetail.liked],@"post_id":[NSNumber numberWithInteger:self.postDetail.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self updateButton];
    }
    else {
        [self showLogin];
    }
}
- (IBAction)wishlistDidTapped:(id)sender {
    
    if ([CommonHelper loginUser]) {
        
        self.postDetail.wishlist = !self.postDetail.wishlist;
        [Response postWishList:@{@"status":[NSNumber numberWithBool:self.postDetail.wishlist],@"post_id":[NSNumber numberWithInteger:self.postDetail.postsIdentifier]} completionBlock:^(NSArray *json, NSError *error) {
            
        }];
        [self updateButton];
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
    else {
        [self.wishListButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    }
    if (self.postDetail.liked) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeActive"] forState:UIControlStateNormal];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
}
- (IBAction)didTapMap:(id)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString: [NSString stringWithFormat:@"comgooglemaps://?q=%@=%@,%@",self.postDetail.brand.name,self.postDetail.location.latitude,self.postDetail.location.longitude]]];
        
    } else {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?q=%@&sll=%@,%@&z=10&t=s",self.postDetail.brand.name,self.postDetail.location.latitude,self.postDetail.location.longitude]];
        
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
    
    
}
- (IBAction)didTapCalendar:(id)sender {
}
- (IBAction)didTapCall:(id)sender {
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",self.postDetail.location.phone]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)didtapwebsite:(id)sender {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.website.text]];
    
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
