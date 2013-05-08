//
//  OrientViewController.m
//  orientapp
//
//  Created by Brian Jacobel on 2/26/13.
//  Copyright (c) 2013 com.bowdoinorient. All rights reserved.
//

#import "OrientViewController.h"
#import "OrientSectionViewController.h"

@interface OrientViewController()
@property (nonatomic) int page;
@property (nonatomic) BOOL haveShownModal;
@end

@implementation OrientViewController

@synthesize webView = _webView;
@synthesize sectionLabel = _sectionLabel;
@synthesize sectionButton = _sectionButton;
@synthesize page = _page;
@synthesize loadButton = _loadButton;
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
    self.webView.delegate = self;
    
    self.activityIndicator.hidden = YES;
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.sectionLabel setFont:[UIFont fontWithName:@"Minion Pro Med" size:8]];
    
    // section scroll view setup
    
    self.sectionScrollView.pagingEnabled = YES;
    self.sectionScrollView.delegate = self;
    
    CGFloat xPos = 0;
    CGFloat yPos = self.sectionScrollView.frame.origin.y;
    CGFloat width = self.sectionScrollView.bounds.size.width;
    CGFloat height = self.sectionScrollView.bounds.size.height;
    int numberOfSections = 6;
    
    for (int i = 0; i < numberOfSections; i++)
    {
        xPos = i * self.view.frame.size.width;
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, width, height)];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor grayColor];

        
        switch (i) {
            case 0:
                
                label.text = @"Home";
                break;
            case 1:
                //view.backgroundColor = [UIColor greenColor];
                label.text = @"News";
                break;
            case 2:
                //view.backgroundColor = [UIColor blueColor];
                label.text = @"Opinion";
                break;
            case 3:
                label.text = @"Features";
                break;
            case 4:
                label.text = @"Arts and Entertainment";
                break;
            case 5:
                label.text = @"Sports";
                
            default:view.backgroundColor = [UIColor grayColor];
                break;
        }
        view.userInteractionEnabled = YES;
        //view.backgroundColor = [UIColor colorWithRed:(i * 25) green:(i * 60) blue:(i * 12) alpha:1.0];
        [view addSubview:label];
        
        
        //label.userInteractionEnabled = YES;
        
        [self.sectionScrollView addSubview:view];
        //NSLog(@"1 xPos = %f", xPos);
        //xPos += width;
        //NSLog(@"2 xPos = %f", xPos);
    }
    self.sectionScrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfSections, self.sectionScrollView.frame.size.height);

    
    NSLog(@"%@",self.mostRecentIssueDate);
}

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

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (nil != self.modal)
    {
        [self.modal.activityIndicatorView startAnimating];
    }
    //else
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (nil != self.modal)
    {
        [self.modal.activityIndicatorView startAnimating];
        [self.modal dismissViewControllerAnimated:YES completion:^{
            self.modal = nil;
        }];
    }
    [self.activityIndicator stopAnimating];
}

-(void)loadURL:(NSString *)givenURL
{
    NSString *fullURL = givenURL;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (IBAction)loadSection:(UIButton *)sender {
    NSString* loadURL = @"";
    
    switch (self.page) {
        case 0:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com";
            //                NSString *fullURL = @"http://bowdoinorient.com";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 1:
            NSLog(@"page number is %d", self.page);
            loadURL= @"http://bowdoinorient.com/browse/#News";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#News";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 2:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Opinion";
            //NSString *fullURL = @"http://bowdoinorient.com/browse/#Opinion";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 3:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Features";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#Features";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 4:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://bowdoinorient.com/browse/#Arts%20&%20Entertainment";
            //                NSString *fullURL = @"http://bowdoinorient.com/browse/#Arts & Entertainment";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 5:
            NSLog(@"page number is %d", self.page);
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

- (IBAction)homeButtonPressed:(UIButton *)sender {
    NSString *fullURL = @"http://bowdoinorient.com";
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
    NSLog(@"page number is %d", self.page);
}


@end
