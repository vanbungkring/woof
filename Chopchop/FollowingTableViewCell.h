//
//  FollowingTableViewCell.h
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *followingContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;


@end
