
#import <UIKit/UIKit.h>

@class iOSWebBrowserViewController;

@interface iOSWebBrowserAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iOSWebBrowserViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iOSWebBrowserViewController *viewController;

@end

