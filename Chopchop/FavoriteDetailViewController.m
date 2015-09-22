//
//  FavoriteDetailViewController.m
//  Chopchop
//
//  Created by Arie on 9/7/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "FavoriteDetailViewController.h"
#import <UIImageView+PINRemoteImage.h>
@interface FavoriteDetailViewController ()

@end

@implementation FavoriteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favoriteBrandName.text = self.brandName;
    self.favoriteWebsiteLabel.text = self.website;
    self.favoriteLocation.text = self.location;
    self.favoriteContent.text = self.content;
    
    [self.dealImage pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/posts/%@",self.imageUrl]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // Do any additional setup after loading the view.
}

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
