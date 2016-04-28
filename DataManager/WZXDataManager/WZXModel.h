//
//  WZXModel.h
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXModel : NSObject
typedef NS_ENUM(NSInteger,DataType) {
    wBOOL = 0,
    wTEXT = 1,
    wINT  = 2,
    wArr = 3,
    wDic = 4,
    wERROR = 999,
};
- (NSDictionary *)allMembers;
@end
