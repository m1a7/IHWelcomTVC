//
//  IHLearnMoreBtn.m
//  IHWelcomTVC
//
//  Created by Uber on 19/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHLearnMoreBtn.h"

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

@implementation IHLearnMoreBtn

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [IHLearnMoreBtn buttonWithType: UIButtonTypeSystem];
    if (self) {
        self.parentCell = pCell;
        [self addTarget:pCell action:@selector(learnMoreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

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
            __weak IHLearnMoreBtn* bself = self;
            [IHUIUtilites gradientFromColorArrayColors:self.parentCell.vm_cell.model_cell.learnMoreBtnBackgroundColors
                                            withHeight: CGRectGetHeight(frame)
                                                 block:^(UIColor *gradient) {
                                                     bself.backgroundColor = gradient;
                                                 }];
            [IHUIUtilites gradientFromColorArrayColors: self.parentCell.vm_cell.model_cell.learnMoreBtnLabelFontColors
                                            withHeight: CGRectGetHeight(frame)
                                                 block:^(UIColor *gradient) {
                                                      bself.titleLabel.tintColor  = gradient;
                                                 }];
    }
}

- (void) setHighlighted:(BOOL)highlighted
{
    if (self.userInteractionEnabled && highlighted) {

    [UIView animateWithDuration:0.15
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (self.userInteractionEnabled){
                             self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
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
    NSString* fontName_learnMoreBtn = vm.model_cell.learnMoreBtnLabelFontName;
    float     fontSize_learnMoreBtn = (IDIOM == IPHONE) ? vm.model_cell.learnMoreBtnLabelFontSize_iPhone : vm.model_cell.learnMoreBtnLabelFontSize_iPad;
    UIFont*   font_learnMoreBtn     = [UIFont fontWithName:fontName_learnMoreBtn size:fontSize_learnMoreBtn];
  
    // Check the value of variables (for security)
    if (!fontSize_learnMoreBtn){
        fontSize_learnMoreBtn = (IDIOM == IPHONE) ? fontSizeForIphone : fontSizeForIpad;
    }
    if (!font_learnMoreBtn){
         font_learnMoreBtn = [UIFont fontWithName:@"Oswald-ExtraLight" size:fontSize_learnMoreBtn];
    }
    
    self.titleLabel.font = font_learnMoreBtn;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor whiteColor]           forState: UIControlStateNormal];
    [self setTitle:vm.model_cell.learnMoreBtnLabelText forState: UIControlStateNormal];
    
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
    float heightOfLearnMoreBtn = (IDIOM == IPHONE) ? heightForIphone : heightForIpad;
    float widthOfLearnMoreBtn  = CGRectGetWidth(cell.contentView.frame)-offset*2;
    float xOfLearnMoreBtn      = offset;
    float yOfLearnMoreBtn      = CGRectGetMinY(cell.skipOnBoardBtn.frame)-vertOffsetBtns-heightOfLearnMoreBtn;
    
    return  CGRectMake(xOfLearnMoreBtn, yOfLearnMoreBtn, widthOfLearnMoreBtn, heightOfLearnMoreBtn);
}




@end
