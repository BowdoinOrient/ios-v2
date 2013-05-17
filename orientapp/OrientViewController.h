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
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface OrientViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *menubarView;
@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)homeButtonPressed:(UIButton *)sender;
- (IBAction)loadSection:(UIButton *)sender;
- (IBAction)tweetButton:(id)sender;
- (IBAction)fbButton:(id)sender;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *twAccount;
@property (strong, nonatomic) ACAccount *fbAccount;

@property (strong, nonatomic) NSString *currURL;
@property (strong, nonatomic) NSDate *articleDate;

@property (weak, nonatomic) IBOutlet UIImageView *fbImage;
@property (weak, nonatomic) IBOutlet UIImageView *twImage;
@end
