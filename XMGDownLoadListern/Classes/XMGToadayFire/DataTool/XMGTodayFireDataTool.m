//
//  XMGTodayFireDataTool.m
//  XMGDownLoadListern
//
//  Created by zhangzhifu on 2017/2/21.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#define kBaseUrl @"http://mobile.ximalaya.com/"

#import "XMGTodayFireDataTool.h"

#import "XMGSessionManager.h"
#import "MJExtension.h"

@interface XMGTodayFireDataTool ()
@property (nonatomic, strong) XMGSessionManager *sessionManager;
@end

@implementation XMGTodayFireDataTool

static XMGTodayFireDataTool *_sharedInstance;

+ (instancetype)sharedInstance {
    if (_sharedInstance == nil) {
        _sharedInstance = [[XMGTodayFireDataTool alloc] init];
    }
    return _sharedInstance;
}

- (XMGSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)getCategoryMS:(void(^)(NSArray<XMGCategoryModel *> *categoryMs))resultBlock {
    
    // 发送网络请求
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        XMGCategoryModel *categoryM = [[XMGCategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";
        
        NSMutableArray <XMGCategoryModel *>*categoryMs = [XMGCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        if (categoryMs.count > 0) {
            [categoryMs insertObject:categoryM atIndex:0];
        }
        
        resultBlock(categoryMs);
        
    }];
}

- (void)getVoiceMsWithLoadKey:(NSString *)loadKey result:(void (^)(NSArray<XMGDownLoadVoiceModel *> *))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": loadKey,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        NSMutableArray <XMGDownLoadVoiceModel *>*voiceyMs = [XMGDownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        resultBlock(voiceyMs);
    }];
}
@end
