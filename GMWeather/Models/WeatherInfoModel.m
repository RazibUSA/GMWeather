//
//  WeatherInfoModel.m
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "WeatherInfoModel.h"

@implementation WeatherInfoModel


-(instancetype)initWithWeatherData:(NSString*)dayName currentTemp:(NSString*)cTemp highTemp:(NSString*)hTemp lowTemp:(NSString*)lTemp condotionDescription:(NSString*)cDes{
    
    self = [self init];
    
    if(!self){return nil;}
    
    _dayOfWeek              = dayName;
    _currentTemperature     = cTemp;
    _highTemperature        = hTemp;
    _lowTemperature         = lTemp;
    _conditionDescription   = cDes;
    
    return self;
    
    
}

@end
