//
//  ViewController.m
//  GMWeather
//
//  Created by Razib Mollick on 6/28/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcViewModel = [[MainViewModel alloc] init];
    
    [self setupViewRoundStyle];
    
    NSString *urlPath = [self retriveSelectedPath];
    NSMutableArray *selectedPlace = [self retriveSelectedStateCity];
    
    if(urlPath){
        [self updateWeatherView:urlPath city:selectedPlace[1]];
        
    }else{
        // Need to get current city and state from CILocation API-TODO
        [self updateWeatherView:nil city:@"San Francisco"];
        [self storeSelectedStateCity:@"California" city:@"San Francisco"];
    }

}

-(void)setupViewRoundStyle{
    
    _wInfoView.layer.cornerRadius = _wInfoView.bounds.size.width/4;
    _wInfoView.layer.borderColor = [UIColor redColor].CGColor;
    _wInfoView.layer.borderWidth = 3.0f;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceDidRotate {
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        default:
            
            if(_weatherInfoModelArray){
                [self updateScrollView];
            }
                
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateWeatherView:(NSString*)tailPath city:(NSString*)selectedCity{
   
    _dayID = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        _weatherInfoModelArray = [_mcViewModel processWeatherData:tailPath];
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            if(_weatherInfoModelArray){
                [self updateScrollView];
                [self updateWeatherData:_weatherInfoModelArray[_dayID] city:selectedCity];
            }
        });
    });
    
    [self storeTailPath:tailPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"stateCitySegue"]){
        [((StateCityViewController*) segue.destinationViewController) setDelegate:self];
    }
    
}

#pragma Dynamic View

-(void)updateWeatherData:(WeatherInfoModel*)model city:(NSString*)city{
    
    _dayLabel.text = model.dayOfWeek;
    _conditionLabel.text = model.currentTemperature;
    _highTempLabel.text  = model.highTemperature;
    _lowTempLabel.text   = model.lowTemperature;
    if(!model.highTemperature)
        _weatherDescTextView.textColor = [UIColor redColor];
    [_weatherDescTextView setText: model.conditionDescription];
    if(city)
    _cityLabel.text = city;
}

-(void)updateScrollView{
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (WeatherInfoModel *model in _weatherInfoModelArray) {
        NSString *title = model.dayOfWeek;
     [itemArray addObject:title];
    }
    [_buttonGroupScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = _dayID;
    segmentedControl.tintColor = [UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0];
    [_buttonGroupScrollView addSubview:segmentedControl];
    CGFloat newContentOffsetX = (segmentedControl.frame.size.width - _buttonGroupScrollView.frame.size.width) / 2;
    _buttonGroupScrollView.contentOffset = CGPointMake(newContentOffsetX, 0);
    
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    
    _dayID = (int)segment.selectedSegmentIndex;
       if(_weatherInfoModelArray)
           [self updateWeatherData:_weatherInfoModelArray[_dayID] city:nil];
    
}


-(void)storeSelectedStateCity:(NSString*)state city:(NSString*)city{
    
    // Store it
    NSMutableArray *storeArray =[[NSMutableArray alloc]init];
    [storeArray addObject:state];
    [storeArray addObject:city];
    [[NSUserDefaults standardUserDefaults] setObject:storeArray forKey:@"selected_state_city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)storeTailPath:(NSString*)path{
    
    [[NSUserDefaults standardUserDefaults] setObject:path forKey:@"selected_path"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSString*) retriveSelectedPath{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"selected_path"];
    
}

-(NSMutableArray*) retriveSelectedStateCity{
    
    return [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"selected_state_city"]];
    
}


@end
