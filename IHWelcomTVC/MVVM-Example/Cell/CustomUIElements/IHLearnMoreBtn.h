//
//  IHLearnMoreBtn.h
//  IHWelcomTVC
//
//  Created by Uber on 19/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IHWelcomeStaticCell;
@class IHWelcomeStaticCell_ViewModel;

@interface IHLearnMoreBtn : UIButton

@property (weak, nonatomic) IHWelcomeStaticCell* parentCell;

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell;

- (void) resizeByCell:(IHWelcomeStaticCell*) cell;
- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm;
- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell;

@end
