//
//  XMGDownLoadingVoiceTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadingVoiceTVC.h"

@interface XMGDownLoadingVoiceTVC ()

@end

@implementation XMGDownLoadingVoiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setUpWithDataSouce:@[@"haha", @"hehe"] getCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        return cell;
    } cellHeight:^CGFloat(id model) {
        return 50;
    } bind:^(UITableViewCell *cell, NSString *model) {
        cell.textLabel.text = model;
    }];

}



@end
