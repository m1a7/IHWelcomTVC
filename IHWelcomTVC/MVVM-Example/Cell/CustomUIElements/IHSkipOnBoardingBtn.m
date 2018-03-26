//
//  IHSkipOnBoardingBtn.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHSkipOnBoardingBtn.h"

// The cell itself, its import was done to, when calculating the new coordinates in the parent view system.
// There was no need to pass on a bunch of others to the subway and recalculate relative to them....
#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

#import "IHUIUtilites.h"

#define heightForIpad   40
#define heightForIphone 30

#define fontSizeForIpad   25
#define fontSizeForIphone 15

@implementation IHSkipOnBoardingBtn

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [IHSkipOnBoardingBtn buttonWithType: UIButtonTypeSystem];
    if (self) {
        self.parentCell = pCell;
        [self addTarget:pCell action:@selector(noThanksBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //self.layer.cornerRadius  = CGRectGetWidth(self.frame)/CGRectGetHeight(self.frame);
    float greaterSide = 0;
    float smallerSide = 0;
    
    if ( CGRectGetWidth(self.frame) >= CGRectGetHeight(self.frame)){
        greaterSide = CGRectGetWidth(self.frame);
        smallerSide = CGRectGetHeight(self.frame);
    }else {
        greaterSide = CGRectGetHeight(self.frame);
        smallerSide = CGRectGetWidth(self.frame);
    }
    self.layer.cornerRadius = (greaterSide/smallerSide)/4;

    
    if (self.parentCell){
     __weak IHSkipOnBoardingBtn* bself = self;
     [IHUIUtilites gradientFromColorArrayColors:self.parentCell.vm_cell.model_cell.skipOnBoardingBtnBackgroundColors
                                                             withHeight: CGRectGetHeight(frame)
                                                                  block:^(UIColor *gradient) {
                                                                      bself.backgroundColor = gradient;
                                                                  }];
    [IHUIUtilites gradientFromColorArrayColors: self.parentCell.vm_cell.model_cell.skipOnBoardingBtnLabelFontColors
                                    withHeight: CGRectGetHeight(frame)
                                         block:^(UIColor *gradient) {
                                             bself.titleLabel.tintColor = gradient;
                                         }];
    }
}

- (void) setHighlighted:(BOOL)highlighted{
    if (self.userInteractionEnabled && highlighted) {
        
        [UIView animateWithDuration:0.15
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (self.userInteractionEnabled){
                                 self.transform = CGAffineTransformMakeScale(0.9f, 0.8f);
                                 self.alpha = 0.5f;
                                 [self setUserInteractionEnabled:NO];
                             }
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.15f
                                              animations:^{
                                                  if (!self.userInteractionEnabled){
                                                      self.transform = CGAffineTransformIdentity;
                                                      self.alpha = 1.f;
                                                      [self setUserInteractionEnabled:YES];
                                                  }
                                              }];
                         }];
    }
}

- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    NSString* fontName_skipOnBoardBtn = vm.model_cell.skipOnBoardingBtnLabelFontName;
    float     fontSize_skipOnBoardBtn = (IDIOM == IPHONE) ? vm.model_cell.skipOnBoardingBtnLabelFontSize_iPhone : vm.model_cell.skipOnBoardingBtnLabelFontSize_iPad;
    UIFont*   font_skipOnBoardBtn = [UIFont fontWithName:fontName_skipOnBoardBtn size:fontSize_skipOnBoardBtn];
    
    // Check the value of variables (for security)
    if (!fontSize_skipOnBoardBtn){
        fontSize_skipOnBoardBtn = (IDIOM == IPHONE) ? fontSizeForIphone : fontSizeForIpad;
    }
    if (!font_skipOnBoardBtn){
        font_skipOnBoardBtn = [UIFont fontWithName:@"Oswald-ExtraLight" size:fontSize_skipOnBoardBtn];
    }
    
    self.titleLabel.font = font_skipOnBoardBtn;
    [self setTitleColor:[UIColor whiteColor]                 forState: UIControlStateNormal];
    [self setTitle: vm.model_cell.skipOnBoardingBtnLabelText forState: UIControlStateNormal];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.f, 1.2f);
    self.layer.shadowOpacity = 0.7f;
    self.layer.shadowRadius  = 1.0f;
    self.layer.masksToBounds = NO;
}

- (void) resizeByCell:(IHWelcomeStaticCell*) cell {
    self.frame = [self recalculateNewSizeByCell:cell];
}

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell
{
    float heightOfSkipOnBoardBtn = (IDIOM == IPHONE) ? heightForIphone : heightForIpad;
    float widthOfSkipOnBoardBtn  = CGRectGetWidth(cell.contentView.frame)-offset*2;
    float xOfSkipOnBoardBtn      = offset;
    float yOfSkipOnBoardBtn      = CGRectGetMaxY(cell.contentView.frame)-vertOffsetBtns-heightOfSkipOnBoardBtn;
    
    return  CGRectMake(xOfSkipOnBoardBtn, yOfSkipOnBoardBtn, widthOfSkipOnBoardBtn, heightOfSkipOnBoardBtn);
}

@end










