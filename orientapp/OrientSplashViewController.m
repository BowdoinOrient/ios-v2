//
//  OrientSplashViewController.m
//  orientapp
//
//  Created by Quinn Cohane on 5/7/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientSplashViewController.h"

@interface OrientSplashViewController ()

@end

@implementation OrientSplashViewController
@synthesize activityIndicatorView = _activityIndicatorView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityIndicatorView.hidesWhenStopped = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
