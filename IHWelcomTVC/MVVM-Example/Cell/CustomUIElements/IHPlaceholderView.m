//
//  IHPlaceholderView.m
//  IHWelcomTVC
//
//  Created by Uber on 26/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHPlaceholderView.h"
#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

@implementation IHPlaceholderView

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [super init];
    if (self) {
        self.parentCell = pCell;
        
        self.backgroundColor = [UIColor redColor];
        self.alpha = 0.7;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void) setFrame:(CGRect)frame{
   [super setFrame:frame];
}

- (void) resizeByCell:(IHWelcomeStaticCell*) cell{
    self.frame = [self recalculateNewSizeByCell:cell];
}

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell {
    return cell.contentView.frame;
}

- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm {
    
}

@end


