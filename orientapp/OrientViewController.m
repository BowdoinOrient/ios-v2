//
//  OrientViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientViewController.h"

@implementation OrientViewController

@synthesize webView = _webView;
@synthesize sectionLabel = _sectionLabel;


// Loads the Orient homepage 
- (void) viewDidLoad {
    [super viewDidLoad];
    NSString *fullURL = @"http://www.bowdoinorient.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
    [self.sectionLabel setFont:[UIFont fontWithName:@"Minion Pro Med" size:8]];

}

- (IBAction)homeButtonPressed:(UIButton *)sender {
    NSString *fullURL = @"http://www.bowdoinorient.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

@end
