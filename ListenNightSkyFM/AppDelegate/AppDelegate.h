//
//  AppDelegate.h
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadViewController.h"
#import "NavigationViewController.h"
typedef enum : NSUInteger {
    noNet,
    yesNet
} NetState;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NavigationViewController * nvc;
@property (nonatomic, assign) NetState netState;

@end

