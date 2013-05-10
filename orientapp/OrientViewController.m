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
    
    //load Orient homepage
    NSString *fullURL = @"http://www.bowdoinorient.com";
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
    self.sectionScrollView.backgroundColor = [UIColor lightGrayColor];
    self.sectionScrollView.alpha = 0.3;
    
    
    CGFloat xPos = 0;
    //CGFloat yPos = self.sectionScrollView.frame.origin.y;
    CGFloat width = self.sectionScrollView.bounds.size.width;
    CGFloat height = self.sectionScrollView.bounds.size.height;
    int numberOfSections = 6;
    
    for (int i = 0; i < numberOfSections; i++)
    {
        xPos = i * self.view.frame.size.width/2; //changed
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, width, height)];
        view.backgroundColor = [UIColor lightGrayColor];
        //view.alpha = 0.3;
        
        UILabel* sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, height)];
        //        self.orientSectionLabel.frame = CGRectMake(0, 0, width, height);
        sectionLabel.hidden = NO;
        sectionLabel.textAlignment = NSTextAlignmentCenter;
        sectionLabel.backgroundColor = [UIColor lightGrayColor];
        // sectionLabel.alpha = 0.3;
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
                
            default:view.backgroundColor = [UIColor grayColor];
                break;
        }
        
        view.userInteractionEnabled = YES;
        [view addSubview:sectionLabel];
        
        [self.sectionScrollView addSubview:view];
        
        NSLog(@"1 xPos = %f", xPos);
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
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://www.bowdoinorient.com";
            //                NSString *fullURL = @"http://www.bowdoinorient.com";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 1:
            NSLog(@"page number is %d", self.page);
            loadURL= @"http://www.bowdoinorient.com/browse/#News";
            //                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#News";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 2:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://www.bowdoinorient.com/browse/#Opinion";
            //NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Opinion";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 3:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://www.bowdoinorient.com/browse/#Features";
            //                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Features";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 4:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://www.bowdoinorient.com/browse/#Arts%20&%20Entertainment";
            //                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Arts & Entertainment";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
        case 5:
            NSLog(@"page number is %d", self.page);
            loadURL = @"http://www.bowdoinorient.com/browse/#Sports";
            //                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Sports";
            //                NSURL *url = [NSURL URLWithString:fullURL];
            //                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //                [self.webView loadRequest:requestObj];
            break;
            
        default:loadURL = @"http://www.bowdoinorient.com";
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
    NSLog(@"page number is %d", self.page);
}



//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSString* loadURL = @"";
//
//    if (fmodf(self.sectionScrollView.contentOffset.x, self.sectionScrollView.frame.size.width) == 0)
//    {
//        switch (self.page) {
//            case 0:
//                loadURL = @"http://www.bowdoinorient.com";
////                NSString *fullURL = @"http://www.bowdoinorient.com";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 1:
//                loadURL= @"http://www.bowdoinorient.com/browse/#News";
////                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#News";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 2:
//                loadURL = @"http://www.bowdoinorient.com/browse/#Opinion";
//                //NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Opinion";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 3:
//                loadURL = @"http://www.bowdoinorient.com/browse/#Features";
////                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Features";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 4:
//                loadURL = @"http://www.bowdoinorient.com/browse/#Arts & Entertainment";
////                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Arts & Entertainment";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//                break;
//            case 5:
//                loadURL = @"http://www.bowdoinorient.com/browse/#Sports";
////                NSString *fullURL = @"http://www.bowdoinorient.com/browse/#Sports";
////                NSURL *url = [NSURL URLWithString:fullURL];
////                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////                [self.webView loadRequest:requestObj];
//
//            default:loadURL = @"http://www.bowdoinorient.com";
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
