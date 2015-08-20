//
//  WeatherDetailViewController.h
//  WeatherApp
//
//  Created by Smita Tamboli on 8/18/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebManager.h"

@interface WeatherDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, NetworkManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

@end
