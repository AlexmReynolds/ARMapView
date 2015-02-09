//
//  MKMapView+ARHelpers.m
//  ARMapViewDemo
//
//  Created by Alex Reynolds on 2/9/15.
//  Copyright (c) 2015 Alex Reynolds. All rights reserved.
//
#import <objc/runtime.h>
#import "MKMapView+ARHelpers.h"
static void *CLLocationMgrResultKey;
static void *MyClassResultKey;

@implementation MKMapView (ARHelpers)
- (void)ARStartUpdatingLocationWithUpdate:(void (^)(NSError *, CLLocation *))locationBlock
{
    [self.ARLocationManager requestWhenInUseAuthorization];
    [self.ARLocationManager startUpdatingLocation];
    self.ARUpdateBlock = locationBlock;
}

- (void)ARStopUpdatingLocation
{
    self.ARUpdateBlock = nil;
    [self.ARLocationManager stopUpdatingLocation];
}

- (void)setARUpdateBlock:(locationBlock)updateBlock
{
    objc_setAssociatedObject(self, &MyClassResultKey, updateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (locationBlock)ARUpdateBlock
{
    locationBlock result = objc_getAssociatedObject(self, &MyClassResultKey);
    return result;
}
- (void)setARLocationManager:(CLLocationManager *)newLocationManager
{
    objc_setAssociatedObject(self, &CLLocationMgrResultKey, newLocationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CLLocationManager *)ARLocationManager {
    CLLocationManager *result = objc_getAssociatedObject(self, &CLLocationMgrResultKey);
    if (result == nil) {
        // do a lot of stuff
        result = [[CLLocationManager alloc] init];
        result.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        result.delegate = self;
        objc_setAssociatedObject(self, &CLLocationMgrResultKey, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSError *err = [NSError errorWithDomain:@"com.cyclr" code:-1221 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Location could not be determined at this time. Please try searching for your location instead", @"Location not determined message")}];
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"User denied location permissions");
            err = [NSError errorWithDomain:@"com.cyclr" code:-1221 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Location services have been disabled. Please go to Settings-> Privacy-> Location Service and enable Househappy", @"Location denied message")}];
            break;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        default:
            break;
    }
    if(self.ARUpdateBlock){
        self.ARUpdateBlock(err, nil);
    }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"status - Authorized");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"status - denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"status - not determined");
            [manager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"status - restricted");
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    if(self.ARUpdateBlock){
        self.ARUpdateBlock(nil, location);
    }
    
}
- (void)ARZoomToFitAnnotations:(NSArray*)annotations
{
    [self ARZoomToFitAnnotations:annotations includeUserLocation:NO];
}
- (void)ARZoomToFitAnnotations:(NSArray*)annotations includeUserLocation:(BOOL)includeUserLocation
{
    MKMapRect zoomRect = MKMapRectNull;
    MKMapPoint annotationPoint;
    if(includeUserLocation){
        annotationPoint = MKMapPointForCoordinate(self.userLocation.coordinate);
        zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    }

    for (id <MKAnnotation> annotation in annotations)
    {
        annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self setVisibleMapRect:zoomRect animated:YES];
}
@end
