//
//  IHUIUtilites.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHUIUtilites.h"

@implementation IHUIUtilites


#pragma mark -  Another Helpers

+ (void)colorFromHexString:(NSString *)hexString block:(void(^)(UIColor* gradient))blockThatReturnsString
{
        BOOL isMainTread = [NSThread isMainThread];
        if (isMainTread){
            blockThatReturnsString([IHUIUtilites action_colorFromHexString:hexString]);
        }else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                blockThatReturnsString([IHUIUtilites action_colorFromHexString:hexString]);
            });
        }
}

+ (void) gradientFromColorArrayColors:(NSArray<id>*)arrColors  withHeight:(float)height block:(void(^)(UIColor* gradient))blockThatReturnsString
{
    BOOL isMainTread = [NSThread isMainThread];
    if (isMainTread){
        blockThatReturnsString([IHUIUtilites action_gradientFromColorArrayColors:arrColors withHeight:height]);
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            blockThatReturnsString([IHUIUtilites action_gradientFromColorArrayColors:arrColors withHeight:height]);
        });
    }
}


#pragma mark - Private method

+ (UIColor *)action_colorFromHexString:(NSString *)hexString {    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor*) action_gradientFromColorArrayColors:(NSArray<id>*)arrColors  withHeight:(float)height
{
    if (arrColors.count <= 0) return [UIColor clearColor];
  
    
    
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray* colors = [NSMutableArray new];
    for (id color in arrColors) {
        if (color){
            __block UIColor* convertToUIColor = nil;
            
            if ([color isKindOfClass:[NSString class]]){
                convertToUIColor = [IHUIUtilites action_colorFromHexString:color];
            }
            if ([color isKindOfClass:[UIColor class]]){
                convertToUIColor = ( UIColor*)color;
            }
            if (convertToUIColor){
                [colors addObject: (id)convertToUIColor.CGColor];
            }
            if (arrColors.count == 1){
                return convertToUIColor;
            }
        }
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}




#pragma mark - Helper UI method (Showing alertView/Presenting view ect..)

+ (void) showOkeyAlertVC:(NSString*) title msg:(NSString*) message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){ }];
    [alert addAction:okAction];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    BOOL isMainTread = [NSThread isMainThread];
    if (isMainTread){
        [rootVC presentViewController:alert animated:YES completion:nil];
    }else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [rootVC presentViewController:alert animated:YES completion:nil];
        });
    }
}

@end
