//
//  FollowHeaderView.m
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowHeaderView.h"
#import "BrandHottestDataModels.h"
#import "HeaderCell.h"
#import <UIImageView+PINRemoteImage.h>
@implementation FollowHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayOfBrand.count;
}

- (HeaderCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BrandHottestBrands *brands = [self.arrayOfBrand objectAtIndex:indexPath.row];
    HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
    
     [cell.coverImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/brands/cover/%@",brands.cover]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}
- (void)getHottestBrand {
    [BrandHottestResponse getBrandHottest:^(NSArray *json, NSError *error) {
        if (!error) {
            self.arrayOfBrand = json;
            [self.collectionView reloadData];
        }
    }];
}
- (void)getHottestLocation {
    
}
@end
