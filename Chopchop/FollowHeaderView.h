//
//  FollowHeaderView.h
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol followHeaderViewDelegate <NSObject>
- (void)collectionViewDidSelectRow:(id)data;
@end

@interface FollowHeaderView : UIView <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
