//
//  PictShare.m
//  PictShareLauncher
//
//  Created by itok on 11/04/25.
//  Copyright 2011 itok. All rights reserved.
//

#import "PictShare.h"
#import "PictShareParams.h"

@implementation PictShare

static NSString* __urlEncode(NSString* str) 
{
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, nil, CFSTR(":/?=,!$&'()*+;[]@#"), kCFStringEncodingUTF8);
    return [(NSString*)encoded autorelease];
}

+(BOOL) isPictShareAvailable
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", PICTSHARE_SCHEME]]];
}

+(BOOL) openPictShareWithBase:(NSString*)base options:(NSDictionary*)options
{
    if (!(base && [base length] > 0)) {
        return NO;
    }
    
    NSMutableString* str = [NSMutableString stringWithString:base];
    for (NSString* key in [options allKeys]) {
        NSString* val = [options objectForKey:key];
        if ([val length] > 0) {
            [str appendFormat:@"&%@=%@", key, __urlEncode(val)];            
        }
    }
    
    NSURL* url = [NSURL URLWithString:str];
    if (url) {
        return [[UIApplication sharedApplication] openURL:url];
    }
    return NO;
}

+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti
{
    return [self openPictShareWithData:data UTI:uti applicationName:nil backURL:nil];
}

+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti applicationName:(NSString*)name backURL:(NSString*)backURL
{
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    if (name) {
        [options setObject:name forKey:PS_PARAM_APPNAME];
    }
    if (backURL) {
        [options setObject:backURL forKey:PS_PARAM_BACKURL];
    }
    
    return [self openPictShareWithData:data UTI:uti options:options];
}

+(BOOL) openPictShareWithData:(NSData*)data UTI:(NSString*)uti options:(NSDictionary*)options
{
    if (![self isPictShareAvailable]) {
        return NO;
    }
    
    if (!(data && uti && [uti length] > 0)) {
        return NO;
    }
    
    [[UIPasteboard generalPasteboard] setData:data forPasteboardType:uti];
    NSString* base = [NSString stringWithFormat:@"%@://%@/?%@=%@", PICTSHARE_SCHEME, PS_HOST_DATA, PS_PARAM_DATA_TYPE, uti];
    return [self openPictShareWithBase:base options:options];
}

+(BOOL) openPictShareWithImage:(UIImage*)image
{
    return [self openPictShareWithImage:image applicationName:nil backURL:nil];
}

+(BOOL) openPictShareWithImage:(UIImage*)image applicationName:(NSString*)name backURL:(NSString*)backURL
{
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    if (name) {
        [options setObject:name forKey:PS_PARAM_APPNAME];
    }
    if (backURL) {
        [options setObject:backURL forKey:PS_PARAM_BACKURL];
    }

    return [self openPictShareWithImage:image options:options];
}

+(BOOL) openPictShareWithImage:(UIImage *)image options:(NSDictionary *)options
{
    if (![self isPictShareAvailable]) {
        return NO;
    }
    if (!image) {
        return NO;
    }
    [[UIPasteboard generalPasteboard] setImage:image];
    NSString* base = [NSString stringWithFormat:@"%@://%@/?", PICTSHARE_SCHEME, PS_HOST_IMAGE];
    return [self openPictShareWithBase:base options:options];    
}

+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls
{
    return [self openPictShareWithAssetURLs:urls applicationName:nil backURL:nil];
}

+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls applicationName:(NSString*)name backURL:(NSString*)backURL
{
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    if (name) {
        [options setObject:name forKey:PS_PARAM_APPNAME];
    }
    if (backURL) {
        [options setObject:backURL forKey:PS_PARAM_BACKURL];
    }

    return [self openPictShareWithAssetURLs:urls options:options];
}

+(BOOL) openPictShareWithAssetURLs:(NSArray *)urls options:(NSDictionary *)options
{
    if (![self isPictShareAvailable]) {
        return NO;
    }
    
    if (!(urls && [urls count] > 0)) {
        return NO;
    }
    
    NSMutableArray* arr = [NSMutableArray array];
    for (NSURL* url in urls) {
        [arr addObject:__urlEncode([url absoluteString])];
    }
    NSString* base = [NSString stringWithFormat:@"%@://%@/?%@=%@", PICTSHARE_SCHEME, PS_HOST_ASSETS, PS_PARAM_ASSETS, [arr componentsJoinedByString:@","]];
    return [self openPictShareWithBase:base options:options];
}

+(BOOL) openAppStore
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PICTSHARE_APPSTORE]];
}

@end
