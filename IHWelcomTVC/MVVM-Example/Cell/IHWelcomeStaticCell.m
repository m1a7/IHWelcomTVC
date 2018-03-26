//
//  IHWelcomeStaticCell.m
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHWelcomeStaticCell.h"
// Native framework
#import <MessageUI/MessageUI.h>

// Thrid-party fraemwork
#import <SDWebImage/UIImageView+WebCache.h>

// Own custom UI-Elements
#import "IHPlaceholderView.h"

#import "IHBackgroundImgView.h"
#import "IHBlurView.h"

#import "IHAppNameLbl.h"
#import "IHSloganLbl.h"

#import "IHLearnMoreBtn.h"
#import "IHSkipOnBoardingBtn.h"

// UI Utilites
#import "IHUIUtilites.h"

// ViewModel
#import "IHWelcomeStaticCell_ViewModel.h"

@interface IHWelcomeStaticCell ()

@property (strong, nonatomic) IHPlaceholderView* placeholderView;

@end

@implementation IHWelcomeStaticCell

#pragma mark - Life cycle

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
        // Before downloading image and render picture. We show some "placeholderView"
        self.placeholderView     = [[IHPlaceholderView  alloc] initWithParentCell:self];
        [self.contentView addSubview:self.placeholderView];

        // Setting ViewModel. And in Setter(setVm_cell) will begin download from server
        self.vm_cell = vm;      
    }
    return self;
}

#pragma mark - Setters

- (void) setFrame:(CGRect)frame{
  [super setFrame:frame];
}

/*
 This is the overridden setter of our viewModel.
 If it already has a data model, then the -prepareCellForDisplay: method is immediately called.
 If not, then will occur downloading from server with help method -getWelcomScreenDataFromURL:
*/
- (void) setVm_cell:(IHWelcomeStaticCell_ViewModel *)vm_cell
{
        _vm_cell = vm_cell;
    if (_vm_cell.model_cell)
    {
      [self prepareCellForDisplay:self];
    } else {
        __weak IHWelcomeStaticCell* bself = self;
        [_vm_cell getWelcomScreenDataFromURL: _vm_cell.urlUIConfig
                                   onSuccess:^(BOOL successOperation) {
                                       
                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                               [bself prepareCellForDisplay:bself];
                                           });
                                   }
                                   onFailure:^(NSError *errorBlock, NSObject *errObj) {
                                       [IHUIUtilites showOkeyAlertVC:@"Error" msg:@"Restart app and check your internet connection"];
                                   }];
    }
}

#pragma mark - Work with UI (Init/Prepare/Update/Delete/Adding ect...)
/*
 This method is needed in order not to duplicate the code in -setVm_cell.
 In General, it performs the necessary actions to correctly display the cell on the screen.
 For example:
        1. Init subview by the decision of the viewmodel
        2. Add them on contentView
        3. Update them UI (that is setting color/font/corenerRadius ect...)
        4. Resize after getting content
        5. Removing placeholderView
*/
- (void) prepareCellForDisplay:(IHWelcomeStaticCell*) cell
{
    [cell initUISubviews: cell.vm_cell];
    [cell addSubviewsOnContentView];
    [cell updateUI:cell.vm_cell];
    [cell resizeSubviews];
    [cell.placeholderView removeFromSuperview];
    cell.placeholderView = nil;
}

/*
 In this method, we also call recalculating coordinates.
 Because when you flip the screen, the resolution changes.
 And all subview will need new positions and sizes.
*/
-(void) layoutSubviews{
    [super layoutSubviews];
    [self  resizeSubviews];
}

/*
  Here we call the method of the recalculation of the coordinates
  of each subview which implements the method -resizeByCell:
*/
- (void) resizeSubviews {

    for (id subview in self.contentView.subviews){
        if ([subview respondsToSelector:@selector(resizeByCell:)]){
            [subview resizeByCell:self];
        }
    }
}

/*
  Here we check "Isn't our suview  a nil". If it is real object.
  Then we add it on subview to self.contentView
*/
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

/*
 Here we initialize all subview by the decision of the viewmodel.
 For example:
   1. If viewModel store bool (TRUE) var turnBlur. Then we will initialize blurView.
   2. ect...
*/
- (void) initUISubviews:(IHWelcomeStaticCell_ViewModel*) vm
{
    if (self.contentView){
        // Decide will gif picture or normal ?!
        if (vm.model_cell.backgroundImgURL.length > 0) {
            self.backgroundImgView    = [[IHBackgroundImgView alloc] initWithParentCell:self];
        }
        // Decide will blur effect ?!
        if (vm.model_cell.backgroundImgTurnBlur){
            if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.blurView    = [[IHBlurView  alloc] initWithParentCell:self];
            }
        }
        self.appNameLbl     = [[IHAppNameLbl        alloc] initWithParentCell:self];
        self.sloganLbl      = [[IHSloganLbl         alloc] initWithParentCell:self];
        self.skipOnBoardBtn = [[IHSkipOnBoardingBtn alloc] initWithParentCell:self];
        self.learnMoreBtn   = [[IHLearnMoreBtn      alloc] initWithParentCell:self];
    }
}

/*
 Here call from each subview method -updateUIbyCell.
 This method make all UI-setup work. For example:
   1. SetOrUpdate font
   2. SetOrUpdate color
   3. SetOrUpdate size
   4. ect....
*/
- (void) updateUI:(IHWelcomeStaticCell_ViewModel*) vm
{
    if (vm){
        for (id subview in self.contentView.subviews){
            if ([subview respondsToSelector:@selector(updateUIbyCell:withCellViewModel:)]){
                [subview updateUIbyCell:self withCellViewModel:self.vm_cell];
            }
        }
    }
}


@end

