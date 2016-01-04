//
//  FollowingBrandDatasource.m
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowingBrandDatasource.h"
#import <UIImageView+PINRemoteImage.h>
#import "FollowingBrandTableViewCell.h"
#import "BrandActivityDataModels.h"

@implementation FollowingBrandDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brandArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandActivitiesBrands *brands = [self.brandArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"FollowingBrandTableViewCell";
    FollowingBrandTableViewCell *cell = (FollowingBrandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                                     owner:self
                                                   options:nil];
        cell = nib[0];
    }
    cell.followingBrandContent.text = [NSString stringWithFormat:@"%@ posted a deals",brands.brandName];
    [cell.brandImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/brands/logo/%@",brands.brandLogo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}


@end
