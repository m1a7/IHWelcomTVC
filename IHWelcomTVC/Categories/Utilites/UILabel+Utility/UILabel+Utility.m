//
//  UILabel+Utility.m
//  IHWelcomTVC
//
//  Created by Uber on 19/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "UILabel+Utility.h"

// .m File
@implementation NSString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font {
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize actualSize = [self boundingRectWithSize:maxSize
                                           options: NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font} context:nil].size;
    return actualSize.height;
}
@end

@implementation NSAttributedString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width {
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize actualSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return actualSize.height;
}
@end


@implementation UILabel (Utility)

- (CGFloat)textHeightForWidth:(CGFloat)width {
    return [self.text heightForWidth:width font:self.font];
}
- (CGFloat)attributedTextHeightForWidth:(CGFloat)width {
    return [self.attributedText heightForWidth:width];
}
@end


