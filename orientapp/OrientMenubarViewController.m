//
//  OrientMenubarViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 4/24/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "OrientMenubarViewController.h"

@interface OrientMenubarViewController ()

@end

@implementation OrientMenubarViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//uses code from http://mobile.tutsplus.com/tutorials/iphone/ios-6-and-the-social-framework-twitter-requests/
- (IBAction)tweetButton:(id)sender {
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0){
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                                message:@"No currently signed-in accounts detected."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                            message:@"We weren't able to access your Twitter account. Sorry :/"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}
@end
