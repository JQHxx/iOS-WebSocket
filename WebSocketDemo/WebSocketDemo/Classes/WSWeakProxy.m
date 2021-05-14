//
//  WeakProxy.m
//  OFweekPhone
//
//  Created by OFweek01 on 2019/12/20.
//  Copyright © 2019 wayne. All rights reserved.
//

#import "WSWeakProxy.h"

@interface WSWeakProxy()

@property (nonatomic, weak) id target;

@end

@implementation WSWeakProxy

+ (instancetype)weakProxyWithTarget:(id)target
{
    WSWeakProxy *weakProxy = [WSWeakProxy alloc];
    weakProxy.target = target;
    
    return weakProxy;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}


- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}


@end
