//
//  MainViewModel.h
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherInfoModel.h"
#import "Utils.h"


@interface MainViewModel : NSObject

@property (nonatomic, weak) NSArray *weatherInfoModelArray;

-(NSMutableArray*)processWeatherData:(NSString*)urlPath;

@end
