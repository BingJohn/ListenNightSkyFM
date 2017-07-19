//
//  MusicPlayView.h
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicPlayView : UIView

+ (MusicPlayView *)shareMusicPlayView;

- (void)startAnimations;

- (void)stopAnimations;

@end
