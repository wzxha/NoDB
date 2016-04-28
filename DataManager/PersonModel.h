//
//  PersonModel.h
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXModel.h"

@interface PersonModel : WZXModel

@property (nonatomic,assign)BOOL  isHave;
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)  NSString * name;
@property (nonatomic,copy)  NSArray * arr;
@property (nonatomic,copy)  NSDictionary * dic;

@end
