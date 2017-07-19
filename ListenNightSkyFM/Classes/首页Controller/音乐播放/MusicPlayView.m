//
//  MusicPlayView.m
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MusicPlayView.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
#import "MusicPlayViewController.h"
#import "AppDelegate+Common.h"
@implementation MusicPlayView {

    NSMutableArray * _musicArray;
    NSTimer * _timer;
    UIImageView * _imageView;
    
}

+ (MusicPlayView *)shareMusicPlayView {
    static MusicPlayView * musciPlayView = nil;
    @synchronized(self) {
        if (musciPlayView == nil) {
            musciPlayView = [[MusicPlayView alloc]initWithFrame:CGRectMake(SCREENWIDTH - 50, 12, 50, 50)];
        }
    }
    return musciPlayView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self createAnimation];
    }
    return self;
}

- (void)createAnimation {
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"音乐按钮1.jpg"];
    _imageView.tag = 333;
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * gtr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMusicController:)];
    [_imageView addGestureRecognizer:gtr];
    [self addSubview:_imageView];
       [self AnimationShow];

}
- (void)AnimationShow {
    _musicArray = [[NSMutableArray alloc]init];
    for (int i = 1; i<= 5; i++) {
        NSString * str = [NSString stringWithFormat:@"音乐按钮%d.jpg",i];
        UIImage * image = [UIImage imageNamed:str];
        [_musicArray addObject:image];
    }
    [self beginAnimations];
    
}

- (void)beginAnimations {
    _imageView.animationDuration = 1.3;
    _imageView.animationImages = _musicArray;
    _imageView.animationRepeatCount = 0;
}


- (void)gotoMusicController :(UITapGestureRecognizer *)gtr {
    MusicPlayViewController * mpVC = [MusicPlayViewController shareMusicMananger];
    
    AppDelegate * appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appdelegate pushNextController:mpVC];
}

- (void)startAnimations {

    [_imageView startAnimating];
}

- (void)stopAnimations {

    [_imageView stopAnimating];
}

@end
