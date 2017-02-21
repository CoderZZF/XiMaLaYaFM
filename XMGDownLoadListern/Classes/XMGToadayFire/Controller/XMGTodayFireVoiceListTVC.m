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


}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.voiceMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGTodayFireVoiceCell *cell = [XMGTodayFireVoiceCell cellWithTableView:tableView];

    XMGDownLoadVoiceModel *model = self.voiceMs[indexPath.row];
    model.sortNum = indexPath.row + 1;

    cell.voiceM = model;

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGDownLoadVoiceModel *model = self.voiceMs[indexPath.row];

    NSLog(@"跳转到播放器界面进行播放--%@--", model.title);

}



@end
