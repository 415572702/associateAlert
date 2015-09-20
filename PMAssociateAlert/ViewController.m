//
//  ViewController.m
//  PMAssociateAlert
//
//  Created by PeiZiming on 15/9/20.
//  Copyright (c) 2015年 PZM. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

static void *PZMAssociatedKey = @"PZMAssociatedKey";
@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"1" message:@"2" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"continue", nil];
    
    __weak ViewController *weakSelf = self;
    void (^block) (NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [weakSelf doCancel];
        } else {
            [weakSelf doContinue];
        }
    };
    
    objc_setAssociatedObject(alert, PZMAssociatedKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

- (void)doCancel
{
    NSLog(@"Ti=his is cancel");
}

- (void)doContinue
{
    NSLog(@"This is continue");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, PZMAssociatedKey);
    block(buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
