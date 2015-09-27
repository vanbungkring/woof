//
//  CategoriesCell.m
//  Chopchop
//
//  Created by Arie on 9/8/15.
//  Copyright (c) 2015 Arie. All rights reserved.
//

#import "CategoriesCell.h"
#import "CategoriesDataModels.h"
#import <UIImageView+PINRemoteImage.h>
@implementation CategoriesCell
- (void)setCategoriesCategories:(CategoriesCategories *)categoriesCategories {
    self.categoriesNamw.text = categoriesCategories.name;
     [self.categoriesImage pin_setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.chopchop-app.com/img/categories/%@",categoriesCategories.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.categoriesImage.contentMode = UIViewContentModeScaleAspectFit;
    self.categoriesImage.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
