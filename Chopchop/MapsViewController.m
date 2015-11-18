//
//  MapsViewController.m
//  Chopchop
//
//  Created by Arie on 10/22/15.
//  Copyright © 2015 Arie. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *maps;

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Location";
    self.maps.showsUserLocation = NO;
    self.maps.delegate = self;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.location.coordinate];
    [annotation setTitle:@"Title"]; //You can set the subtitle too
    [self.maps addAnnotation:annotation];
    // Do any additional setup after loading the view from its nib.
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 500, 500);
    [self.maps setRegion:[self.maps regionThatFits:region] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
