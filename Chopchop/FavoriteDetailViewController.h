//
//  FavoriteDetailViewController.h
//  Chopchop
//
//  Created by Arie on 9/7/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *favoriteBrandName;
@property (weak, nonatomic) IBOutlet UILabel *favoriteWebsiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLocation;
@property (weak, nonatomic) IBOutlet UILabel *favoriteContent;
@property (weak, nonatomic) IBOutlet UIImageView *dealImage;

@property (nonatomic,strong)NSString *brandName;
@property (nonatomic,strong)NSString *website;
@property (nonatomic,strong)NSString *location;
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,strong)NSString *content;
@end
