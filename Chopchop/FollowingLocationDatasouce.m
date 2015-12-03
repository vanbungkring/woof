//
//  FollowingLocationDatasouce.m
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowingLocationDatasouce.h"
#import "FollowingTableViewCell.h"
@implementation FollowingLocationDatasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FollowingTableViewCell";
    FollowingTableViewCell *cell = (FollowingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                                     owner:self
                                                   options:nil];
        cell = nib[0];
    }
    cell.followingContentLabel.text = @"Lorem ipsum dolor sit amet amet,Lorem ipsum dolor sit amet amet,Lorem ipsum dolor sit amet amet,Lorem ipsum dolor sit amet amet";
    return cell;
}
@end
