//
//  FollowingLocationHeaderView.m
//  Chopchop
//
//  Created by Arie on 12/10/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowingLocationHeaderView.h"
#import "HeaderCell.h"
#import <UIImageView+PINRemoteImage.h>
#import "LocationHottestDataModels.h"
@implementation FollowingLocationHeaderView
- (void)layoutSubviews {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayOfLocations.count;
}

- (HeaderCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LocationHottestLocations *brands = [self.arrayOfLocations objectAtIndex:indexPath.row];
    HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
    
    [cell.coverImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/locations/cover/%@",brands.cover]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)getHottestLocation {
   [LocationHottestResponse getLocationsHottest:^(NSArray *json, NSError *error) {
       if (!error) {
           self.arrayOfLocations = json;
           [self.collectionView reloadData];
       }
   }];
}
@end
