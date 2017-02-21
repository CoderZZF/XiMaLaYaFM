//
//  NSURL+XMGAudio.h
//  XMGRemotePlayerLib
//
//  Created by 小码哥 on 2016/11/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (XMGAudio)

- (NSURL *)streamingURL;

- (NSURL *)httpURL;

@end
