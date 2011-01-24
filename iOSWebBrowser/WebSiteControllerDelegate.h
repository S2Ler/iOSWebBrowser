
#import <UIKit/UIKit.h>
@class WebSiteController;

@protocol WebSiteControllerDelegate
- (void)webSiteControllerDidRequestToDismiss:(WebSiteController *)aController;
@end
