//
//  UserSelectionModel.h
//  GMWeather
//
//  Created by Razib Mollick on 7/1/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>

@interface UserSelectionModel : NSObject

@property (nonatomic, strong) NSString *selectedStateName;
@property (nonatomic, strong) NSString *selectedCityName;
@property (nonatomic, strong) NSString *selectedRequestType;

#pragma Instance Method

-(instancetype)initWithSelection:(NSString*)stateName cityName:(NSString*)cityName;


@end
