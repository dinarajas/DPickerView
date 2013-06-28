//
//  PickerViewController.m
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@property (nonatomic, retain) NSMutableArray *array1;
@property (nonatomic, retain) NSMutableArray *array2;
@property (nonatomic, retain) NSMutableArray *array3;
@property (nonatomic, retain) NSMutableArray *array4;
@property (nonatomic, retain) NSMutableArray *array5;
@end

@implementation PickerViewController
@synthesize pickerView = _pickerView;
@synthesize array1 = _array1;
@synthesize array2 = _array2;
@synthesize array3 = _array3;
@synthesize array4 = _array4;
@synthesize array5 = _array5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Vertical picker view initialization
    self.title = @"DPickerView";

    _pickerView = [[DPickerView alloc]initWithFrame:CGRectMake(0, 150, 320, 216)];
    _pickerView.delegate = self;
    _pickerView.datasource = self;
    [self.view addSubview:_pickerView];

    _array1 = [self getArray1];
    _array2 = [self getArray2];
    _array3 = [self getArray3];
    _array4 = [self getArray1];
    _array5 = [self getArray2];

    [_pickerView customPickerSelectRow:5 inComponent:0];
    [_pickerView customPickerSelectRow:25 inComponent:1];
    [_pickerView customPickerSelectRow:11 inComponent:2];
    [_pickerView customPickerSelectRow:25 inComponent:3];
    [_pickerView customPickerSelectRow:5 inComponent:4];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Custom Picker View Datasource Methods

- (NSInteger)numberOfComponentsInCustomPickerView:(DPickerView *)pickerView {
    return 5;
}

#pragma mark Custom Picker View Delegate Methods

- (NSMutableArray *)titleArrayForCustomPickerView:(DPickerView *)pickerView forComponent:(NSInteger)component {
    if (component == 0) {
        return _array1;
    }else if (component == 1){
        return _array2;
    }else if (component == 2){
        return _array3;
    }else if (component == 3){
        return _array4;
    }else {
        return _array5;
    }
}

- (void)customPickerView:(DPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSLog(@"array1: %d", [[_array1 objectAtIndex:row] integerValue]);
    }if (component == 1) {
        NSLog(@"array2: %d", [[_array2 objectAtIndex:row] integerValue]);
    }else if (component == 2){
        NSLog(@"array3: %d", [[_array3 objectAtIndex:row] integerValue]);
    }else if (component == 3){
        NSLog(@"array4: %d", [[_array4 objectAtIndex:row] integerValue]);
    }else if (component == 4){
        NSLog(@"array5: %d", [[_array5 objectAtIndex:row] integerValue]);
    }
}

- (NSMutableArray *)getArray1 {
    NSMutableArray *array1Values = [NSMutableArray array];
    for (int i = 80; i <= 200; i++) {
        [array1Values addObject:[NSNumber numberWithInt:i]];
    }
    return array1Values;
}

- (NSMutableArray *)getArray2 {
    NSMutableArray *array2Values = [NSMutableArray array];
    for (int i = 70; i <= 140; i++) {
        [array2Values addObject:[NSNumber numberWithInt:i]];
    }
    return array2Values;
}

- (NSMutableArray *)getArray3 {
    NSMutableArray *array3Values = [NSMutableArray array];
    for (int i = 30; i <= 220; i++) {
        [array3Values addObject:[NSNumber numberWithInt:i]];
    }
    return array3Values;
}

@end
