//
//  VerticalScrollView.m
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import "VerticalScrollView.h"
#import "QuartzCore/QuartzCore.h"
#import "CoreText/CoreText.h"

// number of items can use the whole height of the picker view.
#define numberOfItemsInView 6

@interface VerticalScrollView() {
    CGSize valueViewSize;
}

@property (nonatomic) NSInteger layerVerticalPadding;
@end

@implementation VerticalScrollView
@synthesize dataArray = _dataArray;
@synthesize layerVerticalPadding = _layerVerticalPadding;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = NO;
        self.bounces = YES;
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
        self.backgroundColor = [UIColor clearColor];
        [self setScrollEnabled:YES];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];

        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"picker_bg_pattern"]];
        valueViewSize =  CGSizeMake(self.frame.size.width, self.frame.size.height /numberOfItemsInView);
        _layerVerticalPadding = 5; // padding for catextlayer to make it look like text to be centered.
    }
    return self;
}

- (void)layoutSubviews {

    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    NSInteger value = self.contentOffset.y / valueViewSize.height;
    CGRect frame = CGRectZero;
    for (int i = 0 ; i <= numberOfItemsInView; i++) {
        if (value + i < [_dataArray count]) {

            // IMPORTANT NOTE: CATextLayer won't give an option to draw a layer in vertically aligned.. So you need to specify the correct y position according to your need of text position

            //            _layerVerticalPadding = (i == 3) ? 2 : 5;
            _layerVerticalPadding = 5;
            frame = CGRectMake(0, (value + i) * valueViewSize.height + _layerVerticalPadding, valueViewSize.width, valueViewSize.height);

            @autoreleasepool {
                CATextLayer *_textLayer = [CATextLayer layer];
                _textLayer.frame = frame;
                //                [_textLayer setValue:[NSNumber numberWithInt:i] forKey:@"tag"];
                //                CFTypeRef font = (i == 3) ? CGFontCreateWithFontName((CFStringRef)@"HelveticaNeue-Bold") :CGFontCreateWithFontName((CFStringRef)@"HelveticaNeue");
                CFTypeRef font = CGFontCreateWithFontName((CFStringRef)@"HelveticaNeue");
                _textLayer.font = font;
                //                _textLayer.fontSize = (i == 3) ? 25 : 20;
                _textLayer.fontSize = 20;
                _textLayer.backgroundColor = [UIColor clearColor].CGColor;
                _textLayer.foregroundColor = [UIColor blackColor].CGColor;
                _textLayer.wrapped = YES;
                _textLayer.contentsScale = [UIScreen mainScreen].scale;
                _textLayer.alignmentMode = kCAAlignmentCenter;
                _textLayer.string = [NSString stringWithFormat:@"%@",[_dataArray objectAtIndex:value + i]];
                [self.layer addSublayer:_textLayer];
            }
        }
    }
}
@end
