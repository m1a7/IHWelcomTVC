//
//  IHWelcomeStaticCell.h
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// UI
@class IHLearnMoreBtn;
@class FLAnimatedImage;
@class FLAnimatedImageView;

// ViewModel
@class IHWelcomeStaticCell_ViewModel;
// Model
@class IHWelcomeStaticCell_Model;



@interface IHWelcomeStaticCell : UITableViewCell
// ViewModel
@property (nonatomic, strong) IHWelcomeStaticCell_ViewModel* vm_cell;

// UI
@property (nonatomic, strong) FLAnimatedImageView* backgroundImgView;

@property (nonatomic, strong) UIBlurEffect*       blurEffect;
@property (nonatomic, strong) UIVisualEffectView* blurView;

@property (nonatomic, strong) UILabel* appNameLbl;
@property (nonatomic, strong) UILabel* sloganLbl;

@property (nonatomic, strong) IHLearnMoreBtn* learnMoreBtn;
@property (nonatomic, strong) UIButton* skipOnBoardBtn;


- (instancetype) initWithViewModel:(IHWelcomeStaticCell_ViewModel*) vm;

@end

