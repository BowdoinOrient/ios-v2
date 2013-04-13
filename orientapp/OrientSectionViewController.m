//
//  OrientSectionViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 4/13/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientSectionViewController.h"

@interface OrientSectionViewController ()

@end

@implementation OrientSectionViewController

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
    
    [self.sectionView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self.sectionView action:@selector(swipe:)]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
