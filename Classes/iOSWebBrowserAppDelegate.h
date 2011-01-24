//
//  iOSWebBrowserAppDelegate.h
//  iOSWebBrowser
//
//  Created by Alexander Belyavskiy on 1/24/11.
//  Copyright 2011 ITechArt Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iOSWebBrowserViewController;

@interface iOSWebBrowserAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iOSWebBrowserViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iOSWebBrowserViewController *viewController;

@end

