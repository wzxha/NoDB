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
- 在`WZXDataManager`的方法中传入表名
```
[WZXDataManager managerWithTable:@"PersonModel"];
```

**现在你已经创建好了一个表**。


