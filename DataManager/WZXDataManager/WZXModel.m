//
//  WZXModel.m
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXModel.h"
#import <objc/runtime.h>
@implementation WZXModel

- (NSDictionary *)allMembers {
    NSMutableDictionary * members = [[NSMutableDictionary alloc]init];
    
    unsigned int outCount, i;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
        
        NSString *propertyClass = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] ;
        
        [members setObject:@([self returnType:propertyClass]) forKey:propertyName];
    }
    
    free(properties);
    
    return [members copy];
}

- (DataType)returnType:(NSString *)T {
    if ([T hasPrefix:@"T@\"NSString\""]) {
        return wTEXT;
    } else if ([T hasPrefix:@"T@\"NSArray\""]) {
        return wArr;
    } else if ([T hasPrefix:@"T@\"NSDictionary\""]) {
        return wDic;
    } else if ([T hasPrefix:@"TB"]) {
        return wBOOL;
    } else if ([T hasPrefix:@"Tq"]) {
        return wINT;
    }
    return wERROR;
}

@end
