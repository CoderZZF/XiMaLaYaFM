//
//  XMGTodayFireVoiceCellPresenter.m
//  XMGDownLoadListern
//
//  Created by zhangzhifu on 2017/2/21.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceCellPresenter.h"
#import "UIButton+WebCache.h"
#import "XMGDownLoadManager.h"
#import "XMGRemotePlayer.h"


@interface XMGTodayFireVoiceCellPresenter ()
@property (nonatomic, weak) XMGTodayFireVoiceCell *cell;
@end


@implementation XMGTodayFireVoiceCellPresenter

- (NSURL *)playDownURL {
    return [NSURL URLWithString:self.voiceM.playPathAacv164];
}

- (NSString *)title {
    return self.voiceM.title;
}

- (NSString *)author {
    return [NSString stringWithFormat:@"by %@", self.voiceM.nickname];
}

- (NSURL *)voiceImg {
    return [NSURL URLWithString:self.voiceM.coverSmall];
}

- (NSString *)sortNumStr {
    return [NSString stringWithFormat:@"%zd", self.sortNum];
}

- (XMGTodayFireVoiceCellState)downloadState {
    NSURL *url = [NSURL URLWithString:self.voiceM.playPathAacv164];
    XMGDownLoader *downLoader = [[XMGDownLoadManager shareInstance] getDownLoaderWithURL:url];
    
    XMGDownLoaderState state = downLoader.state;
    
    if (state == XMGDownLoaderStateDowning) {
        return XMGTodayFireVoiceCellStateDownLoading;
    }else if(state == XMGDownLoaderStateSuccess || [XMGDownLoader downLoadedFileWithURL:url].length > 0)
    {
        return XMGTodayFireVoiceCellStateDownLoaded;
    }else {
        return XMGTodayFireVoiceCellStateWaitDownLoad;
    }
}

- (BOOL)isPlaying {
    if ([[self playDownURL] isEqual:[XMGRemotePlayer shareInstance].url]) {
        // 判断状态
        XMGRemotePlayerState state = [XMGRemotePlayer shareInstance].state;
        return state == XMGRemotePlayerStatePlaying;
    } else {
        return NO;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:kDownLoadURLOrStateChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:kRemotePlayerURLOrStateChangeNotification object:nil];
    }
    return self;
}

- (void)bindToCell:(XMGTodayFireVoiceCell *)cell {
    
    self.cell = cell;
    
    //    cell.self.voiceM = model;
    // 拿到模型,给视图进行赋值
    cell.voiceTitleLabel.text = [self title];
    cell.voiceAuthorLabel.text = [self author];
    
    [cell.playOrPauseBtn sd_setBackgroundImageWithURL: [self voiceImg] forState:UIControlStateNormal];
    cell.sortNumLabel.text = [self sortNumStr];
    
    
    // 动态的获取下载状态
    cell.state = [self downloadState];
    
    // 动态地获取播放状态
    // url
    cell.playOrPauseBtn.selected = [self isPlaying];
    
    // 响应用户事件
    [cell setPlayBlock:^(BOOL isPlaying) {
        // 执行具体的播放动作
        if (isPlaying) {
            NSURL *url = [NSURL URLWithString:self.voiceM.playPathAacv164];
            [[XMGRemotePlayer shareInstance] playWithURL:url];
        } else {
            [[XMGRemotePlayer shareInstance] pause];
        }
    }];
    
    [cell setDownloadBlock:^{
        NSURL *url = [NSURL URLWithString:self.voiceM.playPathAacv164];
        [[XMGDownLoadManager shareInstance] downLoadWithURL:url];
    }];
    
    [cell setClickBlock:^{
        NSLog(@"点击了这个cell - %@", self.voiceM);
    }];
}


- (void)downLoadStateChange: (NSNotification *)notice {
    
    NSDictionary *downDic = notice.userInfo;
    NSURL *url = downDic[@"downLoadURL"];
    
    if ([url isEqual:[self playDownURL]]) {
        XMGDownLoaderState state = [downDic[@"downLoadState"] integerValue];
        
        if (state == XMGDownLoaderStateDowning) {
            self.cell.state = XMGTodayFireVoiceCellStateDownLoading;
        }else if(state == XMGDownLoaderStateSuccess || [XMGDownLoader downLoadedFileWithURL:url].length > 0)
        {
            self.cell.state = XMGTodayFireVoiceCellStateDownLoaded;
        }else {
            self.cell.state = XMGTodayFireVoiceCellStateWaitDownLoad;
        }
    }
}


- (void)playStateChange:(NSNotification *)noti {
    NSLog(@"%@",noti);
    
    XMGRemotePlayerState state = [noti.userInfo[@"playState"] integerValue];
    NSURL *url = noti.userInfo[@"playURL"];
    
    if ([url isEqual:[self playDownURL]]) {
        // 判断状态
        if (state == XMGRemotePlayerStatePlaying) {
            self.cell.playOrPauseBtn.selected = YES;
        } else {
            self.cell.playOrPauseBtn.selected = NO;
        }
    } else {
        self.cell.playOrPauseBtn.selected = NO;
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
