//
//  XMGTodayFireVoiceListTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceListTVC.h"
#import "XMGTodayFireDataTool.h"
#import "XMGTodayFireVoiceCell.h"
#import "XMGTodayFireVoiceCellPresenter.h"

@interface XMGTodayFireVoiceListTVC ()
@property (nonatomic, strong) NSArray<XMGTodayFireVoiceCellPresenter *> *presenters;
@end

@implementation XMGTodayFireVoiceListTVC

- (void)setPresenters:(NSArray<XMGTodayFireVoiceCellPresenter *> *)presenters {
    _presenters = presenters;
    
    [self.tableView reloadData];
}


-(void)viewDidLoad
{
    self.tableView.rowHeight = 80;
    __weak typeof(self) weakSelf = self;
    
    [[XMGTodayFireDataTool sharedInstance] getVoiceMsWithLoadKey:self.loadKey result:^(NSArray<XMGDownLoadVoiceModel *> *voiceMs) {
        NSMutableArray *ps = [NSMutableArray array];
        for (XMGDownLoadVoiceModel *voiceM in voiceMs) {
            XMGTodayFireVoiceCellPresenter *p = [XMGTodayFireVoiceCellPresenter new];
            p.voiceM = voiceM;
            [ps addObject:p];
        }
        weakSelf.presenters = ps;
    }];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.presenters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTodayFireVoiceCell *cell = [XMGTodayFireVoiceCell cellWithTableView:tableView];
    
    XMGTodayFireVoiceCellPresenter *pM = self.presenters[indexPath.row];
    pM.sortNum = indexPath.row + 1;
    
    [pM bindToCell:cell];
    
    return cell;
}


@end
