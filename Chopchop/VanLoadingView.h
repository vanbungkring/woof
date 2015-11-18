//
//  VanLoadingView.h
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VanLoadingIndicator.h"
@interface VanLoadingView : UIView
@property (weak, nonatomic) IBOutlet VanLoadingIndicator *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (void)show;
- (void)hide;
@end
