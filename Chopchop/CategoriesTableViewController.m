//
//  CategoriesTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/8/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoriesCell.h"
#import "CategoriesDataModels.h"
@interface CategoriesTableViewController ()
@property (nonatomic,strong)NSArray *categoriesArray;
@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Categories";
    self.tableView.tableFooterView = [UIView new];
    [self getAllCategories];
}
- (void)getAllCategories {
    [CategoriesResponse getAllCategories:@{@"token":@"379d1990b8cb00febe08373b944c2d1f"} completionBlock:^(NSArray *json, NSError *error) {
        if (!error) {
            self.categoriesArray = json;
            [self.tableView reloadData];
            
        }
        else {
            NSLog(@"error->%@",error);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.categoriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // CategoriesResponse
    CategoriesCategories *cat = [self.categoriesArray objectAtIndex:indexPath.row];
    CategoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesCell" forIndexPath:indexPath];
    [cell setCategoriesCategories:cat];
    // Configure the cell...
    
    return cell;
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
