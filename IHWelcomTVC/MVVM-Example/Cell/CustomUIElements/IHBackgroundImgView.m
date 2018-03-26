//
//  IHBackgroundImgView.m
//  IHWelcomTVC
//
//  Created by Uber on 25/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHBackgroundImgView.h"

#import "IHWelcomeStaticCell.h"
#import "IHWelcomeStaticCell_ViewModel.h"

@implementation IHBackgroundImgView

- (instancetype)initWithParentCell:(IHWelcomeStaticCell*) pCell
{
    self = [super init];
    if (self) {
        self.parentCell = pCell;
        
        self.contentMode      = UIViewContentModeScaleAspectFill;
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

- (CGRect) recalculateNewSizeByCell:(IHWelcomeStaticCell*) cell{
    return cell.contentView.frame;
}


- (void) updateUIbyCell:(IHWelcomeStaticCell*) cell withCellViewModel:(IHWelcomeStaticCell_ViewModel*) vm
{
    if (vm.model_cell.backgroundImgURL.length > 0){
        __weak IHWelcomeStaticCell* bself = cell;
        
        NSURL* imgURL = [NSURL URLWithString: vm.model_cell.backgroundImgURL];
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        
        NSURLSessionDownloadTask *downloadPhotoTask = [session
                                                       downloadTaskWithURL:imgURL
                                                       completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
               NSData* data =  [NSData dataWithContentsOfURL:location];
               if (data) {
                   dispatch_sync(dispatch_get_main_queue(), ^{
                       NSLog(@"updateUI downloadPhotoTask -[NSThread isMainThread] = %@", ([NSThread isMainThread]) ? @"YES": @"NO");
                       // GIF support
                       if ([imgURL.absoluteString rangeOfString:@".gif"].location != NSNotFound) {
                           FLAnimatedImage* animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
                           bself.backgroundImgView.animatedImage = animatedImage;
                       }  // Another type support
                       else {
                           UIImage* image = [UIImage imageWithData:data];
                           bself.backgroundImgView.image = image;
                       }
                   });
               }
                                                       }];
        [downloadPhotoTask resume];
    }
}

@end



