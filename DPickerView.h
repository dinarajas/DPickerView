//
//  DPickerView.h
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalPickerView.h"

@protocol DPickerViewDataSource;
@protocol DPickerViewDelegate;

@interface DPickerView : UIView <VerticalPickerViewDelegate>

@property (nonatomic, readonly) NSInteger numberOfComponents;
@property (nonatomic, retain) id<DPickerViewDelegate> delegate;
@property (nonatomic, retain) id<DPickerViewDataSource> datasource;

- (NSInteger)customPickerSelectedRowInComponent:(NSInteger)component;
- (void)customPickerSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@protocol DPickerViewDataSource<NSObject>
@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInCustomPickerView:(DPickerView *)pickerView;
@end


@protocol DPickerViewDelegate<NSObject>
@optional

// returns width of column for each component.
- (CGFloat)customPickerView:(DPickerView *)pickerView widthForComponent:(NSInteger)component;

// returns the array of NSString objects to show in the picker rows.
- (NSMutableArray *)titleArrayForCustomPickerView:(DPickerView *)pickerView forComponent:(NSInteger)component;

// This method will get called once the user changed the value of a pickerView in any component.
- (void)customPickerView:(DPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end
