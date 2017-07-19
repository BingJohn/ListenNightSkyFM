//
//  MusicPlayViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/7.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
#import "AFSoundManager.h"
#import "AFAudioRouter.h"
#import "AppDelegate.h"
#import "MusicPlayTableView.h"
#import "MusicPlayView.h"
#import "UMSocial.h"
#import "DownLoadViewController.h"
#import "DBManager.h"
#define IMANGEWIDTH    SCREENWIDTH/2
#define PAUSHNAME  @"toolbar_pause_n_p"
//@"btn_chat_voice_playing_n"
//@"iconfont-zanting"
#define PLAYNAME  @"toolbar_play_n_p"
//@"btn_chat_voice_pause_n"
//@"iconfont-bofang-3"

#define LASTNAME @"toolbar_prev_n_p"
#define NEXTNAME @"toolbar_next_n_p"

#define SINGLE @"TTPlayerProgressBarThumb"
#define MANY   @"login_form_v_refresh"
@interface MusicPlayViewController ()<UMSocialUIDelegate> {
//    旋转的头像view
    UIImageView * _coverImageView;
//    背景图片
    UIImageView * _backImageView;
    MusicPlayView * _musicPlayView;
    

}
#define SHAREPIC @"wantShare1"
@property (nonatomic, strong) UISlider * slider;
@property  (nonatomic, copy)    NSString *   lastUrl;
@property (nonatomic, strong) UILabel * titleLable;
@property (nonatomic, strong)UIVisualEffectView * effectView;
@property (nonatomic, strong) UILabel * currentTimeLable;
@property (nonatomic, strong) UILabel * totalTimeLable;
@property (nonatomic, strong) UIButton * playButton;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) CABasicAnimation* rotationAnimation;
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, assign) BOOL isOne;
@property (nonatomic, strong) MusicPlayTableView * musicTableView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * downLoadButton;

@property (nonatomic, strong) UIImage * didImage;
@property (nonatomic, strong) UIImage * doingImage;
@end


@implementation MusicPlayViewController
//单例设计
+ (MusicPlayViewController *)shareMusicMananger {
    static MusicPlayViewController * musicMananger = nil;
    @synchronized(self) {
        if (musicMananger == nil) {
            musicMananger = [[MusicPlayViewController alloc]init];
        }
    }
    return musicMananger;
}
-(void)play{
  
    _lastUrl = _musicUrl;
    if (!_isPlay) {
        [_playButton setImage:[UIImage imageNamed:PAUSHNAME] forState:UIControlStateNormal];
    }else {
        [_playButton setImage:[UIImage imageNamed:PLAYNAME] forState:UIControlStateNormal];
    }
    HotFmModel * model = _musicList[_index];
    BOOL isDown = [[DBManager sharedManager]isExistAppForMusicAppId:model.id recordType:MusicDownType];
    if (isDown  && _isLocal == YES) {
        [[AFSoundManager sharedManager] stop];
        [[AFSoundManager sharedManager]startPlayingLocalFileWithName:model.url andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
            if (!error) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"mm:ss"];
                NSDate *startTimeData = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
                _currentTimeLable.text = [formatter stringFromDate:startTimeData];
                
                NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
                _totalTimeLable.text = [formatter stringFromDate:timeRemainingDate];
                if ([_totalTimeLable.text isEqualToString:@"00:00"] &&![_currentTimeLable.text isEqualToString:@"00:00"]&& (_index < _musicList.count-1)&& _isOne == NO) {
                    //
                    _index ++;
                    [self refreshMusic];
                    [self refreshTableView];
                }else if ([_totalTimeLable.text isEqualToString:@"00:00"] &&![_currentTimeLable.text isEqualToString:@"00:00"]&& (_index = _musicList.count-1)&& _isOne == NO) {
                    _index = 0;
                    [self refreshMusic];
                    [self refreshTableView];
                }
                else if ([_totalTimeLable.text isEqualToString:@"00:00"]&&![_currentTimeLable.text isEqualToString:@"00:00"] && _isOne ==YES) {
                    [[AFSoundManager sharedManager]restart];
                }
                _slider.value = percentage * 0.01;
                
            } else {
                NSLog(@"There has been an error playing the remote file: %@", [error description]);
            }

        }];
    }
    else {
        [[AFSoundManager sharedManager] stop];
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:self.musicUrl andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *startTimeData = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
            _currentTimeLable.text = [formatter stringFromDate:startTimeData];
            
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
            _totalTimeLable.text = [formatter stringFromDate:timeRemainingDate];
            if ([_totalTimeLable.text isEqualToString:@"00:00"] &&![_currentTimeLable.text isEqualToString:@"00:00"]&& (_index < _musicList.count-1)&& _isOne == NO) {
//                NSLog(@"循环播放");
                _index ++;
                [self refreshMusic];
                [self refreshTableView];
            }else if ([_totalTimeLable.text isEqualToString:@"00:00"] &&![_currentTimeLable.text isEqualToString:@"00:00"]&& (_index = _musicList.count-1)&& _isOne == NO) {
                _index = 0;
                [self refreshMusic];
                 [self refreshTableView];
            }
            else if ([_totalTimeLable.text isEqualToString:@"00:00"]&&![_currentTimeLable.text isEqualToString:@"00:00"] && _isOne ==YES) {
                [[AFSoundManager sharedManager]restart];
            }
            _slider.value = percentage * 0.01;
            
        } else {
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
    }];
    }
}


//创建返回按钮
- (void)createBackButton {
    
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
      
    }
    _backButton.frame = CGRectMake(10, 20, 27, 27);
    UIImage * image =[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_backButton setBackgroundImage:image forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(comeBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ]initWithCustomView:_backButton];
}
//返回按钮方法
- (void)comeBack :(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//title
- (void)createLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0,20, SCREENWIDTH, 25)];
    }
   
    _titleLable.font = [UIFont systemFontOfSize:15];
    _titleLable.textColor = [UIColor colorWithRed:0.753 green:0.275 blue:0.290 alpha:1.000];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = _musicTitle;
    [self.view addSubview:_titleLable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _currentTimeLable.text = @"00:00";
    _totalTimeLable.text = @"00:01";
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:_coverImageUrl] placeholderImage:nil];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_coverImageUrl] placeholderImage:nil];
    if (![_musicUrl  isEqualToString:_lastUrl]) {
        _isPlay = NO;
        [self play];
        [self refreshTableView];
    }
    if (_musicList.count != 0) {
        _isList = YES;
    }
    HotFmModel * model = _musicList[_index];
    BOOL isSuccessd = [[DBManager sharedManager]isExistAppFordowningAppId:model.id recordType:MusicDownType];
       BOOL isXizai = [[DBManager sharedManager]isExistAppForMusicAppId:model.id recordType:MusicDownType];
    if (isSuccessd || isXizai) {
       
        _downLoadButton.userInteractionEnabled = NO;
        [_downLoadButton setImage:_didImage forState:UIControlStateNormal];
    }else {
       
        _downLoadButton.userInteractionEnabled= YES;
        [_downLoadButton setImage:_doingImage forState:UIControlStateNormal];
    
    }
    [self isNet];
    
}

- (void)isNet {
    AppDelegate * appdelegat = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appdelegat.netState == noNet) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"网络开小差啦" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action1];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

//进度条
- (void)createSlider {
    if (_slider == nil) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(30,CGRectGetMaxY(_titleLable.frame) +20 +IMANGEWIDTH, SCREENWIDTH - 60,50)];
    }
  
    _slider.tintColor = [UIColor redColor];
    _slider.minimumValue = 0.0;
    _slider.maximumValue = 1.0;
    _slider.value = 0.0;
    [self.view addSubview:_slider];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
}
//进度条状态改变
- (void)sliderAction:(UISlider *)slider {
    [[AFSoundManager sharedManager]moveToSection:slider.value];
    [[AFSoundManager sharedManager]resume];
}

//播放器是  先走 viewDidLoad 之后才走set 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:self.musicTitle];
    
    _musicPlayView  = [MusicPlayView shareMusicPlayView];
    //    很重要  好像是提前初始化下， 进入播放器等待的时间会短点
    [self play];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createBackImage];
    [self createSHareButton];
    [self createLable];
    [self createImageView];

    [self createBackButton];
    [self createSlider];
    [self timeLable];

    [self createPlayButton];
    
    [self createTableView];
    [self refreshTableView];
    self.view.backgroundColor = [UIColor whiteColor];
  //设置背景

}

//分享按钮
- (void)createSHareButton {
    //    分享
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(SCREENWIDTH-50, 20, 30, 30);
    [shareButton setImage:[UIImage imageNamed:SHAREPIC] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAppForYou:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.hidden = YES;
    [self.view addSubview:shareButton];
    
    //下载按钮
    _didImage =[[UIImage imageNamed:@"tabbar_download_h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _doingImage =[[UIImage imageNamed:@"tabbar_download_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _downLoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _downLoadButton.frame = CGRectMake(SCREENWIDTH - 50, CGRectGetMaxY(shareButton.frame), 30, 30);
    HotFmModel * model = nil;
    if (_musicList.count) {
        model = _musicList[_index];
    }
    
    BOOL isCunzai = [[DBManager sharedManager]isExistAppFordowningAppId:model.id recordType:MusicDownType];
    BOOL isXizai = [[DBManager sharedManager]isExistAppForMusicAppId:model.id recordType:MusicDownType];
    if (isCunzai || isXizai) {
        [_downLoadButton setImage:_didImage forState:UIControlStateNormal];
    }else {
        [_downLoadButton setImage:_doingImage forState:UIControlStateNormal];
    }
    
//    [self.view addSubview:_downLoadButton];
    [_downLoadButton addTarget:self action:@selector(downloadMusicFormDownlodaController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)downloadMusicFormDownlodaController :(UIButton *)button {
    [_downLoadButton setImage:_didImage forState:UIControlStateNormal];
    _downLoadButton.userInteractionEnabled = NO;
    HotFmModel  * hotModel = _musicList[_index];
    DownLoadViewController * downVC = [[DownLoadViewController alloc]init];
    [downVC beginDownloadWith:hotModel WithBlock:^(BOOL isSuccessed) {
        if (isSuccessed) {
            NSLog(@"成功");
        }else {
            
            NSLog(@"失败");
        }
    }];
    
}

    

- (void)shareAppForYou :(UIButton *)button {
    NSString * shareStr = [NSString stringWithFormat:@"%@",_musicTitle];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"569cf6e867e58eb2b90005fe"
                                      shareText:shareStr
                                     shareImage:[UIImage imageNamed:@"Icon-120"]
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];

}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        UIAlertController * alC = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alC addAction:action];
        [self presentViewController:alC animated:YES completion:nil];
        
   
    }
}

#pragma mark--- set 方法
// set 方法  所有需要在单例中更新的东西 都在次调用
- (void)setCoverImageUrl:(NSString *)coverImageUrl {
    _coverImageUrl = coverImageUrl;
        [_musicPlayView startAnimations];
}

- (void)setMusicTitle:(NSString *)musicTitle {
    _musicTitle = musicTitle;
    if (![_musicTitle isEqualToString:@""]) {
        _titleLable.text = _musicTitle;
    }
    else {
        _titleLable.text = @"暂无信息~~";
    }
}

//时间设置
- (void)timeLable {
    CGFloat y = CGRectGetMaxY(_slider.frame);
    if (_currentTimeLable ==nil) {
        _currentTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(30, y, 50, 20)];
    }
    if (_totalTimeLable == nil) {
          _totalTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_slider.frame)-50, y, 50, 20)];
    }
  
//    当前时长进度
    _currentTimeLable.text = @"00:00";
    _totalTimeLable.text = @"00:01";
    [self.view addSubview:_totalTimeLable];
    [self.view addSubview:_currentTimeLable];
}

// play按钮
- (void)createPlayButton {
    CGFloat width = 30;
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.frame =CGRectMake(SCREENWIDTH/2-width/2, CGRectGetMaxY(_slider.frame),width, width);
    }
    [_playButton setImage:[UIImage imageNamed:PAUSHNAME] forState:UIControlStateNormal];
    _playButton.showsTouchWhenHighlighted =YES;

    
    [_playButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
//    下一首
    UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetMaxX(_playButton.frame)+width, CGRectGetMinY(_playButton.frame), width, width);
    [nextButton setImage:[UIImage imageNamed:NEXTNAME] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
//    上一首
    UIButton * lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lastButton.frame = CGRectMake(CGRectGetMinX(_playButton.frame)-2*width, CGRectGetMinY(_playButton.frame), width, width);
    [lastButton setImage:[UIImage imageNamed:LASTNAME] forState:UIControlStateNormal];
    [lastButton addTarget:self action:@selector(lastAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastButton];
    
//    循环播放
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(SCREENWIDTH -110, CGRectGetMinY(_slider.frame)-30, 100, 30);
    [oneButton setImage:[UIImage imageNamed:MANY] forState:UIControlStateNormal];
    [oneButton setTitle:@"循环播放" forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneOrCycle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneButton];
    
    
}

- (void)oneOrCycle:(UIButton *)button {
    if (!_isOne){
        [button setImage:[UIImage imageNamed:SINGLE] forState:UIControlStateNormal];
       [button setTitle:@"单曲播放" forState:UIControlStateNormal];
    }else {
        [button setImage:[UIImage imageNamed:MANY] forState:UIControlStateNormal];
        [button setTitle:@"循环播放" forState:UIControlStateNormal];
    }
    _isOne = !_isOne ;

}

//开始action
- (void)playOrPause:(UIButton *)button {
    if (!_isPlay == YES) {
        [[AFSoundManager sharedManager] pause];
        [_playButton setImage:[UIImage imageNamed:PLAYNAME] forState:UIControlStateNormal];
        [_musicPlayView stopAnimations];
//        停止动画
        CFTimeInterval stopTime = [_coverImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        _coverImageView.layer.timeOffset = stopTime;
        _coverImageView.layer.speed = 0;
    }else {
        [[AFSoundManager sharedManager] resume];
        [_playButton setImage:[UIImage imageNamed:PAUSHNAME] forState:UIControlStateNormal];
        [_musicPlayView startAnimations];
//        继续动画
        CFTimeInterval stopTime = [_coverImageView.layer timeOffset];
//        先缓冲一下动画， 不然有点卡顿效果
        _coverImageView.layer.beginTime = 0;
//        时间偏移量设置为0
        _coverImageView.layer.timeOffset = 0;
        _coverImageView.layer.speed = 1;
        CFTimeInterval tempTime = [_coverImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - stopTime;
        _coverImageView.layer.beginTime = tempTime;
    }
    _isPlay = !_isPlay;
}

//上一首action

- (void)lastAction:(UIButton *)button {
    if (_index > 0) {
        _index -= 1;
        [self refreshMusic];
        [self refreshTableView];
    }else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"已经到第一首啦" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-  (void)refreshMusic {
    
    HotFmModel * model = _musicList[_index];
    _titleLable.text = model.title;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _musicUrl = model.url;
    _lastUrl = _musicUrl;
    [self play];
    
}

//下一首
- (void)nextAction :(UIButton *)button {
    if (_index < _musicList.count -1) {
        _index += 1;
        [self refreshMusic];
        [self refreshTableView];
    }else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"已经到第最后首啦" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"返回第一首" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _index = 0;
            [self refreshMusic];
            [self refreshTableView];
            
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

//创建背景图片

- (void)createBackImage {
    
    if (_backImageView == nil) {
    _backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }

    [_backImageView sd_setImageWithURL:[NSURL URLWithString:_coverImageUrl] placeholderImage:nil];
    
    if (_effectView == nil) {
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
        _effectView.frame = _backImageView.bounds;
    }
    [_backImageView addSubview:_effectView];
    [self.view addSubview:_backImageView];
}
//创建头像转动每个
- (void)createImageView {
    
    CGFloat centerX = self.view.center.x - IMANGEWIDTH/2;
    CGFloat centerY = CGRectGetMaxY(_titleLable.frame) +20;
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(centerX, centerY, IMANGEWIDTH, IMANGEWIDTH)];
    }
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_coverImageUrl] placeholderImage:nil];
    
    [_coverImageView.layer addAnimation:[self createAnimation] forKey:@"rotationAnimation"];
    [self.view addSubview:_coverImageView];
}

- (CABasicAnimation *)createAnimation {

    //动画效果
    _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    _coverImageView.layer.cornerRadius = _coverImageView.frame.size.width / 2;
    _coverImageView.layer.masksToBounds = YES;
    _rotationAnimation.duration = 20;
    _rotationAnimation.cumulative = YES;
    _rotationAnimation.repeatCount = HUGE_VAL;
    _rotationAnimation.removedOnCompletion = NO;
    
    return _rotationAnimation;
}

#pragma mark ----- createTableView

- (void)createTableView {
    
    CGFloat y =CGRectGetMaxY(_playButton.frame)+10;
    CGRect rect = CGRectMake(0,y , SCREENWIDTH, SCREENHEIGHT- y);
    if (_musicTableView == nil) {
        _musicTableView = [MusicPlayTableView shareMusicPlayTableViewWithFrame:rect WithStyle:UITableViewStyleGrouped];
    }
    
    [self.view addSubview:_musicTableView];
}

- (void)refreshTableView {

    HotFmModel * model = _musicList[_index];
    DianTaiModel * dtModel = model.diantai;
    if (dtModel == nil && _diantamodel == nil) {
//   从更多心理中点进
        _musicTableView.picUrl = model.cover;
        _musicTableView.viewnum = model.viewnum;
        _musicTableView.content = model.speak;
        _musicTableView.contentUrl =model.id;
//        没有点击主播的key
        _musicTableView.isKey  = NO;
        _musicTableView.favnum = model.favnum;
    }else if (dtModel ==nil && _diantamodel !=nil){
//         主播列表点击进入的
        _musicTableView.picUrl = _diantamodel.cover;
        _musicTableView.viewnum = _diantamodel.viewnum;
        _musicTableView.content = _diantamodel.content;
        _musicTableView.contentUrl =model.id;
//        _diantaiModel的 id 就是key
         _musicTableView.isKey  = YES;
        _musicTableView.authorKey = _diantamodel.id;
        _musicTableView.diantaiModel = _diantamodel;
        _musicTableView.favnum = _diantamodel.favnum;
    }
    
    else {
//        单个点击进入的 或者首页中分类选项
        _musicTableView.picUrl = dtModel.cover;
        _musicTableView.viewnum = dtModel.viewnum;
        _musicTableView.content = dtModel.content;
//        评论url
        _musicTableView.contentUrl = model.id;
//        传入 dtModel 下的 userModel id；
        _musicTableView.isKey  = YES;
        _musicTableView.authorKey = dtModel.id;
        _musicTableView.diantaiModel = dtModel;
        _musicTableView.favnum = dtModel.favnum;
    }
}

-(void)dealloc
{
   
    
}

@end
