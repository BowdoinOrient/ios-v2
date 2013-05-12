//
//  OrientViewController.h
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrientSplashViewController.h"

@interface OrientViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate>


@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)homeButtonPressed:(UIButton *)sender;
- (IBAction)loadSection:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *menubarView;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;

@end
