//
//  ZJTimerProxy.m
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/3/7.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

#import "ZJTimerProxy.h"
@interface ZJTimerProxy()
@property (nonatomic, weak) id target;
@end

@implementation ZJTimerProxy

+ (instancetype)proxyWithTarget:(id)target {
    ZJTimerProxy *proxy = [ZJTimerProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (!self.target) {
        NSLog(@"self.target is null");
    }
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (!self.target) {
        NSLog(@"self.target is null");
        return;
    }
    [invocation invokeWithTarget:self.target];
}
@end
