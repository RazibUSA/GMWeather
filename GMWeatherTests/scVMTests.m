//
//  scVMTests.m
//  GMWeather
//
//  Created by Razib Mollick on 7/4/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
//#import <OCMock.h>
#import "StateCityViewModel.h"


@interface scVMTests : XCTestCase

@property (nonatomic) StateCityViewModel *scViewModelClass;

@end

@implementation scVMTests



- (void)setUp {
    [super setUp];
    self.scViewModelClass =[[StateCityViewModel alloc] init];
    
}

- (void)tearDown {
    [super tearDown];
}

//Methods To Be Tested

//-(NSArray*)getStateNames:(NSString*)country;
//-(NSArray*)getCityNames:(NSString*)state;
//-(NSString*)setUserSelection:(NSString*)state city:(NSString*)city;
//-(UserSelectionModel*) updateWeatherView;
//-(NSString*)getSelectedCity;

-(void)testGetStateNames{
    NSMutableDictionary *mutableDictionaryCity = [[NSMutableDictionary alloc] init];
    [mutableDictionaryCity setObject:@"Alta" forKey:@"cities"];
    
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary setObject:mutableDictionaryCity forKey:@"key"];
    _scViewModelClass.geoDictionary = mutableDictionary;
    
   
    
    NSArray *stateList = [_scViewModelClass getStateNames:@"US"];
    
    XCTAssertEqualObjects(stateList[0], @"key", @"State list should be generated!");
    
}


-(void)testGetCityNames{
    NSMutableDictionary *mutableDictionaryCity = [[NSMutableDictionary alloc] init];
    [mutableDictionaryCity setObject:@"Alta" forKey:@"cities"];
    NSDictionary *cityDic = mutableDictionaryCity;
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary setObject:cityDic forKey:@"key"];
    _scViewModelClass.geoDictionary = mutableDictionary;
    
    NSArray *cityList = [_scViewModelClass getCityNames:@"key"];
    NSString *city = cityList;
    NSLog(@"City%@", city);
    
    XCTAssertEqualObjects(city, @"Alta", @"State list should be generated!");
    
}


-(void)testSetUserSelection {
    NSString *path = @"http://api.wunderground.com/api/ac178d7124d172ea/forecast/q/CA/San_Francisco.json";
    NSString *retURL = [_scViewModelClass setUserSelection:@"California" city:@"San Francisco"];
    XCTAssertEqualObjects(path, retURL, @"Both URL should be same.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
