//
//  ForwardingObject.m
//  SafaTimer
//
//  Created by zhouzhou on 2018/9/18.
//  Copyright © 2018年 zhouzhou. All rights reserved.
//

#import "ForwardingObject.h"

@interface ForwardingObject ()

@property (weak,nonatomic,readonly)id target;

@end;

@implementation ForwardingObject

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}
+ (instancetype)forwardWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}



//1、动态解析，给一个机会，动态添加一个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //    if (sel == @selector(speak)) {
    //
    //        class_addMethod([self class], sel, (IMP)speak, "V@:");
    //        return YES;
    //    }
    return [super resolveInstanceMethod:sel];
}

//2、备用接收者，寻找接盘者，有人接就转出去
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.target respondsToSelector:aSelector]) {
        return self.target;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}



//3、当一个SEL到来的时候，在这里返回SEL对应的NSMethodSignature
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (self.target) {
        return [self.target methodSignatureForSelector:aSelector];
    } else {
        //把方法转到一个其他方法，这个类永远不会因找不到方法而Crash
        return [super methodSignatureForSelector:@selector(catchExceptionMethod)];;
    }
    
}

//4、当一个消息转发的动作NSInvocation到来的时候，在这里选择把消息转发给对应的实际处理对象
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (void)dealloc {
    NSLog(@"WeakObject dealloc");
}

- (void)catchExceptionMethod {
    
}

@end
