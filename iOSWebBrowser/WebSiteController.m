
#pragma mark imports
#import "WebSiteController.h"
#import "WebSiteControllerDelegate.h"

#pragma mark private
@interface WebSiteController()
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *html;
- (void)updateViewState;
@end

@implementation WebSiteController
#pragma mark synthesize
@synthesize webView = webView_;
@synthesize backButton = backButton_;
@synthesize forwardButton = forwardButton_;
@synthesize refreshButton = refreshButton_;
@synthesize activityIndicator = activityIndicator_;
@synthesize url = url_;
@synthesize html = html_;
@synthesize delegate = delegate_;

#pragma mark memory
- (void)dealloc {
	[webView_ release];
	[backButton_ release];
	[forwardButton_ release];
	[refreshButton_ release];
	[activityIndicator_ release];
	[url_ release];
	[html_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[self.webView stopLoading];
	self.webView = nil;
    self.backButton = nil;
	self.forwardButton = nil;
	self.refreshButton = nil;
	self.activityIndicator = nil;
}

#pragma mark inits
- (id)initWithURLString:(NSString *)url
{
	self = [super init];
	if (self != nil) {
		url_ = [url copy];
	}
	return self;
}

- (id) initWithHTMLString:(NSString *)html {
	self = [super init];
	if(self != nil){
		html_ = [html retain];
	}
	return self;
}

#pragma mark view life
- (void)viewDidLoad {
	[webView_ setDelegate:self];
	if(url_ != nil){
		self.url = [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, 
																		 (CFStringRef) url_,
																		 CFSTR(""), 
																		 NULL, 
																		 kCFStringEncodingUTF8) autorelease];
		NSURL *url = [NSURL URLWithString:url_];
		[webView_ loadRequest:[NSURLRequest requestWithURL:url]];
	}
	else {
		[webView_ loadHTMLString:html_ 
						 baseURL:[NSURL URLWithString:@"www.unknown.no"]];
	}
	[self updateViewState];
    [super viewDidLoad];
}

- (void)updateViewState {
	if ([webView_ isLoading] == YES) {
		[activityIndicator_ setHidden:NO];
		if ([activityIndicator_ isAnimating] == NO) {
			[activityIndicator_ startAnimating];
		}
	} else {
		[activityIndicator_ setHidden:YES];
		[activityIndicator_ stopAnimating];
	}
	
	if ([webView_ canGoBack] == YES) {
		[backButton_ setEnabled:YES];
	} else {
		[backButton_ setEnabled:NO];
	}
	
	if ([webView_ canGoForward] == YES) {
		[forwardButton_ setEnabled:YES];
	} else {
		[forwardButton_ setEnabled:NO];
	}
}

#pragma mark Actions
- (IBAction)back {
	if ([webView_ canGoBack] == YES) {
		[webView_ goBack];
	}
	[self updateViewState];
}

- (IBAction)forward {
	if ([webView_ canGoForward] == YES) {
		[webView_ goForward];
	}
	[self updateViewState];
}

- (IBAction)refresh {
	[webView_ reload];
	[self updateViewState];
}

- (IBAction)close {
	[delegate_ webSiteControllerDidRequestToDismiss:self];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

- (void)webView:(UIWebView *)webView
didFailLoadWithError:(NSError *)error {
	if ([error code] == 204) {
		UIAlertView * errorAlert = [[[UIAlertView alloc] initWithTitle:@"Loading external plugin" 
															   message:@"Please wait" 
															  delegate:self 
													 cancelButtonTitle:@"OK" 
													 otherButtonTitles:nil]
									autorelease];
		[errorAlert show];

		[self updateViewState];		
	} else {
		if ([error code] != -999) { //204 - Plugin handled load
			[self updateViewState];
			NSString * errorString = [NSString stringWithFormat:@"Unable to download. The reason is %@", 
									  [error localizedDescription]];
			
			UIAlertView * errorAlert = [[[UIAlertView alloc] initWithTitle:@"Error loading content" 
																   message:errorString 
																  delegate:self 
														 cancelButtonTitle:@"OK" 
														 otherButtonTitles:nil]
										autorelease];
			[errorAlert show];
		}
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self updateViewState];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[self updateViewState];
}
@end

