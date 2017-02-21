//
//  XMGDownLoadListernMainVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadListernMainVC.h"
#import "XMGSementBarVC.h"

#import "XMGDownLoadAlbumTVC.h"
#import "XMGDownLoadVoiceTVC.h"
#import "XMGDownLoadingVoiceTVC.h"


@interface XMGDownLoadListernMainVC ()

@property (nonatomic, weak) XMGSementBarVC *segmentBarVC;

@end

@implementation XMGDownLoadListernMainVC

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

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;

    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];

    XMGDownLoadAlbumTVC *vc1 = [[XMGDownLoadAlbumTVC alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    XMGDownLoadVoiceTVC *vc2 = [[XMGDownLoadVoiceTVC alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    XMGDownLoadingVoiceTVC *vc3 = [[XMGDownLoadingVoiceTVC alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    [self.segmentBarVC setUpWithItems:@[@"专辑", @"声音", @"下载中"] childVCs:@[vc1, vc2, vc3]];

    [self.segmentBarVC.segmentBar updateWithConfig:^(XMGSegmentBarConfig *config) {
        config.segmentBarBackColor = [UIColor whiteColor];
    }];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];

}



@end
