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
        self.model_cell = model;
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
    __weak IHWelcomeStaticCell_ViewModel* bself = self;
    NSURL* jsonURL = [NSURL URLWithString:url];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession              *session       = [NSURLSession sessionWithConfiguration:sessionConfig];

    NSURLSessionDownloadTask *downloadJSONTask = [session
                                                   downloadTaskWithURL:jsonURL
                                                   completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       
           NSLog(@"downloadJSONTask -[NSThread isMainThread] = %@", ([NSThread isMainThread]) ? @"YES": @"NO");
           NSData* dataJSON =  [NSData dataWithContentsOfURL:location];
           
           if (dataJSON) {
               // Load from Network
               NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:dataJSON options:kNilOptions error:nil];
               bself.model_cell       = [self parseWithMapping:jsonDict andClassModel:[IHWelcomeStaticCell_Model class]];
        
           } else {
                    // Load local copy
                    bself.model_cell = [bself localOfflineVersionOfJSON];
                   }
           (bself.model_cell) ? success(bself.model_cell != nil) : failure(nil, nil);
                                                       
    }];
    [downloadJSONTask resume];
}

- (IHWelcomeStaticCell_Model*) localOfflineVersionOfJSON
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IHWelcomeJSON" ofType:@"json"];
    NSData *data   = [NSData dataWithContentsOfFile:path];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    IHWelcomeStaticCell_Model* localModel = nil;
    if (jsonDict) {
        localModel = [self parseWithMapping:jsonDict andClassModel:[IHWelcomeStaticCell_Model class]];
    }
    return  localModel;
}



- (id) parseWithMapping:(NSDictionary*) responDict andClassModel:(Class) modelClass {

    if ([modelClass isSubclassOfClass:[IHWelcomeStaticCell_Model class]]) {
        
        FEMMapping *mapping              = [IHWelcomeStaticCell_Model defaultMapping];
        IHWelcomeStaticCell_Model* model = [FEMDeserializer objectFromRepresentation:responDict mapping: mapping];
        return model;
    }
  return nil;
}


+ (NSString*) getCorrectURLbyLocation:(NSString*) url
{
    // NSString *languageCode = [[NSLocale preferredLanguages] firstObject];
    // NSString* convertURL = [NSString stringWithFormat:@"https://raw.githubusercontent.com/m1a7/IHWelcomTVC/master/IHWelcomTVC/JSON/%@/IHWelcomeJSON.json", languageCode];
    return url;
}
@end
