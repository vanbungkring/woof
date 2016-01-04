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

@interface FollowHeaderView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (nonatomic,strong) NSArray *arrayOfBrand;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (void)getHottestBrand;


@end
