//
//  MapViewController.m
//  Map
//
//  Created by 子民 駱 on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize mapView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    CLLocationCoordinate2D coordinate;
    coordinate = newLocation.coordinate;
    
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    
    MKCoordinateRegion zoom = self.mapView.region;
    zoom.span.latitudeDelta = 0.005;
    zoom.span.longitudeDelta = 0.005;
    [self.mapView setRegion:zoom animated:YES];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MapView"
                                                    message:@"FailLoadingMap" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

- (void)dealloc {
    locationManager.delegate = nil;
    [locationManager release];
    
    [mapView release];
    [super dealloc];
}

- (IBAction)showAddress:(id)sender {
    CLLocation *location = locationManager.location;
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    MKReverseGeocoder *reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
    reverseGeocoder.delegate = self;
    [reverseGeocoder start];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Address"
                                                    message:placemark.title
                                                   delegate:self
                                          cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Address"
                                                    message:@"Error!"
                                                   delegate:self
                                          cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
}

@end
