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

- (IBAction)homeButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
@property (strong, nonatomic) IBOutlet UIButton *sectionButton;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
- (IBAction)loadSection:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *loadButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) IBOutlet OrientSplashViewController* modal;

@end
