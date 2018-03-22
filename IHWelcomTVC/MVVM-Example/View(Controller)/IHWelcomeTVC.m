//
//  IHWelcomeTVC.m
//  IHWelcomTVC
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "IHWelcomeTVC.h"

#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>

#import <SDWebImage/UIImageView+WebCache.h>

// Cell
#import "IHWelcomeStaticCell.h"
// Cell - ViewModel
#import "IHWelcomeStaticCell_ViewModel.h"
// Cell - Model
#import "IHWelcomeStaticCell_Model.h"

@interface IHWelcomeTVC ()

@property (strong, nonatomic) IHWelcomeStaticCell* welcomeCell;

@end

@implementation IHWelcomeTVC

// Configure our cell
- (void)loadView{
    [super loadView];
   
    IHWelcomeStaticCell_ViewModel* vm_cell = [[IHWelcomeStaticCell_ViewModel alloc] initWithUIConfigByURL:@"linkOnGIT"];
    // or
    // IHWelcomeStaticCell_ViewModel* vm_cell = [[IHWelcomeStaticCell_ViewModel alloc] initWithMockupModel:[IHWelcomeStaticCell_Model defaultMockup]];
    self.welcomeCell  = [[IHWelcomeStaticCell alloc] initWithViewModel:vm_cell];
    
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Hide keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
        self.edgesForExtendedLayout               = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars     = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(self.view.frame);
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)  return self.welcomeCell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       [tableView deselectRowAtIndexPath:indexPath animated:false];
}

#pragma mark - Actions

-(void)dismissKeyboard{
    [self.view endEditing:YES];
}

@end
