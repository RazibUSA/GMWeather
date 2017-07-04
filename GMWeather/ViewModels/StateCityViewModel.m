//
//  StateCityViewModel.m
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "StateCityViewModel.h"
#import "Utils.h"
#import "Constants.h"

@implementation StateCityViewModel

- (instancetype)init {
    if (self = [super init]) {
        _geoDictionary = [Utils getStateCountryList];
    }
    return self;
}


-(NSArray*)getStateNames:(NSString*)country{
    
    if(_geoDictionary) return [_geoDictionary allKeys];
    
    return nil;
}
-(NSArray*)getCityNames:(NSString*)state{
    
    if(!_geoDictionary){
            _geoDictionary = [Utils getStateCountryList];
    }
    
    if(_geoDictionary){
        
        NSDictionary *temp = [_geoDictionary objectForKey:state];
        return [temp objectForKey:@"cities"];
    }
    
    return nil;
}
-(NSString*)setUserSelection:(NSString*)state city:(NSString*)city{
    
    NSString *newString = nil;
    
    _geoDictionary = [Utils getStateCountryList];
    NSDictionary *temp = [_geoDictionary objectForKey:state];
    NSString *stateID = [temp objectForKey:@"short"];
    
     _selectedCity = city;
    
    if ([city componentsSeparatedByString:@" "].count > 1)
    newString = [city stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    else
    newString = city;
   
    
    if(stateID && newString)
   return [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/forecast/q/%@/%@.json",
     K_W_UNDER_GROUND_KEY, stateID, newString];
    else
     return nil;

    
}


-(NSString*)getSelectedCity{
    return _selectedCity;
}
-(UserSelectionModel*) updateWeatherView{
    return nil;
}


@end
