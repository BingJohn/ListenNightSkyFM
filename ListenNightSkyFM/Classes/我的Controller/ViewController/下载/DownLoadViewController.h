//
//  DownLoadViewController.h
//  FMMusic
//
//  Created by zyq on 16/1/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotFmModel;
typedef void(^DownLoadSuccessedBlock)(BOOL isSuccessed);
@interface DownLoadViewController : UIViewController

- (void)beginDownloadWith:(HotFmModel *)hotModel WithBlock:(DownLoadSuccessedBlock)downLoadBlocl;

@end
