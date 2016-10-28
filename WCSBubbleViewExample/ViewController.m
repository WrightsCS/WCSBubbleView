//
//  ViewController.m
//  WCSBubbleViewExample
//
//  Created by Aaron C. Wright on 10/12/15.
//  Copyright © 2015 Wrights Creative Services, L.L.C. All rights reserved.
//
//  aaron@Wrightscs.com
//  http://www.wrightscs.com | http://www.wrightscsapps.com
//

#import "ViewController.h"
#import "WCSBubbleView.h"

@interface ViewController () <WCSBubbleViewDelegate>
@property (nonatomic, strong) IBOutlet WCSBubbleView * bubbleView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIColor * bgColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0];
    //UIColor * lowColor = [UIColor colorWithRed:62/255.f green:133/255.f blue:240/255.f alpha:1.0];
    //UIColor * medColor = [UIColor colorWithRed:213/255.f green:97/255.f blue:78/255.f alpha:1.0];
    //UIColor * hghColor = [UIColor colorWithRed:55/255.f green:172/255.f blue:75/255.f alpha:1.0];
    
    //_bubbleView = [[WCSBubbleView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    //_bubbleView.center = self.view.center;
    //_bubbleView.backgroundColor = bgColor;
    //[self.view addSubview:_bubbleView];
    
    _bubbleView.showOverview = YES;
    _bubbleView.textColor = [UIColor whiteColor];
    // Low Value
    _bubbleView.low = [self randomValue];
    _bubbleView.lowTitle = @"LOW";
    _bubbleView.lowDetail = @"Low Detail";
    _bubbleView.lowValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.low];
    _bubbleView.lowColor = [self randomColor];
    // Medium Value
    _bubbleView.medium = [self randomValue];
    _bubbleView.mediumTitle = @"MEDIUM";
    _bubbleView.mediumDetail = @"Medium Detail";
    _bubbleView.mediumValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.medium];
    _bubbleView.mediumColor = [self randomColor];
    // High Value
    _bubbleView.high = [self randomValue];
    _bubbleView.highTitle = @"HIGH";
    _bubbleView.highDetail = @"High Detail";
    _bubbleView.highValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.high];
    _bubbleView.highColor = [self randomColor];
    // Reload Bubbles
    [_bubbleView reloadBubbles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (UIColor*)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (float)randomValue {
    return arc4random_uniform(100);
}

- (NSString*)randomTitle {
    NSArray * titles = @[ @"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE" ];
    return titles[arc4random_uniform((uint32_t)titles.count)];
}

- (NSString*)randomDetail {
    NSArray * details = @[ @"ONE Detail", @"TWO Detail", @"THREE Detail", @"FOUR Detail", @"FIVE Detail" ];
    return details[arc4random_uniform((uint32_t)details.count)];
}

#pragma mark IBActions

- (IBAction)generateRandomColors:(id)sender {
    _bubbleView.lowColor = [self randomColor];
    _bubbleView.mediumColor = [self randomColor];
    _bubbleView.highColor = [self randomColor];
    [_bubbleView reloadBubbles];
}

- (IBAction)generateRandomValues:(id)sender {
    _bubbleView.low = [self randomValue];
    _bubbleView.lowValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.low];
    
    _bubbleView.medium = [self randomValue];
    _bubbleView.mediumValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.medium];
    
    _bubbleView.high = [self randomValue];
    _bubbleView.highValue = [NSString stringWithFormat:@"%.f%%", _bubbleView.high];
    
    [_bubbleView reloadBubbles];
}

- (IBAction)generateRandomTitles:(id)sender {
    _bubbleView.lowTitle = [self randomTitle];
    _bubbleView.mediumTitle = [self randomTitle];
    _bubbleView.highTitle = [self randomTitle];
    [_bubbleView reloadBubbles];
}

- (IBAction)generateRandomDetails:(id)sender {
    _bubbleView.lowDetail = [self randomDetail];
    _bubbleView.mediumDetail = [self randomDetail];
    _bubbleView.highDetail = [self randomDetail];
    [_bubbleView reloadBubbles];
}

#pragma mark - WCSBubbleViewDelegate

- (void)didSelectBubbleView:(WCSBubble *)bubble {
    NSLog(@"User Selected Bubble: %@", bubble.title);
}

@end
