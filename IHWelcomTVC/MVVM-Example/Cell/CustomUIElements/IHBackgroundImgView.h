//
//  IHBackgroundImgView.h
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <FLAnimatedImage/FLAnimatedImage.h>

@class IHWelcomeStaticCell;
@class IHWelcomeStaticCell_ViewModel;

@interface IHBackgroundImgView : FLAnimatedImageView

@property (weak, nonatomic) IHWelcomeStaticCell* parentCell;

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell;


- (void) resizeByCell:(IHWelcomeStaticCell*) cell;
- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm;
- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell;


@end
