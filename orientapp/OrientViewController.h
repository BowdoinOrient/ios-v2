//
//  OrientViewController.h
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrientWebView.h"
#import "OrientMenubarView.h"
#import <UIKit/UIKit.h>

@interface OrientViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
        IBOutlet UIWebView *webView;
}


@property (strong, nonatomic) IBOutlet OrientWebView *webView;

- (IBAction)homeButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
@property (strong, nonatomic) IBOutlet UIButton *sectionButton;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;

@property (strong, nonatomic) IBOutlet OrientMenubarView *bottomMenu;
@property BOOL isMenubarHidden;
@end
