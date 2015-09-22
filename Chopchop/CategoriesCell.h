//
//  CategoriesCell.h
//  Chopchop
//
//  Created by Arie on 9/8/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesDataModels.h"
@class CategoriesCategories;
@interface CategoriesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoriesImage;
@property (weak, nonatomic) IBOutlet UILabel *categoriesNamw;
@property (nonatomic,strong) CategoriesCategories *categoriesCategories;
@end
