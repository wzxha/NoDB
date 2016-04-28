//
//  Datamanager.m
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "DataManager.h"
#import "FMDatabase.h"
#import <objc/runtime.h>
NSString * const W_TABLE_NAME = @"W_TABLE_NAME";
@interface DataManager()
@property(nonatomic,strong)FMDatabase * db;
@end
@implementation DataManager

+ (DataManager *)managerWithTable:(NSString *)modelName {
    return [[DataManager alloc]initWithTable:modelName];
}

- (instancetype)initWithTable:(NSString *)modelName {
    if (self = [super init]) {
        
      NSDictionary * members = [self returnDicWithClassName:modelName];

        if (![self.db open]) {
            NSLog(@"数据库打开失败！");
        } else {
            NSLog(@"数据库打开成功！");
        NSString * sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ",modelName];

        NSMutableString * sqlMember = [[NSMutableString alloc]initWithString:@"(id INTEGER PRIMARY KEY AUTOINCREMENT"];;
            for (int i = 0 ; i < members.allKeys.count; i++) {
                NSString * member = members.allKeys[i];
                [sqlMember appendString:[NSString stringWithFormat:@",%@ %@",member,[self returnType:[members[member] integerValue]]]];
                if (i == members.allKeys.count - 1) {
                    [sqlMember appendFormat:@")"];
                }
            }

            BOOL res = [_db executeUpdate:[NSString stringWithFormat:@"%@%@",sqlCreateTable,sqlMember]];
            
            if (!res) {
                
                NSLog(@"error when creating db table");
                
            } else {
                
                NSLog(@"success to creating db table");
                
            }
            
            [_db close];
        }
    }
    return self;
}

- (void)insert:(WZXModel *)model {
    if (![self.db open]) {
    } else {
        NSString * tableName =  NSStringFromClass(model.class);
        NSArray * members = model.allMembers.allKeys;
        NSMutableString * firstSql = [[NSMutableString alloc]initWithString:@"("];
        NSMutableString * valueSql = [[NSMutableString alloc]initWithString:@"VALUES("];
        NSMutableArray * arr = [NSMutableArray array];
        for (int i = 0; i < members.count; i++) {
            id data = [self returnContent:model withKey:members[i]];
            if ([model.allMembers[members[i]] integerValue] == wArr ) {
                [arr addObject:[NSKeyedArchiver archivedDataWithRootObject:data]];
            } else if ([model.allMembers[members[i]] integerValue] == wDic ){
                NSMutableData * dic2data = [[NSMutableData alloc] init];
                NSKeyedArchiver*archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dic2data];
                [archiver encodeObject:data forKey:@"Some Key Value"];
                [archiver finishEncoding];
                [arr addObject:dic2data];
            } else {
                [arr addObject:data];
            }
           
            
            [firstSql appendString:[NSString stringWithFormat:@"%@",members[i]]];
            [valueSql appendString:@"?"];
            if (i == members.count - 1) {
                [firstSql appendString:@")"];
                [valueSql appendString:@")"];
            } else {
                [firstSql appendString:@","];
                [valueSql appendString:@","];
            }
        }
        NSString * sql =[NSString stringWithFormat:@"INSERT INTO %@ %@ %@",tableName,firstSql,valueSql];
        BOOL res = [self.db executeUpdate:sql values:arr error:nil];
        
        if (!res) {
            
            NSLog(@"error when insert db table");
            NSLog(@"%@",[NSString stringWithFormat:@"%@",_db.lastError]);
        } else {
            
            NSLog(@"success to insert db table");
        }
        
        [_db close];
    }
    
}

- (void)update:(WZXModel *)model {
    [self update:model withMainKey:nil];
}

- (void)update:(WZXModel *)model withMainKey:(NSString *)key {
    if ([self.db open]) {
        NSMutableString * sql = [NSMutableString stringWithFormat:@"update %@ set ",NSStringFromClass(model.class)];
        NSMutableString * whereSql = [NSMutableString stringWithFormat:@" where %@=%@",key,[model valueForKey:key]];
        NSDictionary * members = [model allMembers];
        NSMutableArray * valuesArr = [NSMutableArray array];
        for (int i = 0; i < members.allKeys.count; i++) {
            
             NSString * member = members.allKeys[i];
            if (![member isEqualToString:key]) {
               
                [sql appendString:[NSString stringWithFormat:@"'%@'=?",member]];
                if (i!=members.allKeys.count - 1) {
                    [sql appendString:@","];
                }

                id data =  [self returnContent:model withKey:members.allKeys[i]];
                if ([model.allMembers[members.allKeys[i]] integerValue] == wArr ) {
                    [valuesArr addObject:[NSKeyedArchiver archivedDataWithRootObject:data]];
                } else if ([model.allMembers[members.allKeys[i]] integerValue] == wDic ){
                    NSMutableData * dic2data = [[NSMutableData alloc] init];
                    NSKeyedArchiver*archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dic2data];
                    [archiver encodeObject:data forKey:@"Some Key Value"];
                    [archiver finishEncoding];
                    [valuesArr addObject:dic2data];
                } else {
                    [valuesArr addObject:data];
                }
            }
        }
        NSError * error;
        NSString * s = [NSString stringWithFormat:@"%@%@",sql,whereSql];
        BOOL res = [_db executeUpdate:s values:valuesArr error:&error];
        if (!res) {
            NSLog(@"更新失败");
            NSLog(@"%@",error);
        } else {
            NSLog(@"更新成功");
        }
        [_db close];
    } else {
        
    }
}

- (void)removeAll:(NSString *)tableName {
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableName];
        if ([_db executeUpdate:sql]) {
            NSLog(@"全部删除成功");
        } else {
            NSLog(@"全部删除失败");
        }
    } else {
        
    }
}

- (void)remove:(WZXModel *)model {
    [self remove:model withMainKey:nil];
}

- (void)remove:(WZXModel *)model withMainKey:(NSString *)key {
    if ([self.db open]) {
        NSMutableString * sql = [NSMutableString stringWithFormat:@"delete from %@ where ",NSStringFromClass(model.class)];
        NSDictionary * members = [model allMembers];
        NSMutableArray * valuesArr = [NSMutableArray array];
        if (key) {
            
        } else {
            for (int i = 0; i < members.allKeys.count; i++) {
                NSString * member = members.allKeys[i];
                [sql appendString:[NSString stringWithFormat:@"%@=?",member]];
                if (i!=members.allKeys.count - 1) {
                    [sql appendString:@" and "];
                }
                [valuesArr addObject:[model valueForKey:member]];
            }
        }
        NSError * error;
        BOOL res = [_db executeUpdate:sql values:valuesArr error:&error];
        if (!res) {
            NSLog(@"删除失败");
            NSLog(@"%@",error);
        } else {
            NSLog(@"删除成功");
        }
        [_db close];
    } else {
        
    }
}

- (NSArray<WZXModel *> * )fetch:(NSDictionary *)dic {
    if ([self.db open]) {
        
        NSMutableString * sql = [NSMutableString stringWithFormat:@"SELECT * FROM %@ where ",dic[W_TABLE_NAME]];
        
        for (int i = 0; i < dic.allKeys.count; i++) {
            NSString * member = dic.allKeys[i];
            if (![member isEqualToString:W_TABLE_NAME]) {
                [sql appendFormat:@"%@=%@ and ",member,dic[member]];
                
            }
            if (i ==dic.allKeys.count - 1) {
                [sql deleteCharactersInRange:NSMakeRange(sql.length - 4, 3)];
            }
        }
        
        FMResultSet *rs = [_db executeQuery:sql];
        NSMutableArray * arr = [NSMutableArray array];
        // 遍历结果集
        while ([rs next]) {
            
            NSDictionary * dataDic = [self returnDicWithClassName:dic[W_TABLE_NAME]];
            [arr addObject:[self setUpModelWithDic:dataDic andResult:rs withClassName:dic[W_TABLE_NAME]]];
        }
        [self.db close];
        return arr;
    } else {
        
    }
    return nil;
}

- (NSArray<WZXModel *> * )fetchAll:(NSString *)modelName {
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",modelName];
        FMResultSet *rs = [_db executeQuery:sql];
        NSMutableArray * arr = [NSMutableArray array];
        // 遍历结果集
        while ([rs next]) {
            NSDictionary * dic = [self returnDicWithClassName:modelName];
            [arr addObject:[self setUpModelWithDic:dic andResult:rs withClassName:modelName]];
        }
        [self.db close];
        return arr;
    } else {
    
    }
    return nil;
}



- (id)setUpModelWithDic:(NSDictionary *)dic andResult:(FMResultSet *)rs withClassName:(NSString *)className {
    id model = [[NSClassFromString(className) alloc]init];
    for (int i = 0; i < dic.allKeys.count; i++) {
        NSString * key = dic.allKeys[i];
        switch ([dic[key] integerValue]) {
            case wTEXT: {
                [model setValue:[rs stringForColumn:key] forKey:key];
            }
                break;
            case wArr: {
                NSData * data = [rs dataForColumn:key];
                [model setValue:[NSKeyedUnarchiver unarchiveObjectWithData:data] forKey:key];
            }
                break;
            case wDic: {
                NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[rs dataForColumn:key]];
                NSDictionary *dataDic = [unarchiver decodeObjectForKey:@"Some Key Value"];
                [unarchiver finishDecoding];
                [model setValue:dataDic forKey:key];
            }
                break;
            case wBOOL: {
                [model setValue:@([rs boolForColumn:key]) forKey:key];
            }
                break;
            case wINT: {
                [model setValue:@([rs intForColumn:key]) forKey:key];

            }
                break;
            default:
                break;
        }
    }
    return model;
}

- (NSDictionary *)returnDicWithClassName:(NSString *)className {
        id model = [[NSClassFromString(className) alloc]init];
        SEL sel = NSSelectorFromString(@"allMembers");
        
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([model respondsToSelector:sel]) {
            return [model performSelector:sel];
        } else {
            return nil;
        }
    #pragma clang diagnostic pop

}

- (id)returnContent:(WZXModel *)model withKey:(NSString *)key{
    return [model valueForKey:key];
}
                
- (NSString *)returnType:(DataType)type{
    switch (type) {
        case wArr: {
            return @"BLOB";
        }
            break;
        case wDic: {
            return @"BLOB";
        }
            break;
        case wBOOL: {
            return @"BOOLEAN";
        }
            break;
        case wINT: {
            return @"INTEGER";
        }
            break;
        case wTEXT: {
            return @"TEXT";
        }
            break;
        default:
            break;
    }
    return nil;
}

- (FMDatabase *)db {
    if (!_db) {
        NSString * docsdir = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString * dbpath = [docsdir stringByAppendingPathComponent:@"data.sqlite"];
        NSLog(@"%@",dbpath);
        _db = [FMDatabase databaseWithPath:dbpath];
    }
    return _db;
}
@end
