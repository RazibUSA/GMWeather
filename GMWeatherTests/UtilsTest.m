//
//  UtilsTest.m
//  GMWeather
//
//  Created by Razib Mollick on 7/3/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"

@interface UtilsTest : XCTestCase

@end

@implementation UtilsTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//+(NSData*) getJsonData;
//+(NSDictionary*)getStateCountryList;
//+ (NSDictionary*)getWeatherData:(NSString *)urlPath;


-(void)testGetJsonData{
    //Random state will be checked
    NSData *statecityListData = [Utils getJsonData];
    XCTAssertNotNil(statecityListData, @"Cannot find file to load State City List instance");
    
}

-(void)testGetStateCountryList{
    //NSData *statecityListRawData = [Utils getJsonData];
    NSDictionary *StateCityList = [Utils getStateCountryList];
    //Random state will be checked
    NSString *Utah          = @"Utah";
    NSString *Washington    = @"Washington";
    NSString *Massachusetts = @"Massachusetts";
    
    
    XCTAssertFalse(StateCityList[Utah]==nil, @"Result Should be False");
    XCTAssertFalse(StateCityList[Washington]==nil, @"Result Should be False");
    XCTAssertFalse(StateCityList[Massachusetts]==nil, @"Result Should be False");
    XCTAssertTrue(StateCityList[@"Midland"]==nil, @"Result Should be True");
    
}

-(void)testGetWeatherDataValidURL{
    NSString *path = @"http://api.wunderground.com/api/ac178d7124d172ea/forecast/q/CA/San_Francisco.json";
    NSDictionary *wDataDic = [Utils getWeatherData:path];
    
    XCTAssertNotNil(wDataDic, @"weather data should not be nil");
}

-(void)testGetWeatherDataWrongKey{
    
    NSString *path = @"http://api.wunderground.com/api/xyz/forecast/q/CA/San_Francisco.json";
    NSDictionary *wDataDic = [Utils getWeatherData:path];
    
    XCTAssertNotNil(wDataDic, @"weather data should not be nil");
}

-(void)testGetWeatherDataWrongURL{
    
    NSString *path = @"http://api.wun.com/api/xyz/forecast/q/CA/San_Francisco.json";
    NSDictionary *wDataDic = [Utils getWeatherData:path];
    
    XCTAssertNil(wDataDic, @"weather data should be nil");
}



@end
