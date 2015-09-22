//
//  FavoriteTableViewCell.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Posts;
@interface FavoriteTableViewCell : UITableViewCell
@property (nonatomic,strong)Posts *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabelDeal;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *dealLabelText;
@property (weak, nonatomic) IBOutlet UILabel *discountLabelText;
@property (weak, nonatomic) IBOutlet UILabel *expiredTime;
@property (weak, nonatomic) IBOutlet UIImageView *brandLogo;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandFollowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationFollowerLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteDidTapped;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;

@end
