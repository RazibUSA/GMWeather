//
//  mainVMTests.m
//  GMWeather
//
//  Created by Razib Mollick on 7/4/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MainViewModel.h"
#import "WeatherInfoModel.h"

@interface mainVMTests : XCTestCase

@property (nonatomic)MainViewModel *mcViewModel;

@end

@implementation mainVMTests

- (void)setUp {
    [super setUp];
    _mcViewModel = [[MainViewModel alloc] init];
}

- (void)tearDown {
    
    [super tearDown];
}

-(void)testProcessWeatherData{
     NSString *path = @"http://api.wunderground.com/api/ac178d7124d172ea/forecast/q/CA/San_Francisco.json";
    
    NSMutableArray *weatherData = [_mcViewModel processWeatherData:path];
    
    XCTAssertNotNil(weatherData, @"Weather Data should not be nil");
    
    
}

-(void)testProcessWeatherDataNil{
     NSString *path = nil;
    NSMutableArray *weatherData = [_mcViewModel processWeatherData:path];
    
    XCTAssertNotNil(weatherData, @"Weather Data should not be nil");

    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
