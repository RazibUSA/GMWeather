//
//  MainViewModel.m
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


-(NSMutableArray*)processWeatherData:(NSString*)urlPath{
    
    NSMutableArray *weatherDataList = [[NSMutableArray alloc] init];
    
    NSDictionary *responseData = [Utils getWeatherData:urlPath];
    if(responseData) {
    NSArray *forcastDayData = [[[responseData objectForKey:@"forecast"] objectForKey:@"simpleforecast"] objectForKey:@"forecastday"];
        
     NSArray *forcastDayText = [[[responseData objectForKey:@"forecast"] objectForKey:@"txt_forecast"] objectForKey:@"forecastday"];
    
        if(forcastDayData){
            
            for(NSDictionary *dayWiseData in forcastDayData){
                
                NSString *dayTitle = [dayWiseData objectForKey:@"date"][@"weekday"];
                NSString  *condtion = dayWiseData[@"conditions"];
                NSString *lowTemp = [self formateTempStr:[dayWiseData objectForKey:@"low"][@"fahrenheit"] preFix:@"L"];
                NSString *highTemp = [self formateTempStr:[dayWiseData objectForKey:@"high"][@"fahrenheit"] preFix:@"H"]; ;
                NSString *text = nil;
                if(forcastDayText){
                    for(NSDictionary *dayWiseText in forcastDayText){
                        if([dayWiseText[@"title"] isEqualToString:dayTitle])
                            text = dayWiseText[@"fcttext"];
                        
                    }
                }
                
                NSLog(@"Days:%@ condtion:%@ Low:%@ H:%@ T:%@",dayTitle, condtion, lowTemp, highTemp, text);
                
                WeatherInfoModel *weatherInfoModel = [[WeatherInfoModel alloc] initWithWeatherData:dayTitle currentTemp:condtion highTemp:highTemp lowTemp:lowTemp condotionDescription:text];
                
                [weatherDataList addObject:weatherInfoModel];
                
                
            }

            
        } else{
            
        
            
            WeatherInfoModel *weatherInfoModel = [[WeatherInfoModel alloc] initWithWeatherData:@"NONE" currentTemp:@"No Data" highTemp:nil lowTemp:nil condotionDescription:@"Can't Retrive Data from Server, Please change the Settings"];
            
            [weatherDataList addObject:weatherInfoModel];
        }
        
    }
    
    return weatherDataList;
}


-(NSString*)formateTempStr:(NSString*)value preFix:(NSString*)letter{
    
    
 NSString *str =   [NSString stringWithFormat:@"%@: %@ F", letter, value];
 return str;

    
}


@end
