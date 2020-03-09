//
//  ZJTimer.m
//  OCInterview-iOS
//
//  Created by 精灵要跳舞 on 2020/3/7.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

#import "ZJTimer.h"
static NSMutableDictionary *timers_;
@implementation ZJTimer

+(void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
    });
}

+ (NSString *)executeTaskWithStartTime:(NSTimeInterval)startTime
                              Interval:(NSTimeInterval)interval
                               Repeats:(BOOL)repeats
                                 Async:(BOOL)async
                                  Task:(void(^)(void))task {
    
    NSString *timerId = [NSString stringWithFormat:@"%lu", (unsigned long)timers_.count];
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, startTime * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTimer:timerId];
        }
    });
    dispatch_resume(timer);
    timers_[timerId] = timer;
    return timerId;
}

+ (void)cancelTimer:(NSString *)timerId {
    dispatch_source_cancel(timers_[timerId]);
    [timers_ removeObjectForKey:timerId];
}
@end
