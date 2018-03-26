//
//  IHPlaceholderView.h
//  IHWelcomTVC
//
//  Created by Uber on 26/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class IHWelcomeStaticCell;
@class IHWelcomeStaticCell_ViewModel;


@interface IHPlaceholderView : UIView

@property (weak, nonatomic) IHWelcomeStaticCell* parentCell;

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell;


- (void) resizeByCell:(IHWelcomeStaticCell*) cell;
- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm;
- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell;

@end
