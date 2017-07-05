//
//  Utils.m
//  GMWeather
//
//  Created by Razib Mollick on 6/29/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "Constants.h"

@implementation Utils


+(NSData*) getJsonData{
    
    NSData *geoData = nil;
    
    //get file name
    NSString *fileName = [[NSBundle mainBundle] pathForResource:FILE_NAME
                                                         ofType:FILE_TYPE_JSON
                                                inDirectory:LOCAL_FOLDER];
    
    //check file exists
    if (fileName) {
        //retrieve file content
        geoData = [[NSData alloc] initWithContentsOfFile:fileName];
    } else{
          NSLog(@"Couldn't find the file!");
    }
    
        return geoData;
}

+(NSDictionary*)getStateCountryList{
    
    NSData *geoData = [Utils getJsonData];
    NSDictionary *stateCityList = nil;
    
    if(geoData != nil){
        //convert JSON NSData to a usable NSDictionary
        NSError *error;
        stateCityList = [NSJSONSerialization JSONObjectWithData:geoData
                                                                      options:0
                                                                        error:&error];
        
        if (error) {
            NSLog(@"Something went wrong! %@", error.localizedDescription);
        }
        else {
          //  NSLog(@"Geo info: %@", stateCityList);
        }
        
       
    }else{
        NSLog(@"No Geo data found");
    }
    
    return stateCityList;
}
    
//username pass:gm1243
//ac178d7124d172ea


+ (NSInteger)checkServerStatus{
    
    return 200;
    
}


+ (NSDictionary*)getWeatherData:(NSString *)urlPath{
    
    //Prepare URL
    NSString *urlString;
    NSDictionary *responseData = nil;
    
    // get URL for current conditions
    
    if (!urlPath)
    {
        //http://api.wunderground.com/api/ac178d7124d172ea/forecast/q/CA/San_Francisco.json
        
        urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/%@/q/%@/%@.json",
                     K_W_UNDER_GROUND_KEY,
                     W_CALL_FORECAST,
                     STATE_ID_CA,
                     CITY_SAN_FRANCISCO];
    }
   
    else
    {
        urlString = urlPath;
    }
    
    NSURL *url          = [NSURL URLWithString:urlString];
    
    NSData *weatherData = [NSData dataWithContentsOfURL:url];
    
    if (weatherData != nil)
    {
        // parse the JSON results
        
        NSError *error;
        responseData = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&error];
        if (error) {
            NSLog(@"Something went wrong! %@", error.localizedDescription);
        }
        else {
            NSLog(@"Response Data is OK");
        }

    }else{
        NSLog(@"No Data Found");
    }
    

    return responseData;
  
}



@end
