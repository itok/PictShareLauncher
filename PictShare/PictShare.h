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
 * - options: key-val options (see PictShareParams.h)
 *      - PS_PARAM_APPNAME : sender application name
 *      - PS_PARAM_BACKURL : sender application callback url
 *      - PS_PARAM_HASHTAG : twitter hashtag (PictShare v2.1)
 */
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti;
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti options:(NSDictionary*)options;
+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti applicationName:(NSString*)name backURL:(NSString*)backURL; // deprecated

/**
 * use pasteboard as image
 * - image:   image
 * # discard your photo's information such as exif
 * # PictShare use image as JPEG
 * - options: key-val options (see PictShareParams.h)
 *      - PS_PARAM_APPNAME : sender application name
 *      - PS_PARAM_BACKURL : sender application callback url
 *      - PS_PARAM_HASHTAG : twitter hashtag (PictShare v2.1)
 */
+(BOOL) openPictShareWithImage:(UIImage*)image;
+(BOOL) openPictShareWithImage:(UIImage*)image options:(NSDictionary*)options;
+(BOOL) openPictShareWithImage:(UIImage*)image applicationName:(NSString*)name backURL:(NSString*)backURL; // deprecated

/**
 * use assets library
 * - urls:    assets urls (assets-library://xxx)
 * - options: key-val options (see PictShareParams.h)
 *      - PS_PARAM_APPNAME : sender application name
 *      - PS_PARAM_BACKURL : sender application callback url
 *      - PS_PARAM_HASHTAG : twitter hashtag (PictShare v2.1)
 */
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls options:(NSDictionary*)options;
+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls applicationName:(NSString*)name backURL:(NSString*)backURL; // deprecated

/**
 * open AppStore
 */
+(BOOL) openAppStore;

@end
