//
//  XMGTodayFireVoiceCellPresenter.h
//  XMGDownLoadListern
//
//  Created by zhangzhifu on 2017/2/21.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGDownLoadVoiceModel.h"
#import "XMGTodayFireVoiceCell.h"

@interface XMGTodayFireVoiceCellPresenter : NSObject

@property (nonatomic, strong) XMGDownLoadVoiceModel *voiceM;
@property (nonatomic, assign) NSInteger sortNum;

- (void)bindToCell:(XMGTodayFireVoiceCell *)cell;

@end
