//
//  Utils.h
//  GMWeather
//
//  Created by Razib Mollick on 6/29/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#ifndef Utils_h
#define Utils_h

@interface Utils : NSObject
+(NSData*) getJsonData;
+(NSDictionary*)getStateCountryList;
+ (NSInteger)checkServerStatus;
+ (NSDictionary*)getWeatherData:(NSString *)urlPath;

@end

#endif /* Utils_h */
