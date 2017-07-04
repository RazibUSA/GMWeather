//
//  ViewController.h
//  GMWeather
//
//  Created by Razib Mollick on 6/28/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "StateCityViewController.h"
#import "MainViewModel.h"
#import "WeatherInfoModel.h"
@interface ViewController : UIViewController < StateCityUpdater>


@property (weak, nonatomic) IBOutlet UIView     *wInfoView;
@property (strong, nonatomic)  MainViewModel    *mcViewModel;
@property (nonatomic, strong) NSMutableArray    *weatherInfoModelArray;

// IB
@property (weak, nonatomic) IBOutlet UILabel    *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel    *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel    *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel    *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel    *lowTempLabel;
@property (weak, nonatomic) IBOutlet UITextView *weatherDescTextView;

@property (weak, nonatomic) IBOutlet UIScrollView *buttonGroupScrollView;
@property (nonatomic, assign) int dayID;

@end

