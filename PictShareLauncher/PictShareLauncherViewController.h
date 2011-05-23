//
//  PictShareLauncherViewController.h
//  PictShareLauncher
//
//  Created by itok on 11/04/25.
//  Copyright 2011 itok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictShareLauncherViewController : UIViewController <UIDocumentInteractionControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UISwitch* callbackSwitch;
    IBOutlet UISwitch* hashtagSwitch;
    IBOutlet UISegmentedControl* segment;
    
    NSMutableArray* urls;
}

-(IBAction) openWithDocumentInteractionController:(id)sender;
-(IBAction) openWithData:(id)sender;
-(IBAction) openWithImage:(id)sender;
-(IBAction) openWithAssetsLibrary:(id)sender;
-(IBAction) openAppStore:(id)sender;

@end
