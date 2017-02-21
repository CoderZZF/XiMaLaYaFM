//
//  XMGDownLoadAlbumTVC.m
//  XMGDownLoadListern
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadAlbumTVC.h"

@interface XMGDownLoadAlbumTVC ()

@end

@implementation XMGDownLoadAlbumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpWithDatasource:@[@"a", @"b", @"c"] getCellBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
        }
        return cell;
        
    } cellHeight:^CGFloat(id model) {
        
        if ([model isEqualToString:@"a"]) {
            return 30;
        }else {
            return 60;
        }
        
    } bindBlock:^(UITableViewCell *cell, NSString *model) {
        cell.textLabel.text = model;
    }];
    
}





@end
