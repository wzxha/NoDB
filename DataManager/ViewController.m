//
//  ViewController.m
//  DataManager
//
//  Created by wordoor－z on 16/4/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"
#import "DataManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataManager * manager = [DataManager managerWithTable:@"PersonModel"];
    PersonModel * model = [[PersonModel alloc]init];
    model.name = @"0";
    model.isHave = 1;
    model.num = 20;
    model.arr = @[@"arr",@"arr"];
    model.dic = @{
                  @"dic":@"dic123"
                  };
      //插入
//    [manager insert:model];
    
//    //更新
//     [manager update:model withMainKey:@"name"];
//    
//    //删除
//     [manager remove:model withMainKey:@"name"];
//     [manager removeAll:@"PersonModel"];
      //查询
//    PersonModel * model2 = (PersonModel *)[manager fetch:@{
//                                            W_TABLE_NAME:@"PersonModel",
//                                            @"name":@"0",
//                                            @"num":@(10)
//                                            }].lastObject;
//    NSLog(@"%@",[manager fetchAll:@"PersonModel"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
