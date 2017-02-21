//
//  XMGAudioDownLoader.h
//  XMGRemotePlayerLib
//
//  Created by 小码哥 on 2016/11/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMGAudioDownLoaderDelegate <NSObject>

- (void)downLoaderLoading;

@end


@interface XMGAudioDownLoader : NSObject

@property (nonatomic, assign) long long loadedSize;
@property (nonatomic, assign) long long offset;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, assign) long long totalSize;

@property (nonatomic, weak) id<XMGAudioDownLoaderDelegate> delegate;

- (void)downLoadWithURL: (NSURL *)url offset: (long long)offset;


@end
