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
#define HASH_TAG    @"#pslauncher "

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

-(NSDictionary*) options
{
    NSMutableDictionary* options = [NSMutableDictionary dictionary];    
    if (callbackSwitch.on) {
        [options setObject:APP_NAME forKey:PS_PARAM_APPNAME];
        [options setObject:BACK_URL forKey:PS_PARAM_BACKURL];
    }
    if (hashtagSwitch.on) {
        [options setObject:HASH_TAG forKey:PS_PARAM_HASHTAG];
    }
    return options;
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
    
    [PictShare openPictShareWithData:data UTI:uti options:[self options]];
}

-(IBAction) openWithImage:(id)sender
{
    UIImage* img = [UIImage imageWithContentsOfFile:[self imagePath]];

    [PictShare openPictShareWithImage:img options:[self options]];
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
            [PictShare openPictShareWithAssetURLs:urls options:[self options]];

            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
