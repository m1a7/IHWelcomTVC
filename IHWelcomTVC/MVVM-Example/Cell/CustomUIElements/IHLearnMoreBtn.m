//
//  IHLearnMoreBtn.m
//  IHWelcomTVC
//
//  Created by Uber on 19/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHLearnMoreBtn.h"

@implementation IHLearnMoreBtn

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
     self.layer.cornerRadius  = CGRectGetWidth(self.frame)/CGRectGetHeight(self.frame);
}


- (void) setHighlighted:(BOOL)highlighted
{
    if (self.userInteractionEnabled && highlighted) {

    // Перенести потом в таргет
    [UIView animateWithDuration:0.15
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (self.userInteractionEnabled){
                             self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                             self.alpha = 0.5f;
                             [self setUserInteractionEnabled:NO];
                         }
                      
                     } completion:^(BOOL finished) {
                         
                       
                         [UIView animateWithDuration:0.15f
                                          animations:^{
                                              if (!self.userInteractionEnabled){
                                                  self.transform = CGAffineTransformIdentity;
                                                  self.alpha = 1.f;
                                                  [self setUserInteractionEnabled:YES];
                                              }
                                          }];
                         
                         
                     }];
    }
}





@end
