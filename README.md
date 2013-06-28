#DPickerView

This project was inspired by Apple's default `UIPickerView` component. Using `DPickerView`, you can easily 
customize the pickerView as you wanted. DPickerView has all the basic features from UIPickerView.

##Features

 * Customize the User Interface Design (Background, Selector, Fonts)
 * iOS 7 flat UI look
 * Change the width of component (PickerView column)
 * Supports all versions after 4.3
 * ARC Enabled.<br />

======
![DPickerView Screenshot](https://raw.github.com/dineshraja1990/DPickerView/master/DPickerView/Screenshot.png)
 

##Installation

Add the `Classes` folder to your project. Add QuartzCore framework to your project. DPickerView uses ARC. 
If you have a project that doesn't use ARC, just add the `-fobjc-arc` compiler flag to the DPickerView files.

##Usage

###Basic Setup

In your viewController file:<br />

```objectivec
#import "DPickerView.h"

DPickerView *_pickerView = [[DPickerView alloc]initWithFrame:CGRectMake(0, 150, 320, 216)];
_pickerView.delegate = self;
_pickerView.datasource = self;
[self.view addSubview:_pickerView];
```

###Delegates and Datasource methods

 * Specify the datasource for number of columns in DPickerView
 * Datasource methods to get the method call when the item selected.

```objectivec

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
```

##Contact

Please forward your queries to me<br />
dina.raja.s@gmail.com

Fork and contribute to this project if you can. Thank you.
