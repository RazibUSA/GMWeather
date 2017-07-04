//
//  StateCityViewController.m
//  GMWeather
//
//  Created by Razib Mollick on 6/30/17.
//  Copyright © 2017 Razib Mollick. All rights reserved.
//

#import "StateCityViewController.h"


@interface StateCityViewController (){
    NSMutableArray *stateNames;
    NSMutableArray *cityNames;
    id delegate;
}

@end

@implementation StateCityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _scViewModel = [[StateCityViewModel alloc] init];
    
    stateNames = [NSMutableArray arrayWithArray:[_scViewModel getStateNames:@"US"]];
    cityNames = [NSMutableArray arrayWithArray:[_scViewModel getCityNames:stateNames[0]]];
    
    // Connect data to picker
    self.statePicker.dataSource = self;
    self.statePicker.delegate = self;
    
    // Connect data to picker
    self.cityPicker.dataSource = self;
    self.cityPicker.delegate = self;
    
    [self updatePickerView];
}

- (void) setDelegate:(id)newDelegate{
    delegate = newDelegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelSelectionView:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)doneButtonClicked:(id)sender {
    
    NSString *stateValue = [stateNames objectAtIndex:[_statePicker selectedRowInComponent:0]];
    NSLog(@"state Val:%@", stateValue);
    NSString *cityValue = [cityNames objectAtIndex:[_cityPicker selectedRowInComponent:0]];
    NSLog (@"cite:%@", cityValue);
    NSString *urlPath = [_scViewModel setUserSelection:stateValue city:cityValue];
    
    [self storeSelectedStateCity:stateValue city:cityValue];
    
    if(delegate){
        [delegate updateWeatherView:urlPath city:cityValue];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma Manage Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView tag] == 1)
        return [stateNames count];
    else
        return [cityNames count];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if([pickerView tag] == 1){
        
        return [stateNames objectAtIndex:row];
    }
    else{
        return [cityNames objectAtIndex:row];
    }
    
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *attString = nil;
    if([pickerView tag] == 1){
        attString =
        [[NSAttributedString alloc] initWithString:[stateNames objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]}];
    }
    
    else{
       attString  =
        [[NSAttributedString alloc] initWithString:[cityNames objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.00 green:1.00 blue:0.00 alpha:1.0]}];
    }
    return attString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView tag] == 1)
    {
        NSString *stateName = [stateNames objectAtIndex:row];
        
        cityNames = [NSMutableArray arrayWithArray:[_scViewModel getCityNames:stateName]];
        [_cityPicker reloadAllComponents];
    }
    
}
    



-(void)updatePickerView{
    
    NSMutableArray *stateCityInfo =[self retriveSelectedStateCity];
    
    if(stateCityInfo){
        NSUInteger sIndex = [stateNames indexOfObject:stateCityInfo[0]];
        
        cityNames = [NSMutableArray arrayWithArray:[_scViewModel getCityNames:stateCityInfo[0]]];
        NSUInteger cIndex = [cityNames indexOfObject:stateCityInfo[1]];
        if(sIndex && cIndex){
            [_statePicker selectRow:sIndex inComponent:0 animated:YES];
            [_cityPicker selectRow:cIndex inComponent:0 animated:YES];
        }
        
    }
    
}


-(void)storeSelectedStateCity:(NSString*)state city:(NSString*)city{
    // Store it
    NSMutableArray *storeArray =[[NSMutableArray alloc]init];
    [storeArray addObject:state];
    [storeArray addObject:city];
    [[NSUserDefaults standardUserDefaults] setObject:storeArray forKey:@"selected_state_city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSMutableArray*) retriveSelectedStateCity{
    
    return [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"selected_state_city"]];

}

    @end
