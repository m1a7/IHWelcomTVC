//
//  UILabel+Utility.h
//  IHWelcomTVC
//
//  Created by Uber on 19/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utility)
- (CGFloat)textHeightForWidth:(CGFloat)width;
- (CGFloat)attributedTextHeightForWidth:(CGFloat)width;
@end

@interface NSString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font;
@end

@interface NSAttributedString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width;
@end


