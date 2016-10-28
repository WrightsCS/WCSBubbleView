//
//  WCSBubbleView.h
//  WCSBubbleView
//
//  Created by Aaron C. Wright on 10/12/15.
//  Copyright © 2015 Wrights Creative Services, L.L.C. All rights reserved.
//
//  aaron@Wrightscs.com
//  http://www.wrightscs.com | http://www.wrightscsapps.com
//

#import <UIKit/UIKit.h>
#import "WCSBubble.h"

@class WCSBubble;

@protocol WCSBubbleViewDelegate <NSObject>
@optional
- (void)didSelectBubbleView:(WCSBubble*)bubble;
@end

@interface WCSBubbleView : UIView
@property (nonatomic, weak) id<WCSBubbleViewDelegate> delegate;
@property (nonatomic, setter=setShowOverview:) BOOL showOverview;
@property (nonatomic, assign) CGFloat low, medium, high;
@property (nonatomic, strong) UIColor * lowColor, * mediumColor, * highColor, * textColor;
@property (nonatomic, strong) NSString * lowTitle, * lowDetail, * lowValue;
@property (nonatomic, strong) NSString * mediumTitle, * mediumDetail, * mediumValue;
@property (nonatomic, strong) NSString * highTitle, * highDetail, * highValue;
- (void)reloadBubbles;
@end
