//
//  ViewController.m
//  ARMapViewDemo
//
//  Created by Alex Reynolds on 2/9/15.
//  Copyright (c) 2015 Alex Reynolds. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
#import "MKMapView+ARHelpers.h"
@interface ViewController ()
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    UIButton *locate = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    [locate setTitle:@"Locate" forState:UIControlStateNormal];
    [locate setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [locate addTarget:self action:@selector(locate:) forControlEvents:UIControlEventTouchUpInside];
    [locate sizeToFit];
    locate.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:locate];
    // Do any additional setup after loading the view, typically from a nib.
}

- (MKMapView *)mapView
{
    if(_mapView == nil){
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _mapView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)locate:(id)selector
{
    [self.mapView ARStartUpdatingLocationWithUpdate:^(NSError *error, CLLocation *location) {
        NSLog(@"location %@", location);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
