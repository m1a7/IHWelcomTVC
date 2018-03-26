//
//  IHAppNameLbl.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHAppNameLbl.h"

#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

#import "IHAppNameLbl.h"

// Category for calculate height
#import "UILabel+Utility.h"

// Utilites
#import "IHUIUtilites.h"


@implementation IHAppNameLbl

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [super init];
    if (self) {
        self.parentCell = pCell;
        
        self.numberOfLines = 0;
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        self.textAlignment      = NSTextAlignmentCenter;
    }
    return self;
}


- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];

    if (self.parentCell){
     __weak IHAppNameLbl* bself = self;
     [IHUIUtilites gradientFromColorArrayColors:self.parentCell.vm_cell.model_cell.mainLabelBackgroundColors
                                                           withHeight:CGRectGetHeight(frame)
                                                                block:^(UIColor* gradient) {
                                                                    bself.backgroundColor = gradient;
                                                                }];
        [IHUIUtilites gradientFromColorArrayColors: self.parentCell.vm_cell.model_cell.mainLabelFontColors
                                        withHeight:CGRectGetHeight(frame)
                                             block:^(UIColor* gradient) {
                                                 bself.textColor = gradient;
                                             }];
    }
}


- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    NSString* fontName_AppNameLbl = vm.model_cell.mainLabelFontName;
    float     fontSize_AppNameLbl = (IDIOM == IPHONE) ? vm.model_cell.mainLabelFontSize_iPhone : vm.model_cell.mainLabelFontSize_iPad;
    UIFont*   fontForAppNameLbl = [UIFont fontWithName:fontName_AppNameLbl size:fontSize_AppNameLbl];
    // Check the value of variables (for security)
    if (!fontSize_AppNameLbl){
        fontSize_AppNameLbl = (IDIOM == IPHONE) ? 20.f : 40.f;
    }
    if (!fontForAppNameLbl){
        fontForAppNameLbl = [UIFont fontWithName:@"IBMPlexSerif-Medium" size:fontSize_AppNameLbl];
    }
    self.text = vm.model_cell.mainLabelText;
    self.font = fontForAppNameLbl;
}

- (void) resizeByCell:(IHWelcomeStaticCell*) cell {
    self.frame = [self recalculateNewSizeByCell:cell];
}

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell
{
    float x = offset;
    float y = offset*2;
    float widthAppNameLbl  =  CGRectGetWidth(cell.contentView.frame)-offset*2;
    float heightAppNameLbl = [self.text heightForWidth: widthAppNameLbl font:self.font];
    return CGRectMake(x, y, widthAppNameLbl, heightAppNameLbl);
}

@end












