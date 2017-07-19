//
//  MyViewController.m
//  SeeTheWorld
//
//  Created by zyq on 16/1/2.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MyViewController.h"
#import "ZyqTools.h"

@interface MyViewController ()

@end

@implementation MyViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    [self test];
    [self lable];
}

- (void)test {
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image =[UIImage imageNamed:@"bg_for_login"];
    [self.view addSubview:imageView];
    
}

- (void)lable {
  
    UILabel * label1 = [UILabel new];
    CGSize size = self.view.frame.size;
    label1.frame = CGRectMake(size.width-200,size.height/2+100, 45, 30);
    label1.text = @"开发者:";
    [self.view addSubview:label1];
    

    UILabel * label2 = [UILabel new];
    label2.frame = CGRectMake(label1.right +5, label1.top, 150, label1.height);
    label2.text = @"聆听科技有限公司";
    [self.view addSubview:label2];
    
    
    UILabel * label3 = [UILabel new];
    label3.frame =CGRectMake(size.width-200,label1.bottom, 50, 30);
    label3.text = @"感谢:";
    [self.view addSubview:label3];
    
    
    UILabel * label4 = [UILabel new];
    label4.frame =CGRectMake(label2.left,label1.bottom, size.width -CGRectGetMaxX(label3.frame),60);
    label4.numberOfLines = 0;
    NSString * str = @"xiaolu,daniu,JW,SYN,CJH,ZYS,CZR,LB,CJ,ZZ,XH,XK的相关技术支持";
    label4.font = ZYQFONT(13);
    label3.font = ZYQFONT(13);
    label2.font = ZYQFONT(13);
    label1.font = ZYQFONT(13);
    label4.text = str;
    [self.view addSubview:label4];

}


@end
