//
//  PictShareLauncherViewController.m
//  PictShareLauncher
//
//  Created by itok on 11/04/25.
//  Copyright 2011 itok. All rights reserved.
//

#import "PictShareLauncherViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "PictShare.h"
#import "PictShareParams.h"

#define APP_NAME    @"PictShareLauncher"
#define BACK_URL    @"PictShareLauncher://"

#define NUMBER_ASSETS   (1)

@implementation PictShareLauncherViewController

- (void)dealloc
{
    [urls release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString*) imagePath
{
    NSArray* exts = [NSArray arrayWithObjects:@"jpg", @"png", @"mov", nil];
    
    return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", segment.selectedSegmentIndex] ofType:[exts objectAtIndex:segment.selectedSegmentIndex]];
}

-(IBAction) openWithDocumentInteractionController:(id)sender
{
    NSURL* url = [NSURL fileURLWithPath:[self imagePath]];
    UIDocumentInteractionController* ctl = [UIDocumentInteractionController interactionControllerWithURL:url];
    [ctl retain];
    [ctl presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

-(IBAction) openWithData:(id)sender
{
    NSURL* url = [NSURL fileURLWithPath:[self imagePath]];
    NSString* uti = (NSString*)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)[url pathExtension], NULL);
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    if (callbackSwitch.on) {
        [PictShare openPictShareWithData:data UTI:uti applicationName:APP_NAME backURL:BACK_URL];
    } else {
        [PictShare openPictShareWithData:data UTI:uti];
    }
}

-(IBAction) openWithImage:(id)sender
{
    UIImage* img = [UIImage imageWithContentsOfFile:[self imagePath]];
    if (callbackSwitch.on) {
        [PictShare openPictShareWithImage:img applicationName:APP_NAME backURL:BACK_URL];
    } else {
        [PictShare openPictShareWithImage:img];        
    }
}


-(IBAction) openWithAssetsLibrary:(id)sender
{
    if (!urls) {
        urls = [[NSMutableArray alloc] init];
    }
    [urls removeAllObjects];
    
    UIImagePickerController* ctl = [[UIImagePickerController alloc] init];
    ctl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ctl.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:ctl.sourceType];
    ctl.delegate = self;
    [self presentModalViewController:ctl animated:YES];
    [ctl release];
}

-(IBAction) openAppStore:(id)sender
{
    [PictShare openAppStore];
}

#pragma mark UIDocumentInteractionController

-(void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    [controller autorelease];
}

#pragma mark UIImagePickerController

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL* url = [info objectForKey:UIImagePickerControllerReferenceURL];
    if (url) {
        [urls addObject:url];
        if ([urls count] == NUMBER_ASSETS) {
            if (callbackSwitch.on) {
                [PictShare openPictShareWithAssetURLs:urls applicationName:APP_NAME backURL:BACK_URL];
            } else {
                [PictShare openPictShareWithAssetURLs:urls];
            }
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
