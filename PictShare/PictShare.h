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

/**
 * check PictShare is available
 */
+(BOOL) isPictShareAvailable;

/**
 * use pasteboard as data
 * - data:    image data
 * - uti:     data UTI (public.jpeg, public.png, etc.) <- see sample code
 * - name:    sender application name
 * - backURL: sender application callback url
 */
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti;
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti applicationName:(NSString*)name backURL:(NSString*)backURL;
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti options:(NSDictionary*)options;

/**
 * use pasteboard as image
 * - image:   image
 * # discard your photo's information such as exif
 * # PictShare use image as JPEG
 * - name:    sender application name
 * - backURL: sender application callback url
 */
+(BOOL) openPictShareWithImage:(UIImage*)image;
+(BOOL) openPictShareWithImage:(UIImage*)image applicationName:(NSString*)name backURL:(NSString*)backURL;
+(BOOL) openPictShareWithImage:(UIImage*)image options:(NSDictionary*)options;

/**
 * use assets library
 * - urls:    assets urls (assets-library://xxx)
 * - name:    sender application name
 * - backURL: sender application callback url
 */
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls applicationName:(NSString*)name backURL:(NSString*)backURL;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls options:(NSDictionary*)options;

/**
 * open AppStore
 */
+(BOOL) openAppStore;

@end
