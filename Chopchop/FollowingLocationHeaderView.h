//
//  FollowingLocationHeaderView.h
//  Chopchop
//
//  Created by Arie on 12/10/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol followLocationHeaderViewDelegate <NSObject>
- (void)collectionViewDidSelectRow:(id)data;
@end
@interface FollowingLocationHeaderView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *arrayOfLocations;
- (void)getHottestLocation;
@end
