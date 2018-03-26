//
//  IHUIUtilites.h
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface IHUIUtilites : NSObject


+ (void) showOkeyAlertVC:(NSString*) title msg:(NSString*) message;


// Support NSString(ColorByHEX) and UIColor
// + (UIColor*) gradientFromColorArrayColors:(NSArray<id>*)arrColors  withHeight:(float)height;

+ (void) gradientFromColorArrayColors:(NSArray<id>*)arrColors  withHeight:(float)height block:(void(^)(UIColor* gradient))blockThatReturnsString;


// + (UIColor *)colorFromHexString:(NSString *)hexString;
+ (void)colorFromHexString:(NSString *)hexString block:(void(^)(UIColor* gradient))blockThatReturnsString;
@end

