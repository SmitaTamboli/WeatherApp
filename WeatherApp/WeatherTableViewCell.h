//
//  WeatherTableViewCell.h
//  WeatherApp
//
//  Created by Smita Tamboli on 8/19/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherTableViewCell : UITableViewCell

-(void)configureCell:(WeatherModel *)weatherDetail;

@end
