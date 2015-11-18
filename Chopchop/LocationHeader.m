//
//  LocationHeader.m
//  Chopchop
//
//  Created by Arie on 11/11/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "LocationHeader.h"
#import "StaticAndPreferences.h"
@implementation LocationHeader

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)layoutSubviews {
    self.followButton.backgroundColor = [UIColor clearColor];
    self.followButton.layer.borderColor  = [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00].CGColor;
    self.followButton.layer.borderWidth = 1.0f;
    self.followButton.layer.cornerRadius = 3.0f;
    
}
- (IBAction)headerButtonDidtapped:(id)sender {
    [self.delegate followButtonDidTapped];
}

@end
