//
//  ZJTimer.h
//  OCInterview-iOS
//
//  Created by 精灵要跳舞 on 2020/3/7.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 封装GCD Timer
@interface ZJTimer : NSObject
+ (NSString*)executeTaskWithStartTime:(NSTimeInterval)startTime
                             Interval:(NSTimeInterval)interval
                              Repeats:(BOOL)repeats
                                Async:(BOOL)async
                                 Task:(void(^)(void))task;

+ (void)cancelTimer:(NSString *)timerId;
@end

NS_ASSUME_NONNULL_END
