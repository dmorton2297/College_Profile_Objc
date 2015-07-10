//
//  MapViewController.m
//  College_Profile_Objc
//
//  Created by Dan Morton on 7/9/15.
//  Copyright (c) 2015 Dan Morton. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@end

@implementation MapViewController

@synthesize locationName;

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated{
    [self presentUserWithOption];
}

- (void)presentUserWithOption {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loading..." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:locationName completionHandler:^(NSArray *placemarks, NSError *error) {
        for (int i = 0; i < placemarks.count; i++){
            CLPlacemark *placemark = placemarks[i];
            NSMutableString *title = [NSMutableString stringWithString:placemark.name];
            [title appendString:@", "];
            [title appendString:placemark.administrativeArea];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self presentLocationOnMap:placemark.location];
            }];
            [alert addAction:action];
            alert.title = @"Choose an option";
            
        }
    }];
    
    [self presentViewController:alert animated:true completion:nil];

}

- (void)presentLocationOnMap: (CLLocation *)location {
    [self.myMapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:true];
    MKPointAnnotation *anno = [[MKPointAnnotation alloc]init];
    anno.title = self.locationName;
    anno.coordinate = location.coordinate;
    [self.myMapView addAnnotation:anno];
}

- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
