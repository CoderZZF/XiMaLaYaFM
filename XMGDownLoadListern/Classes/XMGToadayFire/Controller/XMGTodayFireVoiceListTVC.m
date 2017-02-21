//
//  XMGTodayFireVoiceListTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceListTVC.h"

#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "XMGDownLoadVoiceModel.h"

#import "XMGTodayFireVoiceCell.h"

#import "UIButton+WebCache.h"
#import "XMGDownLoadManager.h"
#import "XMGRemotePlayer.h"


#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface XMGTodayFireVoiceListTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadVoiceModel *> *voiceMs;

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end

@implementation XMGTodayFireVoiceListTVC


- (void)setVoiceMs:(NSArray<XMGDownLoadVoiceModel *> *)voiceMs {
    _voiceMs = voiceMs;
    [self.tableView reloadData];
}

- (XMGSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

-(void)viewDidLoad
{
    self.tableView.rowHeight = 80;
    __weak typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": self.loadKey,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        NSMutableArray <XMGDownLoadVoiceModel *>*voiceyMs = [XMGDownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        weakSelf.voiceMs = voiceyMs;
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:kDownLoadURLOrStateChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:kRemotePlayerURLOrStateChangeNotification object:nil];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.voiceMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTodayFireVoiceCell *cell = [XMGTodayFireVoiceCell cellWithTableView:tableView];
    
    XMGDownLoadVoiceModel *voiceM = self.voiceMs[indexPath.row];
    
    [cell setPlayBlock:^(BOOL isPlaying) {
        // 执行具体的播放动作
        if (isPlaying) {
            NSURL *url = [NSURL URLWithString:voiceM.playPathAacv164];
            [[XMGRemotePlayer shareInstance] playWithURL:url];
        } else {
            [[XMGRemotePlayer shareInstance] pause];
        }
    }];
    
    [cell setDownloadBlock:^{
        NSURL *url = [NSURL URLWithString:voiceM.playPathAacv164];
        [[XMGDownLoadManager shareInstance] downLoadWithURL:url];
    }];
    
    //    cell.voiceM = model;
    // 拿到模型,给视图进行赋值
    cell.voiceTitleLabel.text = voiceM.title;
    cell.voiceAuthorLabel.text = [NSString stringWithFormat:@"by %@", voiceM.nickname];
    
    [cell.playOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:voiceM.coverSmall]  forState:UIControlStateNormal];
    cell.sortNumLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    
    
    // 动态的获取下载状态
    NSURL *url = [NSURL URLWithString:voiceM.playPathAacv164];
    XMGDownLoader *downLoader = [[XMGDownLoadManager shareInstance] getDownLoaderWithURL:url];
    
    XMGDownLoaderState state = downLoader.state;
    
    if (state == XMGDownLoaderStateDowning) {
        cell.state = XMGTodayFireVoiceCellStateDownLoading;
    }else if(state == XMGDownLoaderStateSuccess || [XMGDownLoader downLoadedFileWithURL:url].length > 0)
    {
        cell.state = XMGTodayFireVoiceCellStateDownLoaded;
    }else {
        cell.state = XMGTodayFireVoiceCellStateWaitDownLoad;
    }
    
    // 动态地获取播放状态
    // url
    if ([url isEqual:[XMGRemotePlayer shareInstance].url]) {
        // 判断状态
        XMGRemotePlayerState state = [XMGRemotePlayer shareInstance].state;
        if (state == XMGRemotePlayerStatePlaying) {
            cell.playOrPauseBtn.selected = YES;
        } else {
            cell.playOrPauseBtn.selected = NO;
        }
    } else {
        cell.playOrPauseBtn.selected = NO;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMGDownLoadVoiceModel *model = self.voiceMs[indexPath.row];
    
    NSLog(@"跳转到播放器界面进行播放--%@--", model.title);
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
