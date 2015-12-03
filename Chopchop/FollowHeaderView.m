//
//  FollowHeaderView.m
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowHeaderView.h"
#import "BrandHottestDataModels.h"
@implementation FollowHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    
}
- (void)getHottestBrand {
    [BrandHottestResponse getBrandHottest:^(NSArray *json, NSError *error) {
        if (!error) {
            
        }
    }];
}
@end
