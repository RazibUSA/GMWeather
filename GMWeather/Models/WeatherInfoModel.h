//
//  WeatherInfoModel.h
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef struct {
//    CGFloat fahrenheit;
//    CGFloat celsius;
//} UWTemperature;
//
//static inline UWTemperature UWTemperatureMake(CGFloat fahrenheit, CGFloat celsius) {
//    return (UWTemperature){fahrenheit, celsius};
//}


@interface WeatherInfoModel : NSObject



//  Name of the day of week
@property (strong, nonatomic) NSString      *dayOfWeek;

//  Description of the day's conditions
@property (strong, nonatomic) NSString      *conditionDescription;

//  Day's current temperature, if applicable
@property (strong, nonatomic) NSString *currentTemperature;

//  Day's high temperature
@property (strong, nonatomic) NSString *highTemperature;

//  Day's low temperature
@property (strong, nonatomic) NSString *lowTemperature;

-(instancetype)initWithWeatherData:(NSString*)dayName currentTemp:(NSString*)cTemp highTemp:(NSString*)hTemp lowTemp:(NSString*)lTemp condotionDescription:(NSString*)cDes;

@end
