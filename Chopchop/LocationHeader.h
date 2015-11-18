//
//  LocationHeader.h
//  Chopchop
//
//  Created by Arie on 11/11/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol locationHeaderDelegate
- (void)followButtonDidTapped;
@end
@interface LocationHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *brandPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *brandWebsite;
@property (weak, nonatomic) IBOutlet UILabel *brandTotalFollower;
@property (weak, nonatomic) IBOutlet UILabel *brandTotalActivePost;
@property (weak, nonatomic) IBOutlet UILabel *brandLikePost;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak,nonatomic) id<locationHeaderDelegate>delegate;
@end
