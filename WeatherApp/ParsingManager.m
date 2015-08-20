//
//  ParsingManager.m
//  WeatherApp
//
//  Created by Smita Tamboli on 8/18/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import "ParsingManager.h"
#import "WeatherModel.h"

@implementation ParsingManager

- (NSMutableArray *)parseData:(NSArray*)itemArray {
    NSLog(@" array count : %lu",(unsigned long)[itemArray count]);
    NSMutableArray *booksArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dayWeather in itemArray) {
        
        WeatherModel *dailyWeather = [[WeatherModel alloc] init];
        
        dailyWeather.dt_txt = dayWeather[@"dt_txt"];
        
        NSDictionary *main = dayWeather[@"main"];
        dailyWeather.grnd_level = main[@"grnd_level"];
        dailyWeather.humidity = [main[@"humidity"] intValue];
        dailyWeather.pressure = main[@"pressure"];
        dailyWeather.sea_level = main[@"sea_level"];
        dailyWeather.temp = main[@"temp"];
        dailyWeather.temp_kf = main[@"temp_kf"];
        dailyWeather.temp_max = main[@"temp_max"];
        dailyWeather.temp_min = main[@"temp_min"];
        
        NSArray *weather = dayWeather[@"weather"];
        for (NSDictionary *weatherDictionary in weather) {
            dailyWeather.discription = weatherDictionary[@"description"];
            dailyWeather.icon = weatherDictionary[@"icon"];
        }
        
        NSDictionary *wind = dayWeather[@"wind"];
        dailyWeather.deg = wind[@"deg"];
        dailyWeather.speed = wind[@"speed"];
        
        [booksArray addObject:dailyWeather];
    }

    return booksArray;
}

@end
