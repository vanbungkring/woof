//
//  VanLoadingView.m
//  Chopchop
//
//  Created by Arie on 11/7/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "VanLoadingView.h"

@implementation VanLoadingView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *nibView = [[[NSBundle mainBundle] loadNibNamed:@"TVLLoadingView" owner:self options:nil] firstObject];
        nibView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nibView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(nibView);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0  metrics:nil views:views]];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.alpha = 0.0f;
    [self.loadingIndicator startAnimating];
}

- (void)show {
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.0f;
    }];
}

@end
