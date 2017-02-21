//
//  XMGTodayFireDataTool.h
//  XMGDownLoadListern
//
//  Created by zhangzhifu on 2017/2/21.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGCategoryModel.h"
#import "XMGDownLoadVoiceModel.h"

@interface XMGTodayFireDataTool : NSObject

+ (instancetype)sharedInstance;

- (void)getCategoryMS:(void(^)(NSArray<XMGCategoryModel *> *categoryMs))resultBlock;


- (void)getVoiceMsWithLoadKey:(NSString *)loadKey result:(void (^)(NSArray<XMGDownLoadVoiceModel *> *))resultBlock;
@end
