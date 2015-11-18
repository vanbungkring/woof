//
//  FavoriteTableViewCell.m
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import "PostDataModels.h"
#import "Util.h"
#import <UIImageView+PINRemoteImage.h>
@implementation FavoriteTableViewCell

- (void)awakeFromNib {
    //    self.containerView.layer.borderColor = [UIColor colorWithRed:0.96 green:0.93 blue:0.90 alpha:1.00].CGColor;
    //    self.containerView.layer.borderWidth = 1.0f;
    //    self.containerView.layer.cornerRadius = 5;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setPost:(Posts *)post {
    [self.postImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/posts/%@",post.files]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.postImageView.layer.masksToBounds = YES;
    self.topLabelDeal.textColor = [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.00];
    self.topLabelDeal.text = post.brand.name;
    [self.wishlistButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    if (post.wishlist) {
        [self.wishlistButton setImage:[UIImage imageNamed:@"favoriteActive"] forState:UIControlStateNormal];
    }
    if (post.liked) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeActive"] forState:UIControlStateNormal];
    }
    self.dealLabelText.text = post.postsDescription;
    if (post.location.distance.km>40) {
        self.distanceLabel.text = @"Online";
    }
    else {
        self.distanceLabel.text = [NSString stringWithFormat:@"%0.1f Km",post.location.distance.km];
    }
    self.locationLabel.text = post.location.name;
    self.discountLabelText.text = [NSString stringWithFormat:@"%0.f%%",post.discount];
    self.expiredTime.text = [post.expiredTime lowercaseString];
    self.expiredTime.layer.cornerRadius = self.expiredTime.frame.size.width/2;
    self.expiredTime.layer.masksToBounds = YES;
    //[self.brandLogo pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/brands/%@",post.brand.logo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.brandLogo.layer.cornerRadius =  self.brandLogo.frame.size.width/2;
    self.brandLogo.layer.masksToBounds = YES;
    
    self.brandNameLabel.text = post.brand.name;
    self.locationFollowerLabel.text = [NSString stringWithFormat:@"%0.f Followers",post.location.follower];
    self.brandFollowerLabel.text = [NSString stringWithFormat:@"%0.f Followers",post.brand.follower];
    
    
}
@end
