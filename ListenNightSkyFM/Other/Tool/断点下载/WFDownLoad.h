//
//  WFDownLoad.h
//  WFDownLoader
//
//  Created by JackWong on 15/11/24.
//  Copyright © 2015年 JackWong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WFDownLoad;
//Block
typedef void(^DownLoadStart)(WFDownLoad *download);
typedef void(^DownLoading)(WFDownLoad *download, double progressValue);
typedef void(^DownLoadFinish)(WFDownLoad *download,NSString *filePath);
typedef void(^DownLoadFaild)(WFDownLoad *downLoad, NSError *faildError);


@protocol WFDownLoadDelegate <NSObject>
@optional
- (void)downLoadStart:(WFDownLoad *)downLoad;
- (void)downLoad:(WFDownLoad *)downLoad progressChanaged:(double)progressValue;
- (void)downLoadDidFinish:(WFDownLoad *)downLoad filePath:(NSString *)filePath;
- (void)downLoadFaild:(WFDownLoad *)downLoad faildError:(NSError *)faildError;
@end

@interface WFDownLoad : NSObject
/**
 *  下载进度
 */
@property (nonatomic, assign, readonly) double progress;


- (instancetype)initWithURL:(NSString *)downLoadURL
                 startBlock:(DownLoadStart)startBlock
               loadingBlock:(DownLoading)loadingBlock
                finishBlock:(DownLoadFinish)finishBlock
                 faildBlock:(DownLoadFaild)faildBlock
                   overFile:(BOOL)overFile;


- (instancetype)initWithURL:(NSString *)downLoadURL delegate:(id<WFDownLoadDelegate>)delegate overFile:(BOOL)overFile;

- (void)start;

- (void)stop;

- (void)clean;

- (void)cleanWithPath:(NSString *)path;

@end
