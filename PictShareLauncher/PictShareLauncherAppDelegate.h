//
//  PictShareLauncherAppDelegate.h
//  PictShareLauncher
//
//  Created by itok on 11/04/25.
//  Copyright 2011 itok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PictShareLauncherViewController;

@interface PictShareLauncherAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PictShareLauncherViewController *viewController;

@end
