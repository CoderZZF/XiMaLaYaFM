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

/** 声音标题 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTitleLabel;
/** 声音作者 */
@property (weak, nonatomic) IBOutlet UILabel *voiceAuthorLabel;
/** 声音播放暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 声音排名标签 */
@property (weak, nonatomic) IBOutlet UILabel *sortNumLabel;
/** 声音下载按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property (nonatomic, assign) XMGTodayFireVoiceCellState state;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, copy) void(^playBlock)(BOOL isPlaying);
@property(nonatomic, copy) void(^downloadBlock)();

@property (nonatomic, strong) XMGDownLoadVoiceModel *voiceM;


@end
