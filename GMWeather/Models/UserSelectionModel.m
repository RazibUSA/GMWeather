//
//  UserSelectionModel.m
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "UserSelectionModel.h"

@implementation UserSelectionModel

-(instancetype)initWithSelection:(NSString*)stateName cityName:(NSString*)cityName {
    
    self = [self init];
    
    if(!self){return nil;}
    
    _selectedStateName = stateName;
    _selectedCityName = cityName;
    _selectedRequestType = @"forcast";
    
    return self;
    
}

@end
