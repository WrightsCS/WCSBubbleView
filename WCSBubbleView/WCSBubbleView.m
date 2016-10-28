//
//  WCSBubbleView.m
//  WCSBubbleView
//
//  Created by Aaron C. Wright on 10/12/15.
//  Copyright © 2015 Wrights Creative Services, L.L.C. All rights reserved.
//
//  aaron@Wrightscs.com
//  http://www.wrightscs.com | http://www.wrightscsapps.com
//

#import "WCSBubble.h"
#import "WCSBubbleView.h"

float LOW_PERCENTAGE = 30;
float MED_PERCENTAGE = 20;
float HGH_PERCENTAGE = 50;

@interface WCSBubbleView ()
@property (nonatomic, strong) WCSBubble * bubbleLow, * bubbleMedium, * bubbleHigh;
@property (nonatomic, strong) UILabel * labelOverview;
@property (nonatomic, assign) CGFloat max, min, screenWidth, screenHeight;
@property (nonatomic, assign) UIColor * colorHigh, * colorMedium, * colorLow;
@end

@implementation WCSBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupView];
}

#pragma mark - Setup Views

- (void)setupView
{
    _screenWidth = self.frame.size.width;
    _screenHeight = self.frame.size.height;
    
    _min = 100;
    _max = _screenWidth/2;
    
    //self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer* resetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetActiveBubbles:)];
    resetTap.numberOfTapsRequired = 1;
    resetTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:resetTap];
}

- (void)setShowOverview:(BOOL)showOverview
{
    _showOverview = showOverview;
    if ( showOverview ) {
        _labelOverview = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        _labelOverview.font = kLabelFont(32);
        _labelOverview.backgroundColor = [UIColor clearColor];
        _labelOverview.textAlignment = NSTextAlignmentCenter;
        _labelOverview.adjustsFontSizeToFitWidth = YES;
        _labelOverview.minimumScaleFactor = .5f;
        _labelOverview.numberOfLines = 3;
        _labelOverview.text = @"Select a bubble.";
        [self addSubview:_labelOverview];
    }
    else
        [_labelOverview removeFromSuperview];
}

- (void)reloadBubbles
{
    BOOL _createBubble = YES;
    
    if ( _createBubble )
    {
        _low = ( isnan(_low) ? 0 : _low );
        
        if ( _bubbleLow ) [_bubbleLow removeFromSuperview];
        
        float radius = ( (_max - _min) * (_low/100) + _min ) / 2;
        CGFloat x = (_screenWidth/2) - radius;
        CGFloat y = x;
        
        _bubbleLow = [[WCSBubble alloc] initWithFrame:CGRectMake(x, y, radius*2, radius*2)];
        _bubbleLow.tag = 101;
        _bubbleLow.bubbleColor = _lowColor;
        _bubbleLow.textColor = _textColor;
        _bubbleLow.title = _lowTitle;
        _bubbleLow.detail = _lowDetail;
        _bubbleLow.value = _lowValue;
        [self addSubview:_bubbleLow];
        
        [self addTapGestureToView:_bubbleLow];
    }
    if ( _createBubble )
    {
        _medium = ( isnan(_medium) ? 0 : _medium );
        
        if ( _bubbleMedium ) [_bubbleMedium removeFromSuperview];
        
        float radius = ( (_max - _min) * (_medium/100) + _min) / 2;
        CGFloat x = ((_screenWidth/2) - radius) - (radius - (radius/4));
        CGFloat y = ((_screenWidth/2) - radius) - radius;
        
        _bubbleMedium = [[WCSBubble alloc] initWithFrame:CGRectMake(x, y, radius*2, radius*2)];
        _bubbleMedium.tag = 102;
        _bubbleMedium.bubbleColor = _mediumColor;
        _bubbleMedium.textColor = _textColor;
        _bubbleMedium.title = _mediumTitle;
        _bubbleMedium.detail = _mediumDetail;
        _bubbleMedium.value = _mediumValue;
        [self addSubview:_bubbleMedium];
        
        [self addTapGestureToView:_bubbleMedium];
    }
    if ( _createBubble )
    {
        _high = ( isnan(_high) ? 0 : _high );
        
        if ( _bubbleHigh ) [_bubbleHigh removeFromSuperview];
        
        float radius = ( (_max - _min) * (_high/100) + _min ) / 2;
        CGFloat x = ((_screenWidth/2) - radius) + (radius - (radius/4));
        CGFloat y = ((_screenWidth/2) - radius) - radius;
        
        _bubbleHigh = [[WCSBubble alloc] initWithFrame:CGRectMake(x, y, radius*2, radius*2)];
        _bubbleHigh.tag = 103;
        _bubbleHigh.bubbleColor = _highColor;
        _bubbleHigh.textColor = _textColor;
        _bubbleHigh.title = _highTitle;
        _bubbleHigh.detail = _highDetail;
        _bubbleHigh.value = _highValue;
        [self addSubview:_bubbleHigh];
        
        [self addTapGestureToView:_bubbleHigh];
    }
    
    [self arrangeBubbles];
}

- (void)arrangeBubbles
{
    if ( (_low > _medium && _low > _high) || _bubbleLow.isActive )
    {
        _bubbleLow.bubbleAlpha = 1;
        _bubbleMedium.bubbleAlpha = .5;
        _bubbleHigh.bubbleAlpha = .5;
        
        if ( _bubbleLow.isActive )
            [self bringSubviewToFront:_bubbleLow];
        else
            [self sendSubviewToBack:_bubbleLow];
    }
    
    else if ( (_medium > _low && _medium > _high) || _bubbleMedium.isActive )
    {
        _bubbleLow.bubbleAlpha = .5;
        _bubbleMedium.bubbleAlpha = 1;
        _bubbleHigh.bubbleAlpha = .5;
        
        if ( _bubbleMedium.isActive )
            [self bringSubviewToFront:_bubbleMedium];
        else
            [self sendSubviewToBack:_bubbleMedium];
    }
    
    else if ( (_high > _low && _high > _medium) || _bubbleHigh.isActive )
    {
        _bubbleLow.bubbleAlpha = .5;
        _bubbleMedium.bubbleAlpha = .5;
        _bubbleHigh.bubbleAlpha = 1;
        
        if ( _bubbleHigh.isActive )
            [self bringSubviewToFront:_bubbleHigh];
        else
            [self sendSubviewToBack:_bubbleHigh];
    }
}

#pragma mark - Private Methods

- (void)addTapGestureToView:(UIView*)view
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bringBubbleToFront:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:singleTap];
}

- (void)bringBubbleToFront:(UITapGestureRecognizer*)recognizer
{
    WCSBubble * bubbleView = (WCSBubble*)recognizer.view;
    if ( [bubbleView isEqual:_bubbleLow] ) {
        _bubbleLow.isActive = YES;
        _bubbleMedium.isActive = NO;
        _bubbleHigh.isActive = NO;
        bubbleView = _bubbleLow;
    }
    if ( [bubbleView isEqual:_bubbleMedium] ) {
        _bubbleLow.isActive = NO;
        _bubbleMedium.isActive = YES;
        _bubbleHigh.isActive = NO;
        bubbleView = _bubbleMedium;
    }
    if ( [bubbleView isEqual:_bubbleHigh] ) {
        _bubbleLow.isActive = NO;
        _bubbleMedium.isActive = NO;
        _bubbleHigh.isActive = YES;
        bubbleView = _bubbleHigh;
    }
    
    NSLog(@"selected bubble: %@", bubbleView.title);
    
    if ( _showOverview ) {
        _labelOverview.text = [NSString stringWithFormat:@"Selected %@ Bubble", bubbleView.title];
    }
    
    if ( [self.delegate respondsToSelector:@selector(didSelectBubbleView:)] )
         [self.delegate didSelectBubbleView:bubbleView];
    
    [self arrangeBubbles];
}

- (void)resetActiveBubbles:(UITapGestureRecognizer*)recognizer
{
    _bubbleLow.isActive = NO;
    _bubbleMedium.isActive = NO;
    _bubbleHigh.isActive = NO;
    
    if ( _showOverview ) {
        _labelOverview.text = nil;
    }
    
    [self arrangeBubbles];
}

@end
