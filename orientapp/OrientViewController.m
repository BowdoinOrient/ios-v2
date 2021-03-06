//
//  OrientViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Modified by Brian Jacobel and Quinn Cohane
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientViewController.h"
#import "OrientSectionViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface OrientViewController()
@property (nonatomic) IBOutlet OrientSplashViewController* modal;
@property (nonatomic) int page;
@property (nonatomic) BOOL haveShownModal;
@end

@implementation OrientViewController

@synthesize webView = _webView;
@synthesize page = _page;
@synthesize activityIndicator = _activityIndicator;
@synthesize modal = _modal;
@synthesize haveShownModal = _haveShownModal;
@synthesize currURL;

// Loads the Orient homepage
- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.haveShownModal = NO;
    
    //Prevent the webview from zooming on double tap
    self.webView.scalesPageToFit = NO;
    
    //set the initial article date to today's date
    self.articleDate = [NSDate date];
    
    self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless"];
    NSURL *url = [NSURL URLWithString:self.currURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
    //set the webView delegate
    self.webView.delegate = self;
    
    //sets activityIndicator and its color
    self.activityIndicator.hidden = YES;
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    // section scroll view setup
    self.sectionScrollView.pagingEnabled = YES;
    self.sectionScrollView.delegate = self;
    self.sectionScrollView.backgroundColor = [UIColor whiteColor];
    self.sectionScrollView.alpha = 1;
    
    //set a drop shadow on the topview
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.topView.layer.shadowOpacity = 0.5f;
    
    //set a drop shadow on the menubarview
    self.menubarView.layer.masksToBounds = NO;
    self.menubarView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menubarView.layer.shadowOffset = CGSizeMake(0.0f, -5.0f);
    self.menubarView.layer.shadowOpacity = 0.5f;
    
    //set some subtle shadows on the fb, search and twitter icons
    self.fbImage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.fbImage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.fbImage.layer.shadowOpacity = 0.5f;
    self.twImage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.twImage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.twImage.layer.shadowOpacity = 0.5f;
    self.searchImage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searchImage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.searchImage.layer.shadowOpacity = 0.5f;
    
    //hide the menubarview by default
    self.menubarView.hidden = YES;
    
    //set up gesture recognizer to unhide it with a double tap
    self.webView.userInteractionEnabled = YES;
    UITapGestureRecognizer * doubleTapped =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapped setNumberOfTapsRequired:2];
    doubleTapped.delegate = self;
    [self.view addGestureRecognizer:doubleTapped];

    
    CGFloat xPos = 0;
    //CGFloat yPos = self.sectionScrollView.frame.origin.y;
    CGFloat width = self.sectionScrollView.bounds.size.width;
    CGFloat height = self.sectionScrollView.bounds.size.height;
    int numberOfSections = 6;
    
    //code to handle the scrolling side-to-side action in the SectionView
    for (int i = 0; i < numberOfSections; i++)
    {
        xPos = i * self.sectionScrollView.bounds.size.width;
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, width, height)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel* sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, height)];
        sectionLabel.hidden = NO;
        sectionLabel.textAlignment = NSTextAlignmentCenter;
        sectionLabel.backgroundColor = [UIColor whiteColor];
        sectionLabel.textColor = [UIColor blackColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            [sectionLabel setFont:[UIFont fontWithName:@"Minion Pro" size:21]];
        else
            [sectionLabel setFont:[UIFont fontWithName:@"Minion Pro" size:15]];
        
        switch (i) {
            case 0:
                sectionLabel.text = @"HOME   >";
                break;
            case 1:
                sectionLabel.text = @"<   NEWS   >";
                break;
            case 2:
                sectionLabel.text = @"<   OPINION   >";
                break;
            case 3:
                sectionLabel.text = @"<   FEATURES   >";
                break;
            case 4:
                sectionLabel.text = @"<   A & E   >";
                break;
            case 5:
                sectionLabel.text = @"<   SPORTS";
                break;
                
            default:view.backgroundColor = [UIColor whiteColor];
                break;
        }
        
        view.userInteractionEnabled = YES;
        [view addSubview:sectionLabel];
        
        [self.sectionScrollView addSubview:view];
        
    }
    
    
    self.sectionScrollView.contentSize = CGSizeMake(self.sectionScrollView.frame.size.width * numberOfSections, self.sectionScrollView.frame.size.height);
}


// Dismiss splash from initial load
- (void)viewDidAppear:(BOOL)animated
{
    self.modal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:self.modal animated:NO completion:nil];
    if (!self.haveShownModal)
    {
        [self performSegueWithIdentifier:@"modal" sender:self];
        self.haveShownModal = YES;
    }
}

// start activityIndicator when web page is loading
- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (nil != self.modal)
    {
        [self.modal.activityIndicatorView startAnimating];
    }
    //else
    [self.activityIndicator startAnimating];
}

// stop activityIndicator when web page has finished loading
// also inject some JS into the page to make it zoomable
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (nil != self.modal)
    {
        [self.modal.activityIndicatorView startAnimating];
        if (![self.modal isBeingDismissed])
        {
            [self.modal dismissViewControllerAnimated:YES completion:^{
                self.modal = nil;
            }];
        }
    }
    [self.activityIndicator stopAnimating];
    
    
    //Inject javascript to change the meta tag in the html head... this is pretty intense
    //via http://stackoverflow.com/a/7258179/2178152
    [self.webView stringByEvaluatingJavaScriptFromString:@"var all_metas=document.getElementsByTagName('meta');if (all_metas){var k;for (k=0; k<all_metas.length;k++){var meta_tag=all_metas[k];var viewport= meta_tag.getAttribute('name');if (viewport && viewport=='viewport'){meta_tag.setAttribute('content','width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=1');}}}"];
}


// load the section indicated in the scrollView
- (IBAction)loadSection:(UIButton *)sender {
    
    switch (self.page) {
        case 0:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless"];
            break;
        case 1:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless/#News"];
            break;
        case 2:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless/#Opinion"];
            break;
        case 3:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless/#Features"];
            break;
        case 4:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless/#Arts%20&%20Entertainment"];
            break;
        case 5:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless/#Sports"];
            break;
        default:
            self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless"];
            break;
            
            
            
    }
    
    NSURL *url = [NSURL URLWithString:self.currURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

// return to the Orient homepage when the Orient logo in the top left is pressed
// Set the scroll view back to the initial Home view
- (IBAction)homeButtonPressed:(UIButton *)sender {
    self.currURL = [NSString stringWithFormat:@"%@%@%@", @"http://bowdoinorient.com/browse/", [OrientViewController stringFromDate:self.articleDate], @"/chromeless"];
    NSURL *url = [NSURL URLWithString:self.currURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    [self.sectionScrollView scrollRectToVisible:CGRectMake(0,0,self.sectionScrollView.frame.size.width,self.sectionScrollView.frame.size.height)
                                       animated:YES];
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //regular expression to detect presence of a URL that should be chromeless
    NSString *bocomRegex = @"http://(www.)?bowdoinorient.com/(browse|article|series|author|about|contact|subscribe|advertise|survey)/?(.+)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bocomRegex];
    
    //regular expression to detect URLs that are ALREADY chromeless
    NSString *bocomRegex2 = @"(.+)?(chromeless)(.+)?";
    NSPredicate *urlTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bocomRegex2];
    
    //it's formed like a URL that should be chromeless, but doesn't have the "chromeless" already
    if([urlTest evaluateWithObject:request.URL.absoluteString] && ![urlTest2 evaluateWithObject:request.URL.absoluteString]){
        NSString *redirectURL = [request.URL.absoluteString stringByAppendingString:@"/chromeless"];
        
        //intercept the load request, stop it, and load a chromeless URL instead
        self.currURL = redirectURL;
        NSURL *url = [NSURL URLWithString:redirectURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        //NSLog(@"I'd redirect you to %@, if it were working.",url);
        [self.webView loadRequest:requestObj];
        return NO;
    }
    
    return YES;
}

//This is never called... may potentially be used later in a "view archives" function
- (NSString *)mostRecentIssueDate:(NSDate *) date {
    NSLocale *MURRICA = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:MURRICA];
    [dateFormat setDateFormat:@"e"];
    
    //which day of the week is it? (1-7)
    int dayOfWeek = [[dateFormat stringFromDate:date]intValue];
    int daysSinceLastFriday = (dayOfWeek - 6)%7; //friday is the 6th day of the week in the US locale
    if(daysSinceLastFriday<0)
        daysSinceLastFriday+=7;
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit| NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDateComponents *futureComponents = [[NSDateComponents alloc] init];
    futureComponents.day = -1*daysSinceLastFriday;
    NSDate *lastFriday = [calendar dateByAddingComponents:futureComponents toDate:[calendar dateFromComponents:dateComponents] options:0];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    //return the date of the most recent friday
    return [dateFormat stringFromDate:lastFriday];
}

//format a passsed date in the same way that the Orient does it: yyyy-mm-dd
+ (NSString *)stringFromDate:(NSDate *)reqdate {
    NSLocale *MURRICA = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:MURRICA];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat stringFromDate:reqdate];
}

// set up Splash segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modal"])
    {
        self.modal = (OrientSplashViewController*)segue.destinationViewController;
        self.modal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.page = (int)(self.sectionScrollView.contentOffset.x/self.sectionScrollView.frame.size.width);
    //NSLog(@"page number is %d", self.page);
}

//detect the double tap gesture to show or hide the menubar
-(void)doubleTap:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        //transition the MB off the screen
        if(self.menubarView.hidden==NO)
            [self hideMB];
        else
            [self showMB];
    }
}

//recognize both my double tap gesture AND the webview's built-in gestures
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

// Post a tweet to Twitter about the current URL
// Uses code from http://www.raywenderlich.com/21558/beginning-twitter-tutorial-updated-for-ios-6
-(IBAction)tweetButton:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"via @bowdoinorient: "];
        if (self.currURL){
            self.currURL = [self.currURL stringByReplacingOccurrencesOfString:@"/chromeless" withString:@""];
            [tweetSheet addURL:[NSURL URLWithString:self.currURL]];
        }
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now! Please make sure your device has an internet connection and you have at least one Twitter account set up."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    [self hideMB];
}

//Post an update to Facebook about the current URL
- (IBAction)fbButton:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:@"via The Bowdoin Orient: "];
        if (self.currURL){
            self.currURL = [self.currURL stringByReplacingOccurrencesOfString:@"/chromeless" withString:@""];
            [fbSheet addURL:[NSURL URLWithString:self.currURL]];
        }
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't post an update right now! Please make sure your device has an internet connection and you have a Facebook account set up in iOS."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    [self hideMB];
}

- (void)hideMB{
    //transition the MB off the screen, then hide it
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.menubarView setFrame:CGRectMake(0, self.view.bounds.size.height+self.menubarView.frame.size.height, self.menubarView.frame.size.width, self.menubarView.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             self.menubarView.hidden=YES;
                         }
                     }];
}

-(void)showMB{
    //unhide, then transition the menubar on to the screen
    self.menubarView.hidden=NO;
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.menubarView setFrame:CGRectMake(0, self.view.bounds.size.height-self.menubarView.frame.size.height, self.menubarView.frame.size.width, self.menubarView.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             //could run something on complete here
                         }
                     }];
}

//load bo.com's search page when you press the magnifying glass icon
- (IBAction)searchButton:(id)sender{
    self.currURL = @"http://bowdoinorient.com/search/chromeless";
    NSURL *url = [NSURL URLWithString:self.currURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];

    [self hideMB];
}


//rotation handling things
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}


@end
