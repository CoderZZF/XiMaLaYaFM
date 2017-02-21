//
//  XMGAudioFileTool.h
//  XMGRemotePlayerLib
//
//  Created by 小码哥 on 2016/11/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGAudioFileTool : NSObject

+ (NSString *)cachePathWithURL: (NSURL *)url;
+ (NSString *)tmpPathWithURL: (NSURL *)url;

+ (BOOL)isCacheFileExists: (NSURL *)url;
+ (BOOL)isTmpFileExists: (NSURL *)url;


+ (NSString *)contentTypeWithURL: (NSURL *)url;


+ (long long)cacheFileSizeWithURL: (NSURL *)url;
+ (long long)tmpFileSizeWithURL: (NSURL *)url;

+ (void)removeTmpFileWithURL: (NSURL *)url;


+ (void)moveTmpPathToCachePath: (NSURL *)url;

@end
