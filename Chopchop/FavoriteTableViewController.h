//
//  FavoriteTableViewController.h
//  Chopchop
//
//  Created by Arie on 9/6/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "BaseViewController.h"
@interface FavoriteTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIRefreshControl *refreshControl;
@property (weak, nonatomic) NSString *categoryId;

@end
