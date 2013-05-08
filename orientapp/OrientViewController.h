//
//  OrientViewController.h
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrientMenubarView.h"
#import <UIKit/UIKit.h>

@interface OrientViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
        IBOutlet UIWebView *webView;
        IBOutlet UIScrollView *sectionScrollView;
        IBOutlet UIActivityIndicatorView *activityIndicator;
}


@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)homeButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
@property (strong, nonatomic) IBOutlet UIButton *sectionButton;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet OrientMenubarView *bottomMenu;
@property BOOL isMenubarHidden;
@end
