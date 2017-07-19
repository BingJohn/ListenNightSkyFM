//
//  ZyqTools.h
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#ifndef ZyqTools_h
#define ZyqTools_h


#define ZYQFONT(a)  [UIFont systemFontOfSize:a]
#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
#define TABLECOLOR   [UIColor colorWithRed:0.969 green:0.961 blue:0.949 alpha:1.000]
#define TITLECOLOR  [UIColor colorWithRed:0.753 green:0.275 blue:0.290 alpha:1.000]

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height         

#define AuthorType @"diantaizhubo"
#define MusicDownType  @"downMusic"
//首页网址
#define SHOUYEURl  @"http://yiapi.xinli001.com/fm/home-list.json?key=c0d28ec0954084b4426223366293d190"

//点击自我成长
#define MYSelfDevelopment  @"http://yiapi.xinli001.com/fm/category-jiemu-list.json?key=c0d28ec0954084b4426223366293d190&category_id=%@&limit=20&offset=%ld"

//点击热门推荐的urlis_teacher = 1 最新 url is_teacher = 0
#define HOTRecommend   @"http://bapi.xinli001.com/fm2/broadcast_list.json/?is_teacher=%@&key=c0d28ec0954084b4426223366293d190&rows=15&offset=%ld"
//主播详情
#define AuthorDetail  @"http://yiapi.xinli001.com/fm/diantai-detai.json?key=c0d28ec0954084b4426223366293d190&id=%@"
//主播作品介绍
#define AuthorWorks @"http://yiapi.xinli001.com/fm/diantai-jiemu-list.json?key=c0d28ec0954084b4426223366293d190&diantai_id=%@&offset=%ld&limit=20"
//首页中的更多主播
#define MoreAuthorUrl  @"http://yiapi.xinli001.com/fm/diantai-page.json?key=c0d28ec0954084b4426223366293d190"
//进入更多主播 后  新晋主播
#define NewAuthorUrl @"http://yiapi.xinli001.com/fm/diantai-new-list.json?key=c0d28ec0954084b4426223366293d190&limit=20&offset=%ld"

//网友评论
#define CONTENTURL @"http://yiapi.xinli001.com/fm/comment-list.json?broadcast_id=%@&key=c0d28ec0954084b4426223366293d190&offset=0&limit=10"
//发现页面 中滚动视图url
#define FINDHEADURL @"http://bapi.xinli001.com/fm2/hot_tag_list.json/?flag=4&key=c0d28ec0954084b4426223366293d190&rows=3&offset=0"
//点击心情需要拼接的url
#define MoodDetailUrl @"http://bapi.xinli001.com/fm2/broadcast_list.json/?offset=%ld&key=c0d28ec0954084b4426223366293d190&rows=15&tag=%@"
//下方的主播url
#define FINDAUTHORURL @"http://yiapi.xinli001.com/fm/diantai-find-list.json?key=c0d28ec0954084b4426223366293d190&rows=6&offset=0"

//搜索下面的热搜
#define HOTSEARCH  @"http://bapi.xinli001.com/fm2/hot_tag_list.json/?flag=1&key=c0d28ec0954084b4426223366293d190&rows=10&offset=0"

//搜索需要拼接的接口
#define SEARCHURL @"http://bapi.xinli001.com/fm2/broadcast_list.json/?key=c0d28ec0954084b4426223366293d190&q=%@&rows=15&offset=%ld"


//社区
//精华评论
#define SCROIALESSENCE @"http://yiapi.xinli001.com/fm/forum-thread-list.json?type=1&flag=0&key=c0d28ec0954084b4426223366293d190&size=10&offset=%ld";

//精华评论详情
#define COMMENT1  @"http://yiapi.xinli001.com/fm/forum-thread-detail.json?id=%@&key=c0d28ec0954084b4426223366293d190"
#define COMMENT2  @"http://yiapi.xinli001.com/fm/forum-comment-list.json?key=c0d28ec0954084b4426223366293d190&post_id=%@&offset=%ld&limit=10"


//最新
#define SCROIALNEWURL  @"http://yiapi.xinli001.com/fm/forum-thread-list.json?type=0&flag=0&key=c0d28ec0954084b4426223366293d190&size=10&offset=%ld"
#endif /* ZyqTools_h */
