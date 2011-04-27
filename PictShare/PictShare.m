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

+(BOOL) openPictShareWithBase:(NSString*)base applicationName:(NSString*)name backURL:(NSString*)backURL
{
    if (!(base && [base length] > 0)) {
        return NO;
    }
    
    NSMutableString* str = [NSMutableString stringWithString:base];
    if (name && [name length] > 0) {
        [str appendFormat:@"&%@=%@", PS_PARAM_APPNAME, name];
    }
    if (backURL && [backURL length] > 0) {
        [str appendFormat:@"&%@=%@", PS_PARAM_BACKURL, __urlEncode(backURL)];
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
    if (![self isPictShareAvailable]) {
        return NO;
    }
    
    if (!(data && uti && [uti length] > 0)) {
        return NO;
    }
    
    [[UIPasteboard generalPasteboard] setData:data forPasteboardType:uti];
    NSString* base = [NSString stringWithFormat:@"%@://%@/?%@=%@", PICTSHARE_SCHEME, PS_HOST_DATA, PS_PARAM_DATA_TYPE, uti];
    return [self openPictShareWithBase:base applicationName:name backURL:backURL];
}

+(BOOL) openPictShareWithImage:(UIImage*)image
{
    return [self openPictShareWithImage:image applicationName:nil backURL:nil];
}

+(BOOL) openPictShareWithImage:(UIImage*)image applicationName:(NSString*)name backURL:(NSString*)backURL
{
    if (![self isPictShareAvailable]) {
        return NO;
    }
    if (!image) {
        return NO;
    }
    [[UIPasteboard generalPasteboard] setImage:image];
    NSString* base = [NSString stringWithFormat:@"%@://%@/?", PICTSHARE_SCHEME, PS_HOST_IMAGE];
    return [self openPictShareWithBase:base applicationName:name backURL:backURL];
}

+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls
{
    return [self openPictShareWithAssetURLs:urls applicationName:nil backURL:nil];
}

+(BOOL) openPictShareWithAssetURLs:(NSArray*)urls applicationName:(NSString*)name backURL:(NSString*)backURL
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
    return [self openPictShareWithBase:base applicationName:name backURL:backURL];
}

+(BOOL) openAppStore
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PICTSHARE_APPSTORE]];
}

@end
