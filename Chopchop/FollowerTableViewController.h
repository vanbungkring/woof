//
//  FollowerTableViewController.h
//  Chopchop
//
//  Created by Arie on 9/26/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowerTableViewController : UITableViewController
@property (nonatomic) NSInteger stateOfData;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *scrollingButton;
@end
