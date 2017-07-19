//
//  WFDownLoad.m
//  WFDownLoader
//
//  Created by JackWong on 15/11/24.
//  Copyright © 2015年 JackWong. All rights reserved.
//

#import "WFDownLoad.h"
#import "NSString+Down.h"


@interface WFDownLoad ()<NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    //网络请求类
    NSURLConnection *_urlConnection;
    //文件读写类
    NSFileHandle *_fileHandle;
    // 文件的下载地址
    NSString *_fileURL;
    //文件下载的一个偏移量(文件下载了多少)
    unsigned long long _fileOffSet;
    //文件的总长度
    unsigned long long _totalFileSize;
    //最终的文件路径
    NSString *_destinationPath;
    //临时文件路径
    NSString *_tempFilePath;
    //如果文件已经存在是否允许覆盖
    BOOL _overFile;
    
    
    
}
@property (nonatomic, weak) id<WFDownLoadDelegate> delegate;
@property (nonatomic, copy) DownLoadStart startBlock;
@property (nonatomic, copy) DownLoading loadingBlock;
@property (nonatomic, copy) DownLoadFinish finishBlock;
@property (nonatomic, copy) DownLoadFaild faildBlock;

@end


@implementation WFDownLoad
//以 block 的形式进行初始化
- (instancetype)initWithURL:(NSString *)downLoadURL startBlock:(DownLoadStart)startBlock loadingBlock:(DownLoading)loadingBlock finishBlock:(DownLoadFinish)finishBlock faildBlock:(DownLoadFaild)faildBlock overFile:(BOOL)overFile{
    self = [super init];
    if (self) {
        _fileURL = downLoadURL;
        _startBlock = startBlock;
        _loadingBlock = loadingBlock;
        _finishBlock = finishBlock;
        _faildBlock = faildBlock;
        _overFile = overFile;
    }
    return self;
    
}


- (instancetype)initWithURL:(NSString *)downLoadURL delegate:(id<WFDownLoadDelegate>)delegate overFile:(BOOL)overFile {
    self = [super init];
    if (self) {
        _fileURL = downLoadURL;
        _delegate = delegate;
        _overFile = overFile;
        
    }
    return self;
}

- (void)start {
    
    if (!_fileURL) {
         NSError *error = [NSError errorWithDomain:@"Download URL can not nil!" code:1000 userInfo:nil];
        
        if (_delegate && [_delegate respondsToSelector:@selector(downLoadFaild:faildError:)]) {
        [_delegate downLoadFaild:self faildError:error];
        }
        
        if (_faildBlock) {
            
            _faildBlock(self,error);
        }
        
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 获取沙盒的目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = paths[0];

    // 下载文件存放的路径
    NSString *targetPath = [NSString stringWithFormat:@"%@/%@",document,@"com.iluckly.download"];
    // 如果下载路径的文件夹不存在就创建
    if (![fileManager fileExistsAtPath:targetPath]) {
        // 创建文件夹路径
       BOOL createDirectorySuc = [fileManager createDirectoryAtPath:targetPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        if (!createDirectorySuc) {
            NSError *error = nil;
            error = [NSError errorWithDomain:@"Create Directory failed!!" code:1001 userInfo:nil];
            if (_delegate && [_delegate respondsToSelector:@selector(downLoadFaild:faildError:)]) {
                [_delegate downLoadFaild:self faildError:error];
            }
            if (_faildBlock) {
                _faildBlock(self,error);
            }
            
            return;
        }
    }
    //获取文件后缀名
//    NSString *fileExtension = [_fileURL pathExtension];
    //生成文件名, URL 是唯一 md5 之后唯一
    NSString *fileName = [_fileURL MD5Hash];
    // 生成文件的最终位置
    _destinationPath = [NSString stringWithFormat:@"%@/%@.mp3",targetPath,fileName];
//                        fileExtension];
    //是否允许覆盖
    if (_overFile) {
        if ([fileManager fileExistsAtPath:_destinationPath]) {
            NSError *error = nil;
            BOOL deleteSuc = [fileManager removeItemAtPath:_destinationPath error:&error];
            NSLog(@"%@",[error description]);
            if (deleteSuc) {
                NSLog(@"删除成功");
            }
        }
        
    }
    
    if ([fileManager fileExistsAtPath:_destinationPath]) {
        _progress = 1.0;
        if (_delegate && [_delegate respondsToSelector:@selector(downLoadDidFinish:filePath:)]) {
            [_delegate downLoadDidFinish:self filePath:_destinationPath];
        }
        if (_finishBlock) {
            _finishBlock(self,_destinationPath);
        }
        if (_loadingBlock) {
            _loadingBlock(self,_progress);
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(downLoad:progressChanaged:)]) {
            [_delegate downLoad:self progressChanaged:1.0];
        }
        return;
    }
    
    // 创建临时文件路径
    _tempFilePath = [NSString stringWithFormat:@"%@/%@",targetPath,[_fileURL MD5Hash]];
    //判断临时文件是否存在 不存在的话就创建
    if (![fileManager fileExistsAtPath:_tempFilePath]) {
        // 创建临时文件
       BOOL isTempFileSuc =[fileManager createFileAtPath:_tempFilePath contents:nil attributes:nil];
        if (!isTempFileSuc) {
            NSError *error = [NSError errorWithDomain:@"Create  tempFile faild!!" code:1002 userInfo:nil];
            
            if (_delegate && [_delegate respondsToSelector:@selector(downLoadFaild:faildError:)]) {
                
                [_delegate downLoadFaild:self faildError:error];
            }
            if (_faildBlock) {
                _faildBlock(self, error);
            }
            
            return;
        }
    }
    
    [_fileHandle closeFile];
    // 根绝临时文件路径创建文件句柄
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:_tempFilePath];
    //移动文件的末尾
    _fileOffSet = [_fileHandle seekToEndOfFile];
    
    // 创建可变的 request 的对象
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_fileURL]];
    // 设置从哪儿开始下载
    NSString *rang = [NSString stringWithFormat:@"bytes=%llu-",_fileOffSet];
    //给 httprequest 设置 range
    [mutableRequest addValue:rang forHTTPHeaderField:@"Range"];
    _urlConnection = [[NSURLConnection alloc] initWithRequest:mutableRequest delegate:self startImmediately:YES];
}
/**
 *   文件开始下载代理(首包时间)
 *
 *  @param connection
 *  @param response
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response expectedContentLength] != NSURLResponseUnknownLength) {
        //expectedContentLength 每次需要下载的文件长度
        _totalFileSize = [response expectedContentLength] + _fileOffSet;
    }
    //开始下载
    if (_delegate && [_delegate respondsToSelector:@selector(downLoadStart:)]) {
        [_delegate downLoadStart:self];
    }
    if (_startBlock) {
        _startBlock(self);
    }
    
}
/**
 *  获取到文件的数据(部分)
 *
 *  @param connection
 *  @param data
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //把接收到的文件写入本地
    [_fileHandle writeData:data];
    //把光标移到文件的末尾
    _fileOffSet= [_fileHandle offsetInFile];
    //时时计算文件的下载进度
    _progress = (double)_fileOffSet/_totalFileSize;
    
    if (_delegate && [_delegate respondsToSelector:@selector(downLoad:progressChanaged:)]) {
        [_delegate downLoad:self progressChanaged:_progress];
    }
    if (_loadingBlock) {
        _loadingBlock(self,_progress);
    }
    
}
/**
 *  下载完成
 *
 *  @param connection
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // 关掉文件句柄
    [_fileHandle closeFile];
    BOOL isDownLoadSuccess = [[NSFileManager defaultManager] moveItemAtPath:_tempFilePath toPath:_destinationPath error:nil];
    //移动临时文件到目标文件
    if (isDownLoadSuccess) {
        if (_delegate && [_delegate respondsToSelector:@selector(downLoadDidFinish:filePath:)]) {
            [_delegate downLoadDidFinish:self filePath:_destinationPath];
        }
        if (_finishBlock) {
            _finishBlock(self,_destinationPath);
        }
        
    }
}
/**
 *  下载失败
 *
 *  @param connection
 *  @param error
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(downLoadFaild:faildError:)]) {
        [_delegate downLoadFaild:self faildError:error];
    }
    if (_faildBlock) {
        _faildBlock(self,error);
    }
    
}

- (void)stop {
    // 取消下载数据
    [_urlConnection cancel];
    _urlConnection = nil;
    
    //关掉文件读写
    [_fileHandle closeFile];
    _fileHandle = nil;
}

- (void)clean {
    
    [self stop];
    
    [[NSFileManager defaultManager] removeItemAtPath:_tempFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:_destinationPath error:nil];
    
}

- (void)cleanWithPath:(NSString *)path {

    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


@end
