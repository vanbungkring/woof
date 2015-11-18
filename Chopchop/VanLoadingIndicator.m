

#import "VanLoadingIndicator.h"

@interface VanLoadingIndicator()

@property (strong, nonatomic) CALayer *loadingDot1;
@property (strong, nonatomic) CALayer *loadingDot2;
@property (strong, nonatomic) CALayer *loadingDot3;

@end

@implementation VanLoadingIndicator

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (void)initComponents {
    self.loadingDot1 = [[CALayer alloc] init];
    self.loadingDot1.backgroundColor = [UIColor colorWithRed:0.05 green:0.50 blue:0.80 alpha:1.00].CGColor;
    [self.layer addSublayer:self.loadingDot1];
    
    self.loadingDot2 = [[CALayer alloc] init];
    self.loadingDot2.backgroundColor = [UIColor colorWithRed:0.05 green:0.50 blue:0.80 alpha:1.00].CGColor;
    [self.layer addSublayer:self.loadingDot2];
    
    self.loadingDot3 = [[CALayer alloc] init];
    self.loadingDot3.backgroundColor = [UIColor colorWithRed:0.05 green:0.50 blue:0.80 alpha:1.00].CGColor;
    [self.layer addSublayer:self.loadingDot3];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat diameter = CGRectGetHeight(self.frame);
    self.loadingDot1.frame = CGRectMake(0, 0, diameter, diameter);
    self.loadingDot1.cornerRadius = diameter / 2.0f;
    self.loadingDot1.transform = CATransform3DMakeScale(0, 0, 0);
    
    self.loadingDot2.frame = CGRectMake(diameter + 5, 0, diameter, diameter);
    self.loadingDot2.cornerRadius = diameter / 2.0f;
    self.loadingDot2.transform = CATransform3DMakeScale(0, 0, 0);
    
    self.loadingDot3.frame = CGRectMake(2 * diameter + 10, 0, diameter, diameter);
    self.loadingDot3.cornerRadius = diameter / 2.0f;
    self.loadingDot3.transform = CATransform3DMakeScale(0, 0, 0);
}

- (void)startAnimating {
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithFloat:0.0f];
    animation1.toValue = [NSNumber numberWithFloat:1.0f];
    animation1.duration = 0.5f;
    animation1.autoreverses = YES;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.loadingDot1 addAnimation:animation1 forKey:@"scale"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:0.0f];
    animation2.toValue = [NSNumber numberWithFloat:1.0f];
    animation2.duration = 0.5f;
    animation2.autoreverses = YES;
    animation2.beginTime = CACurrentMediaTime() + 0.3f;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.loadingDot2 addAnimation:animation2 forKey:@"scale"];
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.fromValue = [NSNumber numberWithFloat:0.0f];
    animation3.toValue = [NSNumber numberWithFloat:1.0f];
    animation3.duration = 0.5f;
    animation3.autoreverses = YES;
    animation3.beginTime = CACurrentMediaTime() + 0.6f;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.loadingDot3 addAnimation:animation3 forKey:@"scale"];
    
    [self performSelector:@selector(startAnimating) withObject:nil afterDelay:1.6f];
}

- (void)stopAnimating {
    [self.loadingDot1 removeAllAnimations];
    [self.loadingDot2 removeAllAnimations];
    [self.loadingDot3 removeAllAnimations];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimating) object:nil];
}

@end
