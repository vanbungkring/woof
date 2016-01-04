//
//  SearchByParametersTableViewController.h
//  Chopchop
//
//  Created by Arie on 9/21/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Posts.h"
@interface SearchByParametersTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *brandName;
@property (weak, nonatomic) IBOutlet UILabel *additionalInformation;
@property (weak, nonatomic) IBOutlet UILabel *nearestStore;

@property (nonatomic,getter=isBrand)BOOL brand;
@property (nonatomic,strong)Posts *post;
@property (nonatomic,strong)NSString *locationId;
@end
