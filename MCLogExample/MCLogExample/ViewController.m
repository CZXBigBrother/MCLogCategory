//
//  ViewController.m
//  MCLogExample
//
//  Created by marco chen on 2018/3/20.
//  Copyright © 2018年 marco chen. All rights reserved.
//

#import "ViewController.h"
#import "TestLogModel.h"
#import "NSObject+MCLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray * arr = @[@"你好",@"世界"];
    NSLog(@"%@",arr);
    
    NSDictionary * dict = @{@"你好":@"世界"};
    NSLog(@"%@",dict);
    
    TestLogModel * data = [[TestLogModel alloc]init];
    data.name = @"张三";
    data.sex = YES;
    data.address = @"火星大道222号";
    NSLog(@"%@",data);
    NSLog(@"%@",[data printPropertList]);
    NSLog(@"%@",[data printMethodList]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

