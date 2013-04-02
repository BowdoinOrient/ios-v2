//
//  OrientViewController.h
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrientWebView.h"

@interface OrientViewController : UIViewController

- (IBAction)homeButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet OrientWebView *webview;


@end
