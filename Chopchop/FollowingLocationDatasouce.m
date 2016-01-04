//
//  FollowingLocationDatasouce.m
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowingLocationDatasouce.h"
#import "FollowingTableViewCell.h"
#import "LocationsAcityDataModels.h"
#import <UIImageView+PINRemoteImage.h>
@implementation FollowingLocationDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationsActivityLocations *locations = [self.locationArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"FollowingTableViewCell";
    FollowingTableViewCell *cell = (FollowingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                                     owner:self
                                                   options:nil];
        cell = nib[0];
    }
    
    cell.followingContentLabel.attributedText = [self setAttributeStringForLocations:[NSString stringWithFormat:@"%@ has %0.f active discounts",locations.locationName,locations.countPosts]];
    [cell.locationImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/locations/logo/%@",locations.locationLogo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    if (locations.distance.km > 40) {
        cell.distanceLabel.text = @"Online";
    }
    else {
        cell.distanceLabel.text = [NSString stringWithFormat:@"%0.1f Km",locations.distance.km];
    }
    return cell;
}

- (NSAttributedString *)setAttributeStringForLocations:(NSString *)stringSource {
    NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
    
    [attributesDictionary setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    [attributesDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [attributesDictionary setObject:[UIColor blackColor] forKey:NSBackgroundColorAttributeName];
    [attributesDictionary setObject:@5.0 forKey:NSBaselineOffsetAttributeName];
    [attributesDictionary setObject:@2.0 forKey:NSStrikethroughStyleAttributeName];
    [attributesDictionary setObject:[UIColor redColor] forKey:NSStrokeColorAttributeName];
    [attributesDictionary setObject:@2.0 forKey:NSStrokeWidthAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.0;
    [attributesDictionary setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor lightGrayColor];
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowOffset = CGSizeMake(0.0, 2.0);
    [attributesDictionary setObject:shadow forKey:NSShadowAttributeName];
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:stringSource];
    
    return attributedString;
    
}


@end
