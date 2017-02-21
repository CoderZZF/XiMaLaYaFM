//
//  XMGDownLoadedVoiceTVC.m
//  XMGDownLoadListern
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadedVoiceTVC.h"

@interface XMGDownLoadedVoiceTVC ()

@end

@implementation XMGDownLoadedVoiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpWithDatasource:@[@"1", @"2", @"3", @"4"] getCellBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxxx"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxxx"];
        }
        
        return cell;
        
    } cellHeight:^CGFloat(id model) {
        return 20;
    } bindBlock:^(UITableViewCell *cell, NSString *model) {
        cell.textLabel.text = model;
    }];

    
}


@end
