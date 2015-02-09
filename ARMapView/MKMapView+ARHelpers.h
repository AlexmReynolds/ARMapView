//
//  MKMapView+ARHelpers.h
//  ARMapViewDemo
//
//  Created by Alex Reynolds on 2/9/15.
//  Copyright (c) 2015 Alex Reynolds. All rights reserved.
//

@import MapKit;
typedef void (^locationBlock)(NSError *error, CLLocation *location);

@interface MKMapView (ARHelpers)<CLLocationManagerDelegate>
// CLLocation manager to use for location.
@property (nonatomic, strong) CLLocationManager *ARLocationManager;

// block to call when the user has been located and their location was updated or failed
@property (nonatomic, copy) locationBlock ARUpdateBlock;

/**
 *  @abstract Find the user's current location with CoreLocation
 *
 *  @discussion This method will start locating the user via corelocation and send updates to the update block
 *
 *  @param updateBlock a block that is called on an update or on failure to locate user with the @c NSError or @c CLLocation
 *
 */
- (void)ARStartUpdatingLocationWithUpdate:(locationBlock)updateBlock;

/**
 *  @abstract stops tracking user location
 *
 *  @discussion This method will stop corelocation from tracking user and also nil out our update block
 *
 */
- (void)ARStopUpdatingLocation;

/**
 *  @abstract Zooms into an array of annotations
 *
 *  @discussion Sets the maps visible rect to that of one containing all annotations in the array
 *
 *  @param annotations an @c NSArray to create and encompassing rect
 *
 *  @param includeUserLocation if set we will include the users current location into the rect
 */
- (void)ARZoomToFitAnnotations:(NSArray*)annotations includeUserLocation:(BOOL)includeUserLocation;

/**
 *  @abstract Zooms into an array of annotations
 *
 *  @discussion Sets the maps visible rect to that of one containing all annotations in the array
 *
 *  @param annotations an @c NSArray to create and encompassing rect
 *
 */
- (void)ARZoomToFitAnnotations:(NSArray*)annotations;

@end
