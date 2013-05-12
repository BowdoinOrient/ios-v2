//
//  OrientViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
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


// Loads the Orient homepage
- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.haveShownModal = NO;
    
    NSString *fullURL = @"http://bowdoinorient.com";
    NSURL *url = [NSURL URLWithString:fullURL];
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
    
    for (int i = 0; i < numberOfSections; i++)
    {
        xPos = i * self.view.frame.size.width/2; //changed
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, width, height)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel* sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, height)];
        //        self.orientSectionLabel.frame = CGRectMake(0, 0, width, height);
        sectionLabel.hidden = NO;
        sectionLabel.textAlignment = NSTextAlignmentCenter;
        sectionLabel.backgroundColor = [UIColor whiteColor];
        sectionLabel.textColor = [UIColor blackColor];
        [sectionLabel setFont:[UIFont fontWithName:@"Minion Pro" size:15]];
        
        switch (i) {
            case 0:
                sectionLabel.text = @"HOME   >";
                break;
            case 1:
                //view.backgroundColor = [UIColor greenColor];
                sectionLabel.text = @"<   NEWS   >";
                break;
            case 2:
                //view.backgroundColor = [UIColor blueColor];
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
        
        //NSLog(@"1 xPos = %f", xPos);
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
}


// load the section indicated in the scrollView
- (IBAction)loadSection:(UIButton *)sender {
    NSString* loadURL = @"";
    
    switch (self.page) {
        case 0:
            //NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com";
            //                NSString *fullURL = @"http://bowdoinorient.com";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 1:
            //NSLog(@"page number is %d", self.page);
            loadURL= @"http://bowdoinorient.com/browse/#News";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#News";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 2:
            //NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Opinion";
            //NSString *fullURL = @"http://bowdoinorient.com/browse/#Opinion";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 3:
            //NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Features";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#Features";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 4:
            //NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Arts%20&%20Entertainment";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#Arts & Entertainment";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 5:
            //NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Sports";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#Sports";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
            
        default:loadURL = @"http://bowdoinorient.com";
            break;
            
    }
    
    NSString *fullURL = loadURL;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
    
}


- (IBAction)homeButtonPressed:(UIButton *)sender {
    NSString *fullURL = @"http://www.bowdoinorient.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if (![self.presentedViewController isBeingDismissed]) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
    //DEM REGEX
    NSString *bocomRegex = @"http://(www\.)?bowdoinorient\.com(/(browse|article|series|author)/?.+?)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bocomRegex];
    
    if([urlTest evaluateWithObject:request.URL.absoluteString]){
        NSString *redirectURL = [request.URL.absoluteString stringByAppendingString:@"/chromeless"];
        NSURL *url = [NSURL URLWithString:redirectURL];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        NSLog(@"I'd redirect you to %@, if it were working.",url);
        //[self.webView loadRequest:requestObj];
        //return NO;
    }
    return YES;
}

- (NSString *)mostRecentIssueDate:(NSDate *) date {
    NSLocale *MURRICA = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:MURRICA];
    [dateFormat setDateFormat:@"e"];
    
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
    
    return [dateFormat stringFromDate:lastFriday];
}

// set up Splash segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modal"])
    {
        self.modal = (OrientSplashViewController*)segue.destinationViewController;
    }
    
    //OrientSectionViewController* orientSectionViewController = (OrientSectionViewController*)[segue destinationViewController];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.page = (int)(self.sectionScrollView.contentOffset.x/self.sectionScrollView.frame.size.width);
    //NSLog(@"page number is %d", self.page);
}

-(void)doubleTap:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if(self.menubarView.hidden==NO)
            self.menubarView.hidden=YES;
        else
            self.menubarView.hidden=NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(IBAction)tweetButton:(id)sender {
    NSLog(@"You rang?");
}



//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSString* loadURL = @"";
//
//    if (fmodf(self.sectionScrollView.contentOffset.x, self.sectionScrollView.frame.size.width) == 0)
//    {
//        switch (self.page) {
//            case 0:
//                loadURL = @"http://bowdoinorient.com";
////                NSString *fullURL = @"http://bowdoinorient.com";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 1:
//                loadURL= @"http://bowdoinorient.com/browse/#News";
////                NSString *fullURL = @"http://bowdoinorient.com/browse/#News";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 2:
//                loadURL = @"http://bowdoinorient.com/browse/#Opinion";
//                //NSString *fullURL = @"http://bowdoinorient.com/browse/#Opinion";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 3:
//                loadURL = @"http://bowdoinorient.com/browse/#Features";
////                NSString *fullURL = @"http://bowdoinorient.com/browse/#Features";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 4:
//                loadURL = @"http://bowdoinorient.com/browse/#Arts & Entertainment";
////                NSString *fullURL = @"http://bowdoinorient.com/browse/#Arts & Entertainment";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 5:
//                loadURL = @"http://bowdoinorient.com/browse/#Sports";
////                NSString *fullURL = @"http://bowdoinorient.com/browse/#Sports";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                
//            default:loadURL = @"http://bowdoinorient.com";
//                break;
//
//                NSString *fullURL = loadURL;
//                NSURL *url = [NSURL URLWithString:fullURL];
//                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//                [self.webView loadRequest:requestObj];
//
//    }
//}
//}

@end
