# WZXDataManager
二次封装fmdb，使用更加简单

#WZXDataManager的优点
使用简单
- 创建一个继承于`WZXModel`的Model，并在其中加入各种属性。
```objc
@interface PersonModel : WZXModel

@property (nonatomic,assign)BOOL  isHave;
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)  NSString * name;
@property (nonatomic,copy)  NSArray * arr;
@property (nonatomic,copy)  NSDictionary * dic;

目前只支持这些类型
```
- 在`WZXDataManager`的初始化方法中传入表名
```objc
[WZXDataManager managerWithTable:@"PersonModel"];
```

**现在你已经创建好了一个表**。

#API
- [初始化](#初始化)
- [插入数据](#插入数据)
- [更新数据](#更新数据)
- [删除数据](#删除数据)
- [查询数据](#查询数据)

## <a id="初始化"></a>初始化
根据表名初始化
```objc
+ (WZXDataManager *)managerWithTable:(NSString *)modelName;`
```

## <a id="插入数据"></a>插入数据
```objc
-(void)insert:(WZXModel *)model;
```

## <a id="更新数据"></a>更新数据
根据model和主键更新数据
```objc
-(void)update:(WZXModel *)model withMainKey:(NSString *)key;
```

## <a id="删除数据"></a>删除数据
根据model删除数据
```objc
-(void)remove:(WZXModel *)model;
```
根据model和主键删除数据
```objc
-(void)remove:(WZXModel *)model withMainKey:(NSString *)key;
```
根据表名删除所有数据
```objc
-(void)removeAll:(NSString *)tableName;
```

## <a id="查询数据"></a>查询数据
根据字典查询数据
```objc
-(NSArray<WZXModel *> * )fetch:(NSDictionary *)dic;
```
根据表名查询所有数据
```objc
-(NSArray<WZXModel *> * )fetchAll:(NSString *)modelName;
```

