//
//  VerticalPickerView.m
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import "VerticalPickerView.h"
#import "QuartzCore/QuartzCore.h"

// number of items can use the whole height of the picker view.
#define numberOfItemsInView 6

// number of empty views added before and after the scrollview as contentInset to make a bounce and select the first and last item in the picker view.
#define numberOfEmptyView 3

@interface VerticalPickerView () {
    BOOL reallyNeedsLayout;
    CGSize valueViewSize;
}

@end
@implementation VerticalPickerView
@synthesize dataArray = _dataArray;
@synthesize scrollView = _scrollView;
@synthesize selectedItem = _selectedItem;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _dataArray = [NSMutableArray array];
    _scrollView = nil;
    _selectedItem = 0;
    reallyNeedsLayout = YES;
    valueViewSize =  CGSizeMake(self.frame.size.width, self.frame.size.height /numberOfItemsInView);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (reallyNeedsLayout) {
        reallyNeedsLayout = NO;

        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }

        VerticalScrollView *scroll = [[VerticalScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [scroll setScrollEnabled:YES];
        scroll.dataArray = _dataArray;

        [scroll setContentSize:CGSizeMake(self.frame.size.width, [_dataArray count] * self.frame.size.height/numberOfItemsInView)];
        [scroll setOpaque:NO];
        [scroll setDelegate:self];
        [scroll setContentInset:UIEdgeInsetsMake((numberOfEmptyView * valueViewSize.height)  - (valueViewSize.height / 2), 0, (numberOfEmptyView * valueViewSize.height)  - (valueViewSize.height / 2), 0)];
        _scrollView = scroll;
        [self addSubview:_scrollView];

        [self selectItemAtIndex:_selectedItem];
    }
}

- (void)setSelectedItem:(NSInteger)selectedItem {
    if (_selectedItem != selectedItem) {
        _selectedItem = selectedItem;
    }
    //    [self highlightTheSelectedRowWithScrollView:self.scrollView];
    [self.delegate selectedRow:_selectedItem inView:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.selectedItem = [VerticalPickerView scrollViewPositionChanged:scrollView];
}

+ (NSInteger)scrollViewPositionChanged:(UIScrollView *)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;

    double yOffset = scrollViewOffset.y;

    double itemHeight = scrollView.frame.size.height/numberOfItemsInView;
    int yInt = yOffset/(itemHeight/2);
    double yDouble = yOffset/ (itemHeight/2);

    NSInteger value = round(yOffset / itemHeight);

    if (yOffset < -((numberOfEmptyView - 1) * itemHeight)) {
        scrollViewOffset.y = - ((numberOfEmptyView * itemHeight) - (itemHeight / 2));
    }else {
        if ((yDouble - yInt) <= 0.5) {
            scrollViewOffset.y = value * itemHeight - (itemHeight / 2);
        }else {
            scrollViewOffset.y = value * itemHeight + (itemHeight / 2);
        }
    }

    double roundedValue = round(scrollViewOffset.y / itemHeight) + (numberOfEmptyView - 1);
    [scrollView setContentOffset:scrollViewOffset animated:YES];
    return (roundedValue < 0) ? 0 : roundedValue;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.selectedItem = [VerticalPickerView scrollViewPositionChanged:scrollView];
    }
}

- (void)selectItemAtIndex:(NSInteger)index {
    double itemHeight = valueViewSize.height;
    CGFloat yOffset = round((index * itemHeight) - ((numberOfEmptyView * itemHeight) - (itemHeight / 2)));
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.origin.x, yOffset) animated:NO];
    if (_selectedItem != index) {
        self.selectedItem = index;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Here we need to prevent UIScrollView's scrolling in horizontal direction.
    CGPoint offset = scrollView.contentOffset;
    if (offset.x != 0) {
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    [scrollView.layer performSelector:@selector(setNeedsDisplay) withObject:nil];
    [scrollView.layer performSelector:@selector(displayIfNeeded) withObject:nil];
}

/*
 - (void)highlightTheSelectedRowWithScrollView:(UIScrollView *)scrollView {
 for (CATextLayer *_textLayer in scrollView.layer.sublayers) {
 if ([[_textLayer valueForKey:@"tag"] integerValue] == 3) {
 CFTypeRef font = CGFontCreateWithFontName((CFStringRef)@"HelveticaNeue-Bold");
 _textLayer.font = font;
 _textLayer.fontSize = 25;
 break;
 }
 }
 }
 */
@end
