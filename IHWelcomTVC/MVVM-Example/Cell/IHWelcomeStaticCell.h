//
//  IHWelcomeStaticCell.h
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// UI
@class IHBackgroundImgView;
@class IHBlurView;

@class IHAppNameLbl;
@class IHSloganLbl;

@class IHLearnMoreBtn;
@class IHSkipOnBoardingBtn;

// ViewModel
@class IHWelcomeStaticCell_ViewModel;
// Model
@class IHWelcomeStaticCell_Model;


#define offset 25.f
#define vertOffsetBtns 15.f

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define IPHONE   UIUserInterfaceIdiomPhone


@interface IHWelcomeStaticCell : UITableViewCell

// ViewModel
@property (nonatomic, strong) IHWelcomeStaticCell_ViewModel* vm_cell;

@property (nonatomic, strong) IHBackgroundImgView* backgroundImgView;
@property (nonatomic, strong) UIBlurEffect*        blurEffect;
@property (nonatomic, strong) IHBlurView*          blurView;

@property (nonatomic, strong) IHAppNameLbl* appNameLbl;
@property (nonatomic, strong) IHSloganLbl*  sloganLbl;

@property (nonatomic, strong) IHLearnMoreBtn*      learnMoreBtn;
@property (nonatomic, strong) IHSkipOnBoardingBtn* skipOnBoardBtn;


- (instancetype) initWithViewModel:(IHWelcomeStaticCell_ViewModel*) vm;

@end

