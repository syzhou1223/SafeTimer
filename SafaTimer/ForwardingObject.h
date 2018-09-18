//
//  ForwardingObject.h
//  SafaTimer
//
//  Created by zhouzhou on 2018/9/18.
//  Copyright © 2018年 zhouzhou. All rights reserved.
//

/**
 * @brief 此类用来转发消息，所有接收到的消息转发给初始时的target
 */
#import <Foundation/Foundation.h>

@interface ForwardingObject : NSObject

- (instancetype)initWithTarget:(id)target;
+ (instancetype)forwardWithTarget:(id)target;

@end


