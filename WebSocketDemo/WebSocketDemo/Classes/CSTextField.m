//
//  CSTextField.m
//  WebSocketDemo
//
//  Created by OFweek01 on 2021/4/20.
//

#import "CSTextField.h"

@interface CSTextField()

@property (nonatomic, assign) BOOL isPaddingEnable;
@property (nonatomic, assign) CGFloat paddingLeft;
@property (nonatomic, assign) CGFloat paddingRight;
@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) CGFloat paddingBottom;

@end

@implementation CSTextField

- (void)setPadding:(UIEdgeInsets)insets {
    _isPaddingEnable = YES;
    _paddingLeft = insets.left;
    _paddingRight = insets.right;
    _paddingTop = insets.top;
    _paddingBottom = insets.bottom;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (_isPaddingEnable) {
        CGFloat x = bounds.origin.x + _paddingLeft;
        CGFloat y = bounds.origin.y + _paddingTop;
        CGFloat w = bounds.size.width - _paddingRight;
        CGFloat h = bounds.size.height - _paddingBottom;
        return CGRectMake(x, y, w, h);
    } else {
        return bounds;
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
