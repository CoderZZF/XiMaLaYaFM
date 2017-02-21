//
//  XMGTodayFireMainVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireMainVC.h"
#import "XMGSementBarVC.h"
#import "XMGTodayFireVoiceListTVC.h"

#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "XMGCategoryModel.h"



#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface XMGTodayFireMainVC ()

@property (nonatomic, weak) XMGSementBarVC *segContentVC;

@property (nonatomic, strong) NSArray<XMGCategoryModel *> *categoryMs;

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end

@implementation XMGTodayFireMainVC

- (XMGSementBarVC *)segContentVC {
    if (!_segContentVC) {
        XMGSementBarVC *contentVC = [[XMGSementBarVC alloc] init];
        [self addChildViewController:contentVC];
        _segContentVC = contentVC;
    }
    return _segContentVC;
}

- (void)setCategoryMs:(NSArray<XMGCategoryModel *> *)categoryMs {
    _categoryMs = categoryMs;

    NSInteger vcCount = _categoryMs.count;
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:vcCount];
    for (XMGCategoryModel *model in _categoryMs) {
        XMGTodayFireVoiceListTVC *vc = [[XMGTodayFireVoiceListTVC alloc] init];
        vc.loadKey = model.key;
        [vcs addObject:vc];
    }

    [self.segContentVC setUpWithItems:[categoryMs valueForKeyPath:@"name"] childVCs:vcs];

}

- (XMGSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"今日最火";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segContentVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.segContentVC.view];


    // 发送网络请求
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        XMGCategoryModel *categoryM = [[XMGCategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";

        NSMutableArray <XMGCategoryModel *>*categoryMs = [XMGCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        if (categoryMs.count > 0) {
            [categoryMs insertObject:categoryM atIndex:0];
        }


        weakSelf.categoryMs = categoryMs;
        
    }];


}



@end
