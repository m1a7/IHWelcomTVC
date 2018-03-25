//
//  IHWelcomeStaticCell-Model.m
//  IHWelcomTVC
//
//  Created by Uber on 21/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHWelcomeStaticCell_Model.h"

@implementation IHWelcomeStaticCell_Model

#pragma mark - Mapping

+ (FEMMapping *) defaultMapping {
    
    FEMMapping* mapping = [[FEMMapping alloc] initWithObjectClass:[IHWelcomeStaticCell_Model class]];
    //mapping.rootPath = @"result";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    /*
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"updateDate" keyPath:@"timestamp" map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [formatter dateFromString:value];
        }
        return nil;
    } reverseMap:^id(id value) {
        return [formatter stringFromDate:value];
    }];
    */
    
    // property from nsobject : keypath from json
    [mapping addAttributesFromDictionary:@{ @"cellsUIStyle"    : @"cellsUIStyle",
                                            
                                            @"showStatusBar"   : @"showStatusBar",
                                            @"statusBarStyle"  : @"statusBarStyle",
                                           
                                            @"backgroundImgURL"               : @"backgroundImgURL",
                                            @"backgroundImgTurnBlur"          : @"backgroundImgTurnBlur",
                                            @"backgroundImgBlurRadiusOrAlpha" : @"backgroundImgBlurRadiusOrAlpha",
                                            @"backgroundImgBlurType"          : @"backgroundImgBlurType",
                                            
                                            @"mainLabelText"             : @"mainLabelText",
                                            @"mainLabelFontName"         : @"mainLabelFontName",
                                            @"mainLabelFontSize_iPhone"  : @"mainLabelFontSize_iPhone",
                                            @"mainLabelFontSize_iPad"    : @"mainLabelFontSize_iPad",
                                            @"mainLabelBackgroundColors" : @"mainLabelBackgroundColors",
                                            @"mainLabelFontColors"       : @"mainLabelFontColors",

                                            @"subLabelText"             : @"subLabelText",
                                            @"subLabelFontName"         : @"subLabelFontName",
                                            @"subLabelFontSize_iPhone"  : @"subLabelFontSize_iPhone",
                                            @"subLabelFontSize_iPad"    : @"subLabelFontSize_iPad",
                                            @"subLabelBackgroundColors" : @"subLabelBackgroundColors",
                                            @"subLabelFontColors"       : @"subLabelFontColors",
                                            
                                            @"learnMoreBtnLabelText"            : @"learnMoreBtnLabelText",
                                            @"learnMoreBtnLabelFontName"        : @"learnMoreBtnLabelFontName",
                                            @"learnMoreBtnLabelFontSize_iPhone" : @"learnMoreBtnLabelFontSize_iPhone",
                                            @"learnMoreBtnLabelFontSize_iPad"   : @"learnMoreBtnLabelFontSize_iPad",
                                            @"learnMoreBtnBackgroundColors"     : @"learnMoreBtnBackgroundColors",
                                            @"learnMoreBtnLabelFontColors"      : @"learnMoreBtnLabelFontColors",
                                         
                                            @"skipOnBoardingBtnLabelText"            : @"skipOnBoardingBtnLabelText",
                                            @"skipOnBoardingBtnLabelFontName"        : @"skipOnBoardingBtnLabelFontName",
                                            @"skipOnBoardingBtnLabelFontSize_iPhone" : @"skipOnBoardingBtnLabelFontSize_iPhone",
                                            @"skipOnBoardingBtnLabelFontSize_iPad"   : @"skipOnBoardingBtnLabelFontSize_iPad",
                                            @"skipOnBoardingBtnBackgroundColors"     : @"skipOnBoardingBtnBackgroundColors",
                                            @"skipOnBoardingBtnLabelFontColors"      : @"skipOnBoardingBtnLabelFontColors"
                                        }];
    
    return mapping;
}

#pragma mark - Mockuping

+ (IHWelcomeStaticCell_Model*) mockupWithStyle:(IHWelcomeCellStyle) style
{
    switch (style) {
        case IHWelcomeCellStyleDefault: return [self defaultMockup]; break;
        case IHWelcomeCellStyle1:       return [self style1Mockup];  break;
        case IHWelcomeCellStyle2:       return [self style2Mockup];  break;
            
        default: NSLog(@"Not found style"); break;
    }
    return nil;
}


- (NSString*) description
{
    NSLog(@"self.cellsUIStyle   = %ld " , self.cellsUIStyle);
    NSLog(@"self.showStatusBar  = %d" , self.showStatusBar);
    NSLog(@"self.statusBarStyle = %d", self.statusBarStyle);
    
    NSLog(@"self.mainLabelText     = %@", self.mainLabelText);
    NSLog(@"self.mainLabelFontName  = %@", self.mainLabelFontName);
    NSLog(@"self.mainLabelFontSize_iPhone  = %f", self.mainLabelFontSize_iPhone);
    NSLog(@"self.mainLabelFontSize_iPad    = %f", self.mainLabelFontSize_iPad);
    NSLog(@"self.mainLabelBackgroundColors = %@", self.mainLabelBackgroundColors);
    NSLog(@"self.mainLabelFontColors       = %@", self.mainLabelFontColors);
    
    NSLog(@"self.backgroundImgURL      = %@", self.backgroundImgURL);
    NSLog(@"self.backgroundImgTurnBlur = %d", self.backgroundImgTurnBlur);
    NSLog(@"self.backgroundImgBlurRadiusOrAlpha = %f", self.backgroundImgBlurRadiusOrAlpha);
    NSLog(@"self.backgroundImgBlurType          = %d", self.backgroundImgBlurType);
    return nil;
}

+ (IHWelcomeStaticCell_Model*) defaultMockup   // - IHWelcomeCellStyleDefault
{
    IHWelcomeStaticCell_Model* mockup = [[IHWelcomeStaticCell_Model alloc] init];
    mockup.cellsUIStyle   = IHWelcomeCellStyleDefault;
    
    mockup.showStatusBar  = YES;
    mockup.statusBarStyle = 0;
    
    mockup.mainLabelText     = @"IDEA FOR HALLOWEEN";
    mockup.mainLabelFontName = @"IBMPlexSerif-Medium";
    mockup.mainLabelFontSize_iPhone  = 25;
    mockup.mainLabelFontSize_iPad    = 45;
    mockup.mainLabelBackgroundColors = @[];
    mockup.mainLabelFontColors       = @[@"#DAE7EC", @"#6A7A7C"];
    
    mockup.subLabelText     = @"Get to know the interactive history of Halloween";
    mockup.subLabelFontName = @"IBMPlexSerif-Regular";
    mockup.subLabelFontSize_iPhone  = 15;
    mockup.subLabelFontSize_iPad    = 25;
    mockup.subLabelBackgroundColors = @[];
    mockup.subLabelFontColors       = @[@"#DAE7EC", @"#6A7A7C"];
    
    
    mockup.backgroundImgURL       = @"https://pp.userapi.com/c837725/v837725862/6bd03/DygeiL9IY24.jpg";
    mockup.backgroundImgTurnBlur  = YES;
    mockup.backgroundImgBlurRadiusOrAlpha = 1.0;
    mockup.backgroundImgBlurType  = 1;
    
    mockup.learnMoreBtnLabelText      = @"Learn more..";
    mockup.learnMoreBtnLabelFontName  = @"Oswald-ExtraLight";
    mockup.learnMoreBtnLabelFontSize_iPhone = 17;
    mockup.learnMoreBtnLabelFontSize_iPad   = 27;
    mockup.learnMoreBtnBackgroundColors = @[@"#354342", @"#354342"];
    mockup.learnMoreBtnLabelFontColors  = @[@"#ffffff"];
    
    mockup.skipOnBoardingBtnLabelText      = @"No, thanks";
    mockup.skipOnBoardingBtnLabelFontName  = @"Oswald-ExtraLight";
    mockup.skipOnBoardingBtnLabelFontSize_iPhone = 15;
    mockup.skipOnBoardingBtnLabelFontSize_iPad   = 15;
    mockup.skipOnBoardingBtnBackgroundColors = @[@"#474747", @"#363636"];
    mockup.skipOnBoardingBtnLabelFontColors  = @[@"#ffffff"];

    return mockup;
}

+ (IHWelcomeStaticCell_Model*) style1Mockup   // - IHWelcomeCellStyle1
{
    IHWelcomeStaticCell_Model* mockup = [[IHWelcomeStaticCell_Model alloc] init];
    mockup.cellsUIStyle   = IHWelcomeCellStyle1;
    return mockup;
}


+ (IHWelcomeStaticCell_Model*) style2Mockup   // - IHWelcomeCellStyle2
{
    IHWelcomeStaticCell_Model* mockup = [[IHWelcomeStaticCell_Model alloc] init];
    mockup.cellsUIStyle   = IHWelcomeCellStyle2;
    return mockup;
}

@end


/*
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"Person"];
    mapping.rootPath = @"result";
    
    [mapping addAttributesFromArray:@[@"name"]];
    [mapping addAttributesFromDictionary:@{@"email": @"user_email"}];
    [mapping addRelationshipMapping:[Car defaultMapping] forProperty:@"car" keyPath:@"car"];
    
    return mapping;
}
*/
