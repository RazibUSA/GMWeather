//
//  StateCityViewController.h
//  GMWeather
//
//  Created by Razib Mollick on 6/30/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateCityViewModel.h"
@protocol StateCityUpdater
@required
-(void)updateWeatherView:(NSString*)tailPath city:(NSString*)selectedCity;
@optional
// list of optional methods
@end

@interface StateCityViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

- (IBAction)cancelSelectionView:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;


@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;

@property (strong, nonatomic)  StateCityViewModel *scViewModel;


- (IBAction)doneButtonClicked:(id)sender;

- (void) setDelegate:(id)newDelegate;

@end
