//
//  IHWelcomeStaticCell-ViewModel.m
//  IHWelcomTVC
//
//  Created by Uber on 21/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHWelcomeStaticCell_ViewModel.h"

#import <FastEasyMapping/FEMDeserializer.h>

@implementation IHWelcomeStaticCell_ViewModel

/*
 Init all require components (arrays,object ect..) before using
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}

- (instancetype) initWithMockupModel:(IHWelcomeStaticCell_Model*) model
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype) initWithUIConfigByURL:(NSString*) url
{
    self = [super init];
    if (self) {
        self.urlUIConfig = url;
    }
    return self;
}


#pragma mark - Work with API

- (void) getWelcomScreenDataFromURL:(NSString*) url
                          onSuccess:(void(^)(BOOL successOperation)) success
                          onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure
{
    #warning переписать на nsoperationQueue
    // LOAD JSON.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"IHWelcomeJSON" ofType:@"json"];
        NSData *data   = [NSData dataWithContentsOfFile:path];
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        if (jsonDict) {
            self.model_cell  = [self parseWithMapping:jsonDict andClassModel:[IHWelcomeStaticCell_Model class]];
            (self.model_cell) ? success(self.model_cell != nil) : failure(nil, nil);
        } else {
           failure(nil, nil);
              }
    });
}


#warning Transfer to serverManger
- (id) parseWithMapping:(NSDictionary*) responDict andClassModel:(Class) modelClass {

    if ([modelClass isSubclassOfClass:[IHWelcomeStaticCell_Model class]]) {
        
        FEMMapping *mapping              = [IHWelcomeStaticCell_Model defaultMapping];
        IHWelcomeStaticCell_Model* model = [FEMDeserializer objectFromRepresentation:responDict mapping: mapping];
        return model;
    }
  return nil;
}

@end
