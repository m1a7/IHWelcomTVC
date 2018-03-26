//
//  IHSloganLbl.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHSloganLbl.h"


#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

#import "IHAppNameLbl.h"

// Category for calculate height
#import "UILabel+Utility.h"

#import "IHUIUtilites.h"

@implementation IHSloganLbl


- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [super init];
    if (self) {
        self.parentCell = pCell;
        
        self.numberOfLines      = 0;
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        self.textAlignment      = NSTextAlignmentCenter;
        
    }
    return self;
}


- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.parentCell){
    __weak IHSloganLbl* bself = self;
    [IHUIUtilites gradientFromColorArrayColors:self.parentCell.vm_cell.model_cell.subLabelBackgroundColors
                                    withHeight:CGRectGetHeight(frame)
                                         block:^(UIColor* gradient) {
                                             bself.backgroundColor = gradient;
                                         }];
    
    [IHUIUtilites gradientFromColorArrayColors: self.parentCell.vm_cell.model_cell.subLabelFontColors
                                    withHeight:CGRectGetHeight(frame)
                                         block:^(UIColor* gradient) {
                                             bself.textColor = gradient;
                                         }];
    }
}



- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    NSString* fontName_SloganLb = vm.model_cell.subLabelFontName;
    float     fontSize_SloganLb = (IDIOM == IPHONE) ? vm.model_cell.subLabelFontSize_iPhone : vm.model_cell.subLabelFontSize_iPad;
    UIFont*   fontForSloganLbl = [UIFont fontWithName:fontName_SloganLb size:fontSize_SloganLb];
   
    // Check the value of variables (for security)
    if (!fontSize_SloganLb){
        fontSize_SloganLb = (IDIOM == IPHONE) ? 10.f : 20.f;
    }
    if (!fontForSloganLbl){
        fontForSloganLbl = [UIFont fontWithName:@"IBMPlexSerif-Regular" size:fontSize_SloganLb];
    }
    self.text =  vm.model_cell.subLabelText;
    self.font = fontForSloganLbl;
}

- (void) resizeByCell:(IHWelcomeStaticCell*) cell{
    self.frame = [self recalculateNewSizeByCell:cell];
}

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell
{
    float y = CGRectGetMaxY(cell.appNameLbl.frame)+vertOffsetBtns;
    float widthSloganLbl  =  CGRectGetWidth(cell.contentView.frame)-offset*2;
    float heightSloganLbl = [self.text heightForWidth: widthSloganLbl font: self.font];
    return CGRectMake(offset, y, widthSloganLbl, heightSloganLbl);
}


@end











