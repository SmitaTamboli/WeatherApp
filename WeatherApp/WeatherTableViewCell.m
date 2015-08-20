//
//  WeatherTableViewCell.m
//  WeatherApp
//
//  Created by Smita Tamboli on 8/19/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell {
    
    __weak IBOutlet UIImageView *cellImageView;
    __weak IBOutlet UILabel *minTemp;
    __weak IBOutlet UILabel *maxTemp;
    __weak IBOutlet UILabel *date;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(WeatherModel *)weatherDetail {
    cellImageView.image = nil;
    NSString *imageName = [NSString stringWithFormat:@"%@.png",weatherDetail.icon];
    NSLog(@"image Name: %@",imageName);
    [cellImageView setImage:[UIImage imageNamed:imageName]];
    minTemp.text = [NSString stringWithFormat:@"MIN:%@",weatherDetail.temp_min];
    maxTemp.text = [NSString stringWithFormat:@"MAX:%@",weatherDetail.temp_max];
    date.text = [NSString stringWithFormat:@"%@",weatherDetail.dt_txt];
}

@end
