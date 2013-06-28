//
//  PickerViewController.h
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPickerView.h"

@interface PickerViewController : UIViewController<DPickerViewDelegate, DPickerViewDataSource>

@property (nonatomic, retain) DPickerView *pickerView;

@end
