//
//  DBManager.m
//  LimitFreeProject
//


#import "DBManager.h"
#import "HomeModel.h"
#import "ZyqTools.h"

//全局变量
NSString * const kLZXFavorite = @"favorites";
NSString * const kLZXDownloads = @"downloads";
NSString * const kLZXBrowses = @"browese";

/*
 数据库
 1.导入 libsqlite3.dylib
 2.导入 fmdb
 3.导入头文件
 fmdb 是对底层C语言的sqlite3的封装
 
 */
@implementation DBManager
{
    //数据库对象
    FMDatabase *_database;
}

+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (manager == nil) {
            manager = [[DBManager alloc] init];
        }
    }
    return manager;
}
- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"app.db"];
        //2.创建database
        _database = [[FMDatabase alloc] initWithPath:filePath];
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}
#pragma mark - 创建表
- (void)creatTable {
    //字段: 应用名 应用id 当前价格 最后价格 icon地址 记录类型 价格类型
    NSString *sql = @"create table if not exists appInfo(serial integer  Primary Key Autoincrement,nickName Varchar(1024),appId Varchar(1024),recordType Varchar(1024),viewCount Varchar(1024),commentCount Varchar(1024),avatar Varchar(1024),picUrl Varchar(2048))";
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
//    coverImageUrl,appId,recordType,musicUrl,musicTitle
//    装下载的url
    NSString * sqlMusic = @"create table if not exists musicInfo (serial integer  Primary Key Autoincrement,coverImageUrl Varchar(1024),appId Varchar(1024),recordType Varchar(1024),musicUrl Varchar(1024),musicTitle Varchar(1024))";
    BOOL isMSuccees = [_database executeUpdate:sqlMusic];
    if (!isMSuccees) {
         NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
    
    NSString * sqlDowning = @"create table if not exists downingInfo (serial integer  Primary Key Autoincrement,coverImageUrl Varchar(1024),appId Varchar(1024),recordType Varchar(1024),musicTitle Varchar(1024),title Varchar(1024))";
    BOOL isDSuccess = [_database executeUpdate:sqlDowning];
    if (!isDSuccess) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
    
}
#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        //文件的全路径insert erro
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}


//增加 数据 收藏/浏览/下载记录
//存储类型 favorites downloads browses
- (void)insertModel:(id)model recordType:(NSString *)type {

        DianTaiModel * dModel = (DianTaiModel *)model;
    UserModel * userModel  = dModel.user;
    if ([self isExistAppForAppId:dModel.id recordType:type]) {
        NSLog(@"this app has  recorded");
        return;
    }
    NSString *sql = @"insert into appInfo(nickName,appId,recordType,viewCount,commentCount,avatar,picUrl) values (?,?,?,?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sql,userModel.nickname,dModel.id,type,dModel.viewnum,dModel.content,dModel.favnum,userModel.avatar];
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
}

- (void)insertDowningModel:(id)model recordType:(NSString *)type {
    HotFmModel * modelFM = (HotFmModel *)model;

    
    if ([self isExistAppForMusicAppId:modelFM.id recordType:type]) {
        NSLog(@"this app has  recorded");
        return;
    }
    NSString * sqlMusic = @"insert into downingInfo(coverImageUrl,appId,recordType,musicTitle) values (?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sqlMusic,modelFM.cover,modelFM.id,type,modelFM.title];
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
    

   

}


//下载完成的
- (void)insertModel:(id)model recordType:(NSString *)type WithPath:(NSString * )path {
    HotFmModel * modelFM = (HotFmModel *)model;
    NSLog(@"%@",modelFM.id);
    if ([self isExistAppForMusicAppId:modelFM.id recordType:type]) {
        NSLog(@"this app has  recorded");
        return;
    }
    NSString * sqlMusic = @"insert into musicInfo(coverImageUrl,appId,recordType,musicUrl,musicTitle) values (?,?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sqlMusic,modelFM.cover,modelFM.id,type,path,modelFM.title];
    if (!isSuccess) {
         NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
 


}

//查找所有插入类型
- (NSArray *)searchAllType {
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    NSString *sql = @"select *from appInfo";
    //NSString *sql1 = @"select recordType from appInfo";
    FMResultSet *resultSet = [_database executeQuery:sql];
    //FMResultSet *resultSet1 = [_database executeQuery:sql1];
    while (resultSet.next) {
        [tmpArray addObject:[resultSet stringForColumn:@"recordType"]];
    }
    return tmpArray;
}

//删除指定的应用数据 根据指定的类型
- (void)deleteModelForAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"delete from appInfo where appId = ? and recordType = ?";
    BOOL isSuccess = [_database executeUpdate:sql,appId,type];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

//删除正在下载的
- (void)deleteLoadingModelForAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"delete from downingInfo where appId = ? and recordType = ?";
    BOOL isSuccess = [_database executeUpdate:sql,appId,type];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

- (void)deleteModelMusicForAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"delete from musicInfo where appId = ? and recordType = ?";
    BOOL isSuccess = [_database executeUpdate:sql,appId,type];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

- (void)deleteModelForAppId:(NSString *)appId{
    NSString *sql = @"delete from appInfo where appId = ?";
    BOOL isSuccess = [_database executeUpdate:sql,appId];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

//根据指定类型  查找所有的记录
//根据记录类型 查找 指定的记录
- (NSArray *)readModelsWithRecordType:(NSString *)type{
    
    NSString *sql = @"select * from appInfo where  recordType = ?";
    FMResultSet * rs = [_database executeQuery:sql,type];
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合
    while ([rs next]) {
        //把查询之后结果 放在model
        DianTaiModel * dModel = [[DianTaiModel alloc]init];
//        现在放的是名字
        UserModel * userModel = [[UserModel alloc]init];
        
        userModel.nickname = [rs stringForColumn:@"nickName"];
        dModel.id = [rs stringForColumn:@"appId"];
        dModel.viewnum = [rs stringForColumn:@"viewCount"];
        dModel.content = [rs stringForColumn:@"commentCount"];
//        讲图片url 放入title中
         userModel.avatar = [rs stringForColumn:@"picUrl"];
        dModel.cover = [rs stringForColumn:@"picUrl"];
        dModel.favnum = [rs stringForColumn:@"avatar"];
        
        dModel.user = userModel;
    
        //放入数组
        [arr addObject:dModel];
    }
    return arr;
}

- (NSArray *)readDowningModelsWithRecordType:(NSString *)type {
    NSString *sql = @"select * from downingInfo where  recordType = ?";
    FMResultSet * rs = [_database executeQuery:sql,type];
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合
    while ([rs next]) {
        //把查询之后结果 放在model
        HotFmModel * fmModel = [[HotFmModel alloc]init];
        
        
        fmModel.cover = [rs stringForColumn:@"coverImageUrl"];
        fmModel.id = [rs stringForColumn:@"appId"];
//        fmModel.url = [rs stringForColumn:@"musicUrl"];
        fmModel.title = [rs stringForColumn:@"musicTitle"];
        //        讲图片url 放入title中
        //放入数组
        [arr addObject:fmModel];
    }
    return arr;
    
}

- (NSArray *)readMusicModelsWithRecordType:(NSString *)type {
    NSString *sql = @"select * from musicInfo where  recordType = ?";
    FMResultSet * rs = [_database executeQuery:sql,type];
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合
    while ([rs next]) {
        //把查询之后结果 放在model
        HotFmModel * fmModel = [[HotFmModel alloc]init];
        
        
        fmModel.cover = [rs stringForColumn:@"coverImageUrl"];
        fmModel.id = [rs stringForColumn:@"appId"];
        fmModel.url = [rs stringForColumn:@"musicUrl"];
        fmModel.title = [rs stringForColumn:@"musicTitle"];
        //        讲图片url 放入title中
        //放入数组
        [arr addObject:fmModel];
    }
    return arr;
    
}

//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"select * from appInfo where appId = ? and recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,appId,type];
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isExistAppForMusicAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"select * from musicInfo where appId = ? and recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,appId,type];
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isExistAppFordowningAppId:(NSString *)appId recordType:(NSString *)type {
    NSString *sql = @"select * from downingInfo where appId = ? and recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,appId,type];
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}

//根据 指定的记录类型  返回 记录的条数
- (NSInteger)getCountsFromAppWithRecordType:(NSString *)type {
    NSString *sql = @"select count(*) from appInfo where recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,type];
    NSInteger count = 0;
    while ([rs next]) {
        //查找 指定类型的记录条数
        count = [[rs stringForColumnIndex:0] integerValue];
    }
    return count;
}


@end
