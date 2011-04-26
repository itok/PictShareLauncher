//
//  PictShare.h
//  PictShareLauncher
//
//  Created by itok on 11/04/25.
//  Copyright 2011 itok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictShare : NSObject {
    
}

+(BOOL) isPictShareAvailable;

+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti;
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti applicationName:(NSString*)name backURL:(NSString*)backURL;
+(BOOL) openPictShareWithImage:(UIImage*)image;
+(BOOL) openPictShareWithImage:(UIImage*)image applicationName:(NSString*)name backURL:(NSString*)backURL;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls applicationName:(NSString*)name backURL:(NSString*)backURL;

+(BOOL) openAppStore;

@end
