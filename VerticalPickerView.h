//
//  VerticalPickerView.h
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalScrollView.h"

@protocol VerticalPickerViewDelegate;
@interface VerticalPickerView : UIView<UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) VerticalScrollView *scrollView;
@property (nonatomic, retain) id<VerticalPickerViewDelegate> delegate;
@property (nonatomic) NSInteger selectedItem;

- (void) selectItemAtIndex:(NSInteger)index;
@end

@protocol VerticalPickerViewDelegate <NSObject>

- (void)selectedRow:(NSInteger)row inView:(VerticalPickerView *)verticalPickerView;

@end
