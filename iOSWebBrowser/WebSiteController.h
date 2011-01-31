
#pragma mark imports
#import <UIKit/UIKit.h>
@protocol WebSiteControllerDelegate;

@interface WebSiteController : UIViewController<UIWebViewDelegate> {
	UIWebView *webView_;
	UIBarButtonItem *backButton_;
	UIBarButtonItem *forwardButton_;
	UIBarButtonItem *refreshButton_;
	UIActivityIndicatorView *activityIndicator_;
	NSString *url_;
	NSString *html_;
	id<WebSiteControllerDelegate> delegate_;
}

#pragma mark properties
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, assign) id<WebSiteControllerDelegate> delegate;

#pragma mark inits
/** @param url This parameter is copied. */
- (id) initWithURLString:(NSString *)url;
- (id) initWithHTMLString:(NSString *)html;

#pragma mark actions
- (IBAction)back;
- (IBAction)forward;
- (IBAction)refresh;
- (IBAction)close;

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType;

- (void)webView:(UIWebView *)webView
didFailLoadWithError:(NSError *)error;

- (void)webViewDidFinishLoad:(UIWebView *)webView;

- (void)webViewDidStartLoad:(UIWebView *)webView;
@end
