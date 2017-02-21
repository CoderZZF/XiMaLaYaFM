//
//  NSURL+XMGAudio.m
//  XMGRemotePlayerLib
//
//  Created by 小码哥 on 2016/11/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSURL+XMGAudio.h"

@implementation NSURL (XMGAudio)

- (NSURL *)streamingURL {
    
    NSURLComponents *commpents = [NSURLComponents componentsWithString:self.absoluteString];
    [commpents setScheme:@"streaming"];
    
    return [commpents URL];
    
}

- (NSURL *)httpURL {
    NSURLComponents *commpents = [NSURLComponents componentsWithString:self.absoluteString];
    [commpents setScheme:@"http"];
    
    return [commpents URL];
}


@end
