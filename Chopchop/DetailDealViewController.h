//
//  DetailDealViewController.h
//  Chopchop
//
//  Created by Arie on 10/10/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostDataModels.h"
@interface DetailDealViewController : UIViewController
@property (nonatomic,assign)Posts *postDetail;
@property (weak, nonatomic) IBOutlet UILabel *dealTitle;
@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UILabel *dealDetail;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (weak, nonatomic) IBOutlet UILabel *relatedBrand;
@property (weak, nonatomic) IBOutlet UILabel *counterPhone;
@end
