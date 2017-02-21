//
//  XMGDownLoadListernMainVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadListernMainVC.h"
#import "XMGSementBarVC.h"


@interface XMGDownLoadListernMainVC ()
// 选项卡控制器
@property (nonatomic, weak) XMGSementBarVC *segmentBarVC;
@end

@implementation XMGDownLoadListernMainVC
// 懒加载
- (XMGSementBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
       XMGSementBarVC *segmentBarVC = [[XMGSementBarVC alloc] init];
        [self addChildViewController:segmentBarVC];
        _segmentBarVC = segmentBarVC;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 取消自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置segmentBarVC.segmentBar
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    // 设置segmentBarVC.view
    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];
    // 添加子控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    [self.segmentBarVC setUpWithItems:@[@"专辑", @"声音", @"下载中"] childVCs:@[vc1, vc2, vc3]];
    // 更新选项卡控件的设置.
    [self.segmentBarVC.segmentBar updateWithConfig:^(XMGSegmentBarConfig *config) {
        config.segmentBarBackColor = [UIColor whiteColor];
    }];
    // 设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];

}



@end
