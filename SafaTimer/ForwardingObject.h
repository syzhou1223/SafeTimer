//
//  ForwardingObject.h
//  SafaTimer
//
//  Created by zhouzhou on 2018/9/18.
//  Copyright © 2018年 zhouzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForwardingObject : NSObject

- (instancetype)initWithTarget:(id)target;
+ (instancetype)forwardWithTarget:(id)target;

@end


