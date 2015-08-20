//
//  WeatherModel.h
//  WeatherApp
//
//  Created by Smita Tamboli on 8/18/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic,strong) NSString *dt_txt;
@property (nonatomic,strong) NSString *temp;
@property (nonatomic,strong) NSString *temp_min;
@property (nonatomic,strong) NSString *temp_max;
@property (nonatomic,strong) NSString *pressure;
@property (nonatomic,strong) NSString *sea_level;
@property (nonatomic,strong) NSString *grnd_level;
@property int humidity;
@property (nonatomic,strong) NSString *temp_kf;
@property (nonatomic,strong) NSString *main;
@property (nonatomic,strong) NSString *discription;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *speed;
@property (nonatomic,strong) NSString *deg;

@end
