//
//  FollowingBrandDatasource.h
//  Chopchop
//
//  Created by Arie on 11/27/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FollowingBrandDatasource : NSObject <UITableViewDataSource>
@property (strong, nonatomic) NSArray *brandArray;
@end
