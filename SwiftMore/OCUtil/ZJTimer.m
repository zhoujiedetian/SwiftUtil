//
//  ZJTimer.m
//  OCInterview-iOS
//
//  Created by 精灵要跳舞 on 2020/3/7.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

#import "ZJTimer.h"
static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;
@implementation ZJTimer

+(void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)executeTaskWithStartTime:(NSTimeInterval)startTime
                              Interval:(NSTimeInterval)interval
                               Repeats:(BOOL)repeats
                                 Async:(BOOL)async
                                  Task:(void(^)(void))task {
    
    if (!task || startTime < 0 || (interval <= 0 && repeats)) return nil;
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, startTime * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *timerId = [NSString stringWithFormat:@"%lu", (unsigned long)timers_.count];
    timers_[timerId] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTimer:timerId];
        }
    });
    dispatch_resume(timer);
    return timerId;
}

+ (void)cancelTimer:(NSString *)timerId {
    
    if (timerId.length == 0) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers_[timerId];
    if (timer) {
        dispatch_source_cancel(timers_[timerId]);
        [timers_ removeObjectForKey:timerId];
    }
    dispatch_semaphore_signal(semaphore_);
}
@end
