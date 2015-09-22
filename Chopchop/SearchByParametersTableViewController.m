//
//  SearchByParametersTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/21/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "SearchByParametersTableViewController.h"
#import "PostDataModels.h"
#import <UIImageView+PINRemoteImage.h>
#import <MZFormSheetPresentationController.h>
#import "FavoriteDetailViewController.h"
#import "FavoriteTableViewCell.h"
@interface SearchByParametersTableViewController ()
@property (nonatomic,strong)NSArray *favoriteData;
@end

@implementation SearchByParametersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@"379d1990b8cb00febe08373b944c2d1f" forKey:@"token"];
    
    if (self.isBrand) {
        NSLog(@"data-->%@",self.post.brand.logo);
        self.brandName.text = self.post.brand.name;
        self.additionalInformation.text = self.post.location.website;
        [self.avatarImageView pin_setImageFromURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/brands/%@",self.post.brand.logo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [parameters setObject:[NSString stringWithFormat:@"%0.f",self.post.brand.brandIdentifier] forKey:@"brand_id"];
    }
    else {
        self.brandName.text = self.post.location.name;
        self.additionalInformation.text = self.post.location.website;
        [parameters setObject:[NSString stringWithFormat:@"%0.f",self.post.location.locationIdentifier] forKey:@"location_id"];
    }
    [Response getAllPost:parameters completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            self.favoriteData = json;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.favoriteData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.favoriteDidTapped.tag = indexPath.row;
    [cell setPost:post];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 419;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailFavorite"];
    Posts *post = [self.favoriteData objectAtIndex:indexPath.row];
    detail.brandName = post.brand.name;
    detail.website = post.location.website;
    detail.location = post.location.name;
    detail.content = post.name;
    detail.imageUrl  = post.files;
    MZFormSheetPresentationController *formSheetController = [[MZFormSheetPresentationController alloc] initWithContentViewController:detail];
    formSheetController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.contentViewSize = CGSizeMake(300, 250);
    [self presentViewController:formSheetController animated:YES completion:nil];
    
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
