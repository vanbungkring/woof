//
//  FollowerTableViewController.m
//  Chopchop
//
//  Created by Arie on 9/26/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "FollowerTableViewController.h"
#import "LoginViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface FollowerTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation FollowerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Following";
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Ooops....you need to login to use this feature!";
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[text rangeOfString:@"Woof"]];
    
    return attributedTitle;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"To show a list of random colors, tap on the refresh icon in the right top corner.\n\nTo clean the list, tap on the trash icon.";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return nil;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"Login or Register";
    UIColor *textColor = (state == UIControlStateNormal) ? [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] : [UIColor colorWithRed:204/255.0 green:228/255.0 blue:255/255.0 alpha:1.0];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName: textColor};
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedTitle;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
   
}
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    UINavigationController *nav = [[UINavigationController alloc]init];
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    nav.viewControllers = @[login];
    
    [self presentViewController:nav animated:YES completion:nil];
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