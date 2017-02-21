//
//  XMGAudioDownLoader.m
//  XMGRemotePlayerLib
//
//  Created by 小码哥 on 2016/11/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAudioDownLoader.h"
#import "XMGAudioFileTool.h"

@interface XMGAudioDownLoader ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSOutputStream *outputStream;

@property (nonatomic, strong) NSURL *url;





@end

@implementation XMGAudioDownLoader

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}


- (void)downLoadWithURL: (NSURL *)url offset: (long long)offset {
    
    self.url = url;
    self.offset = offset;
    
    
    [self cancel];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
    
}


- (void)cancel {
    
    [self.session invalidateAndCancel];
    self.session = nil;
    
    // 清理缓存
    [XMGAudioFileTool removeTmpFileWithURL:self.url];
    
    // 重置数据
    self.loadedSize = 0;
    
    
}




#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    NSHTTPURLResponse *httpResponse =  (NSHTTPURLResponse *)response;
    
    self.totalSize = [[[httpResponse.allHeaderFields[@"Content-Range"] componentsSeparatedByString:@"/"] lastObject] longLongValue];
     self.contentType = httpResponse.MIMEType;
    
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:[XMGAudioFileTool tmpPathWithURL:self.url] append:YES];
    [self.outputStream open];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    self.loadedSize += data.length;
    [self.outputStream write:data.bytes maxLength:data.length];
    
    if ([self.delegate respondsToSelector:@selector(downLoaderLoading)]) {
        [self.delegate downLoaderLoading];
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error == nil) {
        // 判断, 本地下载的大小, 是否等于文件的总大小
        if ([XMGAudioFileTool tmpFileSizeWithURL:self.url] == self.totalSize)
        {
            [XMGAudioFileTool moveTmpPathToCachePath:self.url];
        }
    }
    
    
}


@end
