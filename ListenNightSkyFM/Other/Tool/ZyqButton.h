//
//  ZyqButton.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Fmtype,
    LessonType,
    DiantaiType,
    NewFMAuthor
} ButtonType;
@interface ZyqButton : UIButton

-(instancetype)initWithFrame:(CGRect)frame WithTitle :(NSString *)title WithType:(ButtonType)type;

@end
