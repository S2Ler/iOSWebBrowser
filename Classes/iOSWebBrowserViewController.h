//
//  iOSWebBrowserViewController.h
//  iOSWebBrowser
//
//  Created by Alexander Belyavskiy on 1/24/11.
//  Copyright 2011 ITechArt Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebSiteControllerDelegate.h"

@interface iOSWebBrowserViewController : UIViewController<WebSiteControllerDelegate> {

}

- (IBAction)openGooglePage;

@end

