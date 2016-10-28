//
//  WCSBubble.m
//  WCSBubbleView
//
//  Created by Aaron C. Wright on 10/12/15.
//  Copyright © 2015 Wrights Creative Services, L.L.C. All rights reserved.
//
//  aaron@Wrightscs.com
//  http://www.wrightscs.com | http://www.wrightscsapps.com
//

#import "WCSBubble.h"

@interface WCSBubble ()
@property (nonatomic, strong) UILabel * valueLabel, * titleLabel, * detailLabel;
@end

@implementation WCSBubble

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.layer.cornerRadius = (frame.size.width/2);
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2-15, frame.size.width, 30.0f)];
        _valueLabel.textColor = _textColor;
        _valueLabel.font = kLabelFont(30);
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_valueLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_valueLabel.frame.origin.x, _valueLabel.frame.origin.y-15, _valueLabel.frame.size.width, 20.0f)];
        _titleLabel.textColor = _textColor;
        _titleLabel.font = kLabelFont(15);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(_valueLabel.frame.origin.x, _valueLabel.frame.origin.y+25, _valueLabel.frame.size.width, 20.0f)];
        _detailLabel.textColor = _textColor;
        _detailLabel.font = kLabelFont(10);
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_detailLabel];
    }
    return self;
}

- (void)setBubbleAlpha:(CGFloat)bubbleAlpha {
    CGFloat h,s,b,a; [self.backgroundColor getHue:&h saturation:&s brightness:&b alpha:&a];
    self.backgroundColor = [UIColor colorWithHue:h saturation:s brightness:b alpha:bubbleAlpha];
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    self.backgroundColor = bubbleColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _titleLabel.textColor = textColor;
    _detailLabel.textColor = textColor;
    _valueLabel.textColor = textColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _detailLabel.text = detail;
}
- (void)setValue:(NSString *)value {
    _value = value;
    _valueLabel.text = value;
}

@end
