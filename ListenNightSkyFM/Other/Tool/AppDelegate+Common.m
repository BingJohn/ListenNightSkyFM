//
//  AppDelegate+Common.m
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "AppDelegate+Common.h"

@implementation AppDelegate (Common)

- (void)pushNextController:(id)Controller {
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.nvc.view.layer addAnimation:animation forKey:nil];
    
    [self.nvc pushViewController:Controller animated:YES];

}

@end
