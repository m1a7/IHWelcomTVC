//
//  IHWelcomeStaticCell-ViewModel.h
//  IHWelcomTVC
//
//  Created by Uber on 21/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IHWelcomeStaticCell_Model.h"

@interface IHWelcomeStaticCell_ViewModel : NSObject

@property (nonatomic, strong) IHWelcomeStaticCell_Model* model_cell;
@property (nonatomic, strong) NSString* urlUIConfig;


+ (NSString*) getCorrectURLbyLocation:(NSString*) url;

- (instancetype) initWithUIConfigByURL:(NSString*) url;
- (instancetype) initWithMockupModel:(IHWelcomeStaticCell_Model*) model;

- (void) getWelcomScreenDataFromURL:(NSString*) url
              onSuccess:(void(^)(BOOL successOperation)) success
              onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure;


@end
