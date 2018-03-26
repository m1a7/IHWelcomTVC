//
//  IHBlurView.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHBlurView.h"

#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

@implementation IHBlurView


- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [super init];
    if (self) {
        self.parentCell = pCell;
    }
    return self;
}


- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
     self.layer.cornerRadius  = CGRectGetWidth(self.frame)/CGRectGetHeight(self.frame);
}

- (void) resizeByCell:(IHWelcomeStaticCell*) cell{
    self.frame = [self recalculateNewSizeByCell:cell];
}

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell {
    return cell.contentView.frame;
}

- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    if (vm.model_cell.backgroundImgTurnBlur){
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            
            cell.blurEffect  = [UIBlurEffect effectWithStyle:vm.model_cell.backgroundImgBlurType];
            __weak IHWelcomeStaticCell* bself = cell;
           
            [UIView animateWithDuration:0.7 animations:^{
                bself.blurView.alpha     = vm.model_cell.backgroundImgBlurRadiusOrAlpha;
                bself.blurView.effect    = bself.blurEffect;
            }];
            self.frame   = cell.contentView.frame;
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    }
}

@end














