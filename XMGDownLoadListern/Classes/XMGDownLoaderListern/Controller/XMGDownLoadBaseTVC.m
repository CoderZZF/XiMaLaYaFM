//
//  XMGDownLoadBaseTVC.m
//  XMGDownLoadListern
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadBaseTVC.h"
#import "XMGNoDownLoadView.h"


@interface XMGDownLoadBaseTVC ()
// 中间视图控件
@property (nonatomic, weak) XMGNoDownLoadView *noDataView;
// 数据源
@property (nonatomic, strong) NSArray *dataSources;
// block属性.
@property (nonatomic, copy) GetCellType getCellBlock;
@property (nonatomic, copy) GetCellHType getCellHBlock;
@property (nonatomic, copy) BindType bindBlock;
@end

@implementation XMGDownLoadBaseTVC
// 懒加载
- (XMGNoDownLoadView *)noDataView
{
    if (!_noDataView) {
        XMGNoDownLoadView *noDataView = [XMGNoDownLoadView noDownLoadView];
        [self.view addSubview:noDataView];
        _noDataView = noDataView;
    }
    return _noDataView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景颜色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 判断中间视图内容
    UIImage *noDownLoadedImg = [UIImage imageNamed:@"noData_download"];
    UIImage *noDownLoadingImg = [UIImage imageNamed:@"noData_downloading"];
    if ([self isKindOfClass:NSClassFromString(@"XMGDownLoadingVoiceTVC")]) {
        self.noDataView.noDataImg = noDownLoadingImg;
    }else {
        self.noDataView.noDataImg = noDownLoadedImg;
    }
    
    // 调用中间按钮点击的block
    [self.noDataView setClickBlock:^{
        NSLog(@"跳转到去看看");
    }];
    
    // 消除分割线
    self.tableView.tableFooterView = [UIView new];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 设置中间视图位置.
    self.noDataView.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.4);
}

- (void)setUpWithDatasource: (NSArray *)dataSources getCellBlock: (GetCellType)getCellBlock cellHeight: (GetCellHType)getCellHBlock bindBlock: (BindType)bindBlock {
    // 赋值
    self.getCellBlock = getCellBlock;
    self.getCellHBlock = getCellHBlock;
    self.bindBlock = bindBlock;
    self.dataSources = dataSources;
    // 刷新
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = self.dataSources.count;
    self.noDataView.hidden = (count != 0);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = self.getCellBlock(tableView, indexPath);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSources[indexPath.row];
    if (self.getCellHBlock) {
        return self.getCellHBlock(model);;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSources[indexPath.row];
    self.bindBlock(cell, model);
}
@end
