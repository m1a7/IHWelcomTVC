//
//  IHWelcomeStaticCell-Model.h
//  IHWelcomTVC
//
//  Created by Uber on 21/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FastEasyMapping/FEMMapping.h>


typedef NS_ENUM(NSUInteger,  IHWelcomeCellStyle) {
   
    IHWelcomeCellStyleByJSONConfig = 0,
    IHWelcomeCellStyleDefault,
    IHWelcomeCellStyle1,
    IHWelcomeCellStyle2,
    IHWelcomeCellStyleCustom
};


@interface IHWelcomeStaticCell_Model : NSObject

@property (nonatomic, assign) IHWelcomeCellStyle cellsUIStyle;

//------------------------------------
//  Status Bar          | UIStatusBar |
//------------------------------------
@property (nonatomic, assign) BOOL showStatusBar;
@property (nonatomic, assign) int  statusBarStyle; /*
                                                    UIStatusBarStyleDefault      = 0,
                                                    UIStatusBarStyleLightContent = 1
                                                    */

//-----------------------------------------------------------
// Background Image      | FLAnimatedImageView: UIImageView |
//-----------------------------------------------------------
@property (nonatomic, strong) NSString* backgroundImgURL;
@property (nonatomic, assign) BOOL  backgroundImgTurnBlur;
@property (nonatomic, assign) float backgroundImgBlurRadiusOrAlpha; // from 0.0 to 1.0
@property (nonatomic, assign) int   backgroundImgBlurType;          /*
                                                                     UIBlurEffectStyleExtraLight, = 0
                                                                     UIBlurEffectStyleLight,      = 1
                                                                     UIBlurEffectStyleDark,       = 2
                                                                     */

//------------------------------------
// IDEA FOR HALLOWEEN      | UILabel |
//------------------------------------
@property (nonatomic, strong) NSString*  mainLabelText;
@property (nonatomic, strong) NSString*  mainLabelFontName;
@property (nonatomic, assign) float mainLabelFontSize_iPhone;
@property (nonatomic, assign) float mainLabelFontSize_iPad;
@property (nonatomic, strong) NSArray<NSString*>* mainLabelBackgroundColors;
@property (nonatomic, strong) NSArray<NSString*>* mainLabelFontColors;

//----------------------------------------------
// Get to know interractive history  | UILabel |
//----------------------------------------------
@property (nonatomic, strong) NSString*  subLabelText;
@property (nonatomic, strong) NSString*  subLabelFontName;
@property (nonatomic, assign) float               subLabelFontSize_iPhone;
@property (nonatomic, assign) float               subLabelFontSize_iPad;
@property (nonatomic, strong) NSArray<NSString*>* subLabelBackgroundColors;
@property (nonatomic, strong) NSArray<NSString*>* subLabelFontColors;


//--------------------------------------------
// Learn more     | IHLearnMoreBtn: UIButton |
//--------------------------------------------
@property (nonatomic, strong) NSString* learnMoreBtnLabelText;
@property (nonatomic, strong) NSString* learnMoreBtnLabelFontName;
@property (nonatomic, assign) float     learnMoreBtnLabelFontSize_iPhone;
@property (nonatomic, assign) float     learnMoreBtnLabelFontSize_iPad;
@property (nonatomic, strong) NSArray<NSString*>* learnMoreBtnBackgroundColors;
@property (nonatomic, strong) NSArray<NSString*>* learnMoreBtnLabelFontColors;

//------------------------------------
// Skip on Boarding       | UIButton |
//------------------------------------
@property (nonatomic, strong) NSString* skipOnBoardingBtnLabelText;
@property (nonatomic, strong) NSString* skipOnBoardingBtnLabelFontName;
@property (nonatomic, assign) float     skipOnBoardingBtnLabelFontSize_iPhone;
@property (nonatomic, assign) float     skipOnBoardingBtnLabelFontSize_iPad;
@property (nonatomic, strong) NSArray<NSString*>* skipOnBoardingBtnBackgroundColors;
@property (nonatomic, strong) NSArray<NSString*>* skipOnBoardingBtnLabelFontColors;

#pragma mark - Mapping

+ (FEMMapping *) defaultMapping;

#pragma mark - Mockuping

+ (IHWelcomeStaticCell_Model*) defaultMockup;
+ (IHWelcomeStaticCell_Model*) mockupWithStyle:(IHWelcomeCellStyle) style;
@end
