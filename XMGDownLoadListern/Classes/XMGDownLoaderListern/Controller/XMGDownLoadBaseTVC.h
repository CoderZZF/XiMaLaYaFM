//
//  XMGDownLoadBaseTVC.h
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell *(^GetCellBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^GetHeightBlock)(id model);
typedef void (^BindBlock)(UITableViewCell *cell, id model);


@interface XMGDownLoadBaseTVC : UITableViewController


- (void)setUpWithDataSouce: (NSArray *)dataSource getCell: (GetCellBlock)cellBlock cellHeight: (GetHeightBlock)cellHeightBlock bind: (BindBlock)bindBlock;

@end
