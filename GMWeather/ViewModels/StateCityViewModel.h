//
//  StateCityViewModel.h
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSelectionModel.h"

@interface StateCityViewModel : NSObject

@property (nonatomic, weak) UserSelectionModel *selectedPlace;
@property (nonatomic, weak) NSDictionary *geoDictionary;
@property (nonatomic, weak) NSString *selectedCity;

-(NSArray*)getStateNames:(NSString*)country;
-(NSArray*)getCityNames:(NSString*)state;
-(NSString*)setUserSelection:(NSString*)state city:(NSString*)city;
-(UserSelectionModel*) updateWeatherView;
-(NSString*)getSelectedCity;

@end
