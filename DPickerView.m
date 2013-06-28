//
//  DPickerView.m
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import "DPickerView.h"

@interface DPickerView () {
    // reallyNeedsLayout is needed because of layoutSubviews called unwantedly (If added any subviews to the scrollview) in lower versions of iOS
    BOOL reallyNeedsLayout;
}

@property (nonatomic, retain) NSMutableArray *widthOfComponents;
@property (nonatomic, retain) NSMutableDictionary *dataForComponents;

@property (nonatomic, retain) NSMutableDictionary *selectedRows;
@end

@implementation DPickerView
@synthesize numberOfComponents = _numberOfComponents;
@synthesize delegate = _delegate;
@synthesize datasource = _datasource;
@synthesize widthOfComponents = _widthOfComponents;
@synthesize dataForComponents = _dataForComponents;

@synthesize selectedRows = _selectedRows;

- (id)initWithFrame:(CGRect)frame
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, 320, 216); // Changing the frame size would lead to problem. Will give support to change it in future commits.
    self = [super initWithFrame:newFrame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 216); // Changing the frame size would lead to problem. Will give support to change it in future commits.
        self.frame = newFrame;
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _numberOfComponents = 1;
    _widthOfComponents = [NSMutableArray array];
    _dataForComponents = [NSMutableDictionary dictionary];
    reallyNeedsLayout = YES;

    _selectedRows = [NSMutableDictionary dictionary];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (reallyNeedsLayout) {
        reallyNeedsLayout = NO;

        //        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"picker_bg_pattern"]];
        for (UIView *view in self.subviews) {
            [self removeFromSuperview];
        }

        if ([self.datasource respondsToSelector:@selector(numberOfComponentsInCustomPickerView:)]) {
            _numberOfComponents = [self.datasource numberOfComponentsInCustomPickerView:self];
        }

        for (int i = 0; i < _numberOfComponents; i++) {
            if ([self.delegate respondsToSelector:@selector(titleArrayForCustomPickerView:forComponent:)]) {
                [_dataForComponents setObject:[self.delegate titleArrayForCustomPickerView:self forComponent:i] forKey:[NSNumber numberWithInt:i]];
            }
        }

        for (int i = 0; i < _numberOfComponents; i++) {
            if ([self.delegate respondsToSelector:@selector(customPickerView:widthForComponent:)]) {
                [_widthOfComponents addObject:[NSNumber numberWithFloat:[self.delegate customPickerView:self widthForComponent:i]]];
            }
        }

        // set Width for each pickers
        CGRect selfRect = self.frame;
        double totalComponentsWidth =  selfRect.size.width;
        CGRect frame = CGRectMake(0, 0, 0, selfRect.size.height);
        for (int i = 0; i < _numberOfComponents; i ++) {
            frame.size.width = (![_widthOfComponents count]) ? (totalComponentsWidth / _numberOfComponents) : [[_widthOfComponents objectAtIndex:i] floatValue] ;

            VerticalPickerView *vPickerView = [[VerticalPickerView alloc]initWithFrame:frame];
            vPickerView.tag = i;
            vPickerView.delegate = self;
            vPickerView.dataArray = [_dataForComponents objectForKey:[NSNumber numberWithInt:i]];
            [self addSubview:vPickerView];

            if([_selectedRows objectForKey:[NSNumber numberWithInt:i]]) {
                [self customPickerSelectRow:[[_selectedRows objectForKey:[NSNumber numberWithInt:i]] integerValue] inComponent:i];
            }else if([vPickerView.dataArray count]) {
                [_selectedRows setObject:[NSNumber numberWithInteger:0] forKey:[NSNumber numberWithInteger:i]];
                [vPickerView selectItemAtIndex:0];
            }


            if (_numberOfComponents > i) {
                frame.origin.x += frame.size.width;
            }
        }
        UIImageView *selectionIndicatorImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - 42) / 2, self.frame.size.width, 39)];
        [selectionIndicatorImage setImage:[UIImage imageNamed:@"selector"]];
        [self addSubview:selectionIndicatorImage];

        UIImageView *upperShadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"upper_shadow"] ];
        [upperShadowImageView setFrame:CGRectMake(0, 0, self.frame.size.width, 18)];
        [self addSubview:upperShadowImageView];

        UIImageView *lowerShadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lower_shadow"] ];
        [lowerShadowImageView setFrame:CGRectMake(0, self.frame.size.height - 18, self.frame.size.width, 18)];
        [self addSubview:lowerShadowImageView];
    }
}

- (void)selectedRow:(NSInteger)row inView:(VerticalPickerView *)verticalPickerView {
    NSMutableArray *dataArray = [_dataForComponents objectForKey:[NSNumber numberWithInteger:verticalPickerView.tag]];
    // This check will prevent the crash from contentoffset reaches the outside of the count in the array.
    if (row < [dataArray count]) {
        [self.delegate customPickerView:self didSelectRow:row inComponent:verticalPickerView.tag];
        [_selectedRows setObject:[NSNumber numberWithInt:row] forKey:[NSNumber numberWithInt:verticalPickerView.tag]];
    }
}

- (NSInteger)customPickerSelectedRowInComponent:(NSInteger)component {
    return [[_selectedRows objectForKey:[NSNumber numberWithInt:component]] integerValue];
}

- (void)customPickerSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_selectedRows setObject:[NSNumber numberWithInt:row] forKey:[NSNumber numberWithInt:component]];

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[VerticalPickerView class]]) {
            if ([view tag] == component) {
                [(VerticalPickerView *)view selectItemAtIndex:row];
            }
        }
    }
}

@end
