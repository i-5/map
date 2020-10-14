//
//  MapViewController.h
//  Map
//
//  Created by 子民 駱 on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate>{
    
    CLLocationManager *locationManager;
    MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (IBAction)showAddress:(id)sender;
@end
