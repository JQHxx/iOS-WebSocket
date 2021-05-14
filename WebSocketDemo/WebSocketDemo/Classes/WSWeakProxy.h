//
//  WeakProxy.h
//  OFweekPhone
//
//  Created by OFweek01 on 2019/12/20.
//  Copyright © 2019 wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSWeakProxy : NSProxy

+ (instancetype)weakProxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
