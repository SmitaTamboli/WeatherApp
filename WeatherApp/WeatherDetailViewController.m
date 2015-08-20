//
//  WeatherDetailViewController.m
//  WeatherApp
//
//  Created by Smita Tamboli on 8/18/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "WeatherTableViewCell.h"

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController {
    
    __weak IBOutlet UITableView *weatherTableView;
    __weak IBOutlet UISearchBar *weatherSearchBar;
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    NSString *searchTextKey;
    WebManager *webManager;
    NSArray *weatherArray;
    NSString *state;
    NSString *latitude;
    NSString *longitude;
    UIAlertView *alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webManager = [[WebManager alloc] init];
    
    if ([weatherSearchBar.text isEqualToString:@""]) {
        [self initializeLocationManager];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SearchBar text

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    searchTextKey = searchBar.text;    
    [searchBar resignFirstResponder];
    [self stablishConnectivity:searchTextKey];
}

- (void)stablishConnectivity:(NSString *)searchKey {
    
    webManager.networkManagerDelegate = self;
    
    [webManager makeConnection:searchKey];
}

#pragma mark NetworkManager delegate

- (void)handleData:(NSArray*)data withError:(NSError *)error withErrorMessag:(NSString *)errorMessage {
    
    if (errorMessage != nil) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",errorMessage] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (error != nil) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }else if (data.count > 0 && data != nil) {
        weatherArray = data;
        [weatherTableView reloadData];
    }
}

#pragma mark 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return weatherArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    WeatherModel *weatherDetail = [weatherArray objectAtIndex:indexPath.row];
    [cell configureCell:weatherDetail];
    
    return cell;
}

#pragma mark CoreLocations

-(void)initializeLocationManager {
    
    geocoder = [[CLGeocoder alloc] init];
        
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [self.locationManager requestAlwaysAuthorization];
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }

        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
    
}

#pragma mark CLLocatinManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        
        if (error == nil && placemarks.count > 0) {
            placemark = [placemarks lastObject];
            state = placemark.locality;
            NSLog(@"state: %@",state);
            NSLog(@"%@ %@ %@", placemark.postalCode, placemark.locality, placemark.country);
            [self stablishConnectivity:state];
        } else {
            NSLog(@"%@",error.debugDescription);
        }
    }];
    
    [_locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
