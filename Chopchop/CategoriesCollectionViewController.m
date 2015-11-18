//
//  CategoriesCollectionViewController.m
//  Chopchop
//
//  Created by Arie on 9/12/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "CategoriesCollectionViewController.h"
#import "CategoriesDataModels.h"
#import "Util.h"
#import <UIFont+Montserrat.h>
#import <UIImage+Color.h>
#import "FavoriteTableViewController.h"
#import <UIImageView+PINRemoteImage.h>
@interface CategoriesCollectionViewController ()
@property (nonatomic,strong) NSArray *categoriesArray;
@end

@implementation CategoriesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.title = @"Categories";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // [self getAllCategories];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.itemSize= CGSizeMake((self.view.frame.size.width-10)/4, 130);
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    [self.collectionView setCollectionViewLayout:layout];
    
    self.categoriesArray =  [CategoriesResponse allCategories];
    
    [self.collectionView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.categoriesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesCategories *c = [self.categoriesArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *labelcategories = (UILabel *)[cell viewWithTag:101];
    labelcategories.font = [UIFont montserratFontOfSize:11];
    labelcategories.textColor = [UIColor darkGrayColor];
    
    labelcategories.text = c.name;
    PINCache *cache = nil;
    [recipeImageView pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/categories/%@",c.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"] completion:^(PINRemoteImageManagerResult *result) {
        recipeImageView.tintColor = [UIColor darkGrayColor];
        recipeImageView.image = [recipeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.hidesBottomBarWhenPushed = YES;
    
    CategoriesCategories *c = [self.categoriesArray objectAtIndex:indexPath.row];
    FavoriteTableViewController *fav = [self.storyboard instantiateViewControllerWithIdentifier:@"favoriteVC"];
    fav.title = c.name;
    self.title = @"";
    fav.categoryId  = [NSString stringWithFormat:@"%0ld",(long)c.categoriesIdentifier];
    [self.navigationController pushViewController:fav animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *labelcategories = (UILabel *)[cell viewWithTag:101];
    labelcategories.textColor = [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00];
    recipeImageView.tintColor = [UIColor colorWithRed:0.17 green:0.75 blue:0.73 alpha:1.00];
    [self.collectionView setNeedsDisplay];
    recipeImageView.image = [recipeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *labelcategories = (UILabel *)[cell viewWithTag:101];
    labelcategories.textColor = [UIColor darkGrayColor];
    [self.collectionView setNeedsDisplay];
    recipeImageView.tintColor = [UIColor darkGrayColor];
    recipeImageView.image = [recipeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return YES;
}
#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
