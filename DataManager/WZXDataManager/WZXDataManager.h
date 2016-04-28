//
//  Datamanager.h
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZXModel.h"
extern NSString * const W_TABLE_NAME;
@interface WZXDataManager : NSObject

+ (WZXDataManager *)managerWithTable:(NSString *)modelName;

- (void)insert:(WZXModel *)model;

- (void)update:(WZXModel *)model withMainKey:(NSString *)key;

- (void)remove:(WZXModel *)model;
- (void)remove:(WZXModel *)model withMainKey:(NSString *)key;
- (void)removeAll:(NSString *)tableName;

- (NSArray<WZXModel *> * )fetch:(NSDictionary *)dic;

- (NSArray<WZXModel *> * )fetchAll:(NSString *)modelName;
@end
