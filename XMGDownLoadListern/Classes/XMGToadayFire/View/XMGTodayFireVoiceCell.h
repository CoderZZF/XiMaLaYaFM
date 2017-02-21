//
//  XMGTodayFireVoiceCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGDownLoadVoiceModel.h"


typedef NS_ENUM(NSUInteger, XMGTodayFireVoiceCellState) {
    XMGTodayFireVoiceCellStateWaitDownLoad,
    XMGTodayFireVoiceCellStateDownLoading,
    XMGTodayFireVoiceCellStateDownLoaded,
};

@interface XMGTodayFireVoiceCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) XMGDownLoadVoiceModel *voiceM;


@end
