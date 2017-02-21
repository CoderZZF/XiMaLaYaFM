//
//  XMGDownLoadBaseTVC.h
//  XMGDownLoadListern
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义block类型
typedef UITableViewCell *(^GetCellType)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat(^GetCellHType)(id model);
typedef void(^BindType)(UITableViewCell *cell, id model);

@interface XMGDownLoadBaseTVC : UITableViewController

// 将具有共性的代码抽离出来,由子控制器决定.
- (void)setUpWithDatasource: (NSArray *)dataSources getCellBlock: (GetCellType)getCellBlock cellHeight: (GetCellHType)getCellHBlock bindBlock: (BindType)bindBlock;


@end
