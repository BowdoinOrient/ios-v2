//
//  OrientViewController.h
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Modified by Brian Jacobel and Quinn Cohane 
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrientSplashViewController.h"

@interface OrientViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *menubarView;
@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)homeButtonPressed:(UIButton *)sender;
- (IBAction)loadSection:(UIButton *)sender;
- (IBAction)tweetButton:(id)sender;





@end
