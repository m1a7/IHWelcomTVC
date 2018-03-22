//
//  IHWelcomeStaticCell.m
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHWelcomeStaticCell.h"

// Thrid-party fraemwork
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/UIImageView+WebCache.h>


// Category for calculate height
#import "UILabel+Utility.h"

// Custom button
#import "IHLearnMoreBtn.h"

// ViewModel
#import "IHWelcomeStaticCell_ViewModel.h"

#define offset 25.f
#define vertOffsetBtns 15.f

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define IPHONE   UIUserInterfaceIdiomPhone

@implementation IHWelcomeStaticCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

#pragma mark - NSDesignated Methods

- (instancetype) initWithViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    self = [super init];
    if (self) {
        self.vm_cell = vm;
    }
    return self;
}

#pragma mark - Setters

- (void) setVm_cell:(IHWelcomeStaticCell_ViewModel *)vm_cell
{
    // Вынести это определение во viewModel
    // NSString* contryCode = @"ru";
    // NSString* doneURL = [NSString stringWithFormat:@"https://github.com/.../IHHalloween/Localization/%@.IHWelcomeJSON.json",contryCode];
   
    _vm_cell = vm_cell;
    
    if (_vm_cell.model_cell)
    {
        [self initUISubviews: _vm_cell];
        [self addSubviewsOnContentView];
        [self updateUI: _vm_cell];
    } else {
        __weak IHWelcomeStaticCell* bself = self;
        [_vm_cell getWelcomScreenDataFromURL: _vm_cell.urlUIConfig
                                   onSuccess:^(BOOL successOperation) {
                                       // Обновить UI
                                       [bself initUISubviews: _vm_cell];
                                       [bself addSubviewsOnContentView];
                                       [bself updateUI:bself.vm_cell];
                                       [bself resizeSubviews];
                                   }
                                   onFailure:^(NSError *errorBlock, NSObject *errObj) {
                                    //#warning Обработь отсутствие интернета
                                   }];
    }
}

#pragma mark - Work with UI

-(void) layoutSubviews{
    [super layoutSubviews];
    [self  resizeSubviews];
}

- (void) resizeSubviews {
    self.backgroundImgView.frame   = [self cgrectFor_BackgroundImgView];
    self.blurView.frame            = [self cgrectFor_BlurView];
    self.appNameLbl.frame          = [self cgrectFor_AppNameLblwithText:_vm_cell.model_cell.mainLabelText withFont:_appNameLbl.font];
    self.sloganLbl.frame           = [self cgrectFor_SloganLblwithText: _sloganLbl.text   withFont:_sloganLbl.font];
    self.skipOnBoardBtn.frame      = [self cgrectFor_SkipOnBoardBtn];
    self.learnMoreBtn.frame        = [self cgrectFor_LearnMoreBtn];
}

- (void) initUISubviews:(IHWelcomeStaticCell_ViewModel*) vm
{
    if (self.contentView){
    
        if ([vm.model_cell.backgroundImgURL rangeOfString:@".gif"].location != NSNotFound) {
            self.backgroundImgView  = [[FLAnimatedImageView alloc] init];
        } else {
            self.backgroundImgView = [[UIImageView alloc] init];
               }

            if (vm.model_cell.backgroundImgTurnBlur){
                
                if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                    self.blurView    = [[UIVisualEffectView alloc]init];
                }
            }
            self.appNameLbl     = [UILabel new];
            self.sloganLbl      = [UILabel new];
            self.skipOnBoardBtn = [UIButton buttonWithType: UIButtonTypeSystem];
            self.learnMoreBtn   = [IHLearnMoreBtn buttonWithType: UIButtonTypeSystem];
        }
}


- (void) addSubviewsOnContentView
{
    if (self.contentView){
        if (self.backgroundImgView) [self.contentView addSubview: self.backgroundImgView];
        if (self.blurView)          [self.contentView addSubview: self.blurView];
        if (self.appNameLbl)        [self.contentView addSubview: self.appNameLbl];
        if (self.sloganLbl)         [self.contentView addSubview: self.sloganLbl];
        if (self.skipOnBoardBtn)    [self.contentView addSubview: self.skipOnBoardBtn];
        if (self.learnMoreBtn)      [self.contentView addSubview: self.learnMoreBtn];
    }
}

- (void) updateUI:(IHWelcomeStaticCell_ViewModel*) vm
{
    
    if (vm){
        dispatch_sync(dispatch_get_main_queue(), ^{

            // IDEA FOR HALLOWEEN
            NSString* fontName_AppNameLbl = vm.model_cell.mainLabelFontName;
            float     fontSize_AppNameLbl = (IDIOM == IPHONE) ? vm.model_cell.mainLabelFontSize_iPhone : vm.model_cell.mainLabelFontSize_iPad;
            UIFont*   fontForAppNameLbl = [UIFont fontWithName:fontName_AppNameLbl size:fontSize_AppNameLbl];
            //#warning потом добавить родной шрит на случай падения
            self.appNameLbl.text = vm.model_cell.mainLabelText;
            self.appNameLbl.font = fontForAppNameLbl;
            self.appNameLbl.numberOfLines = 0;
            self.appNameLbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
            self.appNameLbl.textAlignment      = NSTextAlignmentCenter;
            
            
            // Get to know the interactive history of Halloween
            NSString* fontName_SloganLb = vm.model_cell.subLabelFontName;
            float     fontSize_SloganLb = (IDIOM == IPHONE) ? vm.model_cell.subLabelFontSize_iPhone : vm.model_cell.subLabelFontSize_iPad;
            UIFont*   fontForSloganLbl = [UIFont fontWithName:fontName_SloganLb size:fontSize_SloganLb];
            
            self.sloganLbl.text =  vm.model_cell.subLabelText;
            self.sloganLbl.font = fontForSloganLbl;
            self.sloganLbl.numberOfLines      = 0;
            self.sloganLbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
            self.sloganLbl.textAlignment      = NSTextAlignmentCenter;
            
            // No, thanks
            NSString* fontName_skipOnBoardBtn = vm.model_cell.skipOnBoardingBtnLabelFontName;
            float     fontSize_skipOnBoardBtn = (IDIOM == IPHONE) ? vm.model_cell.skipOnBoardingBtnLabelFontSize_iPhone : vm.model_cell.skipOnBoardingBtnLabelFontSize_iPad;
            UIFont*   font_skipOnBoardBtn = [UIFont fontWithName:fontName_skipOnBoardBtn size:fontSize_skipOnBoardBtn];
            
            self.skipOnBoardBtn.titleLabel.font = font_skipOnBoardBtn;
            [self.skipOnBoardBtn setTitleColor:[UIColor whiteColor]                 forState: UIControlStateNormal];
            [self.skipOnBoardBtn setTitle: vm.model_cell.skipOnBoardingBtnLabelText forState: UIControlStateNormal];
            
            
            // Learn more
            NSString* fontName_learnMoreBtn = vm.model_cell.learnMoreBtnLabelFontName;
            float     fontSize_learnMoreBtn = (IDIOM == IPHONE) ? vm.model_cell.learnMoreBtnLabelFontSize_iPhone : vm.model_cell.learnMoreBtnLabelFontSize_iPad;
            UIFont*   font_learnMoreBtn     = [UIFont fontWithName:fontName_learnMoreBtn size:fontSize_learnMoreBtn];
            
            self.learnMoreBtn.titleLabel.font = font_learnMoreBtn;
            self.learnMoreBtn.layer.masksToBounds = YES;
            [self.learnMoreBtn setTitleColor:[UIColor whiteColor]           forState: UIControlStateNormal];
            [self.learnMoreBtn setTitle:vm.model_cell.learnMoreBtnLabelText forState: UIControlStateNormal];
       
        // Download Image
        self.backgroundImgView.contentMode      = UIViewContentModeScaleAspectFill;
        self.backgroundImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (vm.model_cell.backgroundImgTurnBlur){
            
            if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                
                self.blurEffect  = [UIBlurEffect effectWithStyle:vm.model_cell.backgroundImgBlurType];
                __weak IHWelcomeStaticCell* bself = self;
                [UIView animateWithDuration:0.7 animations:^{
                    bself.blurView.alpha     = vm.model_cell.backgroundImgBlurRadiusOrAlpha;
                    bself.blurView.effect    = bself.blurEffect;
                }];
                self.blurView.frame   = self.contentView.frame;
                self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            }
        }
    });

        if (vm.model_cell.backgroundImgURL.length > 0){
            __weak IHWelcomeStaticCell* bself = self;
            
            NSURL* imgURL = [NSURL URLWithString: vm.model_cell.backgroundImgURL];
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
             
            NSURLSessionDownloadTask *downloadPhotoTask = [session//[NSURLSession sharedSession]
                                                           downloadTaskWithURL:imgURL
                                                           completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                               
                                                                #warning исправить в либах !!!!
                                                               NSData* data =  [NSData dataWithContentsOfURL:location];
                                                               //NSData* data=  [NSData dataWithContentsOfURL:imgURL];
                                                               if (data) {
                                                                   // GIF support
                                                                   if ([imgURL.absoluteString rangeOfString:@".gif"].location != NSNotFound) {
                                                                       FLAnimatedImage* animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
                                                                       //dispatch_async(dispatch_get_main_queue(), ^{
                                                                           bself.backgroundImgView.animatedImage = animatedImage;
                                                                       //});
                                                                   }  // Another type support
                                                                   else {
                                                                       UIImage* image = [UIImage imageWithData:data];
                                                                       //dispatch_async(dispatch_get_main_queue(), ^{
                                                                               bself.backgroundImgView.image = image;
                                                                        //});
                                                                   }
                                                               }
                                                               [bself resizeSubviews];
                                                           }];
            [downloadPhotoTask resume];
            
             } else {
             // Добавляем одноцветый фон
             self.backgroundImgView.backgroundColor = [UIColor yellowColor];
               }
    }
}



#pragma mark - Get CGrect configuration for all subviews

- (CGRect) cgrectFor_BackgroundImgView {
    return self.contentView.frame;
}

- (CGRect) cgrectFor_BlurView {
    return self.contentView.frame;
}

- (CGRect) cgrectFor_AppNameLblwithText:(NSString*) text withFont:(UIFont*) font {
    
    float x = offset;
    float y = offset;
    float widthAppNameLbl  =  CGRectGetWidth(self.contentView.frame)-offset*2;
    float heightAppNameLbl = [text heightForWidth: widthAppNameLbl font:font];
    
    self.appNameLbl.textColor = [IHWelcomeStaticCell gradientFromColor:[IHWelcomeStaticCell colorFromHexString:@"#DAE7EC"]
                                                               toColor:[IHWelcomeStaticCell colorFromHexString:@"#6A7A7C"]
                                                            withHeight: (int)heightAppNameLbl];
    
    
    return CGRectMake(x, y, widthAppNameLbl, heightAppNameLbl);
}

- (CGRect) cgrectFor_SloganLblwithText:(NSString*) text withFont:(UIFont*) font {
    
    float y = CGRectGetMaxY(self.appNameLbl.frame)+vertOffsetBtns;
    float widthSloganLbl  =  CGRectGetWidth(self.contentView.frame)-offset*2;
    float heightSloganLbl = [text heightForWidth: widthSloganLbl font:font];
    return CGRectMake(offset, y, widthSloganLbl, heightSloganLbl);
}


- (CGRect) cgrectFor_SkipOnBoardBtn {
    float heightOfSkipOnBoardBtn = 20.f;
    float widthOfSkipOnBoardBtn  = CGRectGetWidth(self.contentView.frame)-offset*2;
    float xOfSkipOnBoardBtn      = offset;
    float yOfSkipOnBoardBtn      = CGRectGetMaxY(self.contentView.frame)-vertOffsetBtns-heightOfSkipOnBoardBtn;
    
    self.skipOnBoardBtn.backgroundColor     = [IHWelcomeStaticCell gradientFromColor:[IHWelcomeStaticCell colorFromHexString:@"#474747"]
                                                                             toColor:[IHWelcomeStaticCell colorFromHexString:@"#363636"]
                                                                          withHeight:(int)heightOfSkipOnBoardBtn];
    
    return  CGRectMake(xOfSkipOnBoardBtn, yOfSkipOnBoardBtn, widthOfSkipOnBoardBtn, heightOfSkipOnBoardBtn);
}

- (CGRect) cgrectFor_LearnMoreBtn {
    float heightOfLearnMoreBtn = 30.f;
    float widthOfLearnMoreBtn  = CGRectGetWidth(self.contentView.frame)-offset*2;
    float xOfLearnMoreBtn      = offset;
    float yOfLearnMoreBtn      = CGRectGetMinY(self.skipOnBoardBtn.frame)-vertOffsetBtns-heightOfLearnMoreBtn;
    
    self.learnMoreBtn.backgroundColor     = [IHWelcomeStaticCell gradientFromColor:[IHWelcomeStaticCell colorFromHexString:@"#354342"]
                                                                           toColor:[IHWelcomeStaticCell colorFromHexString:@"#242C28"]
                                                                        withHeight:(int)heightOfLearnMoreBtn];
    
    return  CGRectMake(xOfLearnMoreBtn, yOfLearnMoreBtn, widthOfLearnMoreBtn, heightOfLearnMoreBtn);
}


#pragma mark - Helpers

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor*) gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
