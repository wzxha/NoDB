//
//  PersonModel.m
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ ishave:%d num:%ld arr:%@ dic:%@",self.name,self.isHave,(long)self.num,self.arr,self.dic];
}
@end
