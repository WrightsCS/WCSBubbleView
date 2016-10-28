//
//  WCSBubble.h
//  WCSBubbleView
//
//  Created by Aaron C. Wright on 10/12/15.
//  Copyright © 2015 Wrights Creative Services, L.L.C. All rights reserved.
//
//  aaron@Wrightscs.com
//  http://www.wrightscs.com | http://www.wrightscsapps.com
//

#import <UIKit/UIKit.h>

#define kLabelFont(S)   [UIFont fontWithName:@"HelveticaNeue-Light" size:S]

@interface WCSBubble : UIView
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) CGFloat bubbleAlpha;
@property (nonatomic, strong) UIColor * bubbleColor;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * detail;
@property (nonatomic, strong) NSString * value;
@end
