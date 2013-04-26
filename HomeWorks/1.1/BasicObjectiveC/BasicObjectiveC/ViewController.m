//
//  ViewController.m
//  BasicObjectiveC
//
//  Created by 武田 祐一 on 2013/04/16.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "ViewController.h"
#import "TestQueue.h"
#import "TestStack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO ここに課題を書き進めていってください
    // 課題1
    NSArray *rootArray =  @[[self createFirstEntryDictionary],[self createSecondEntryDictionary],[self createThirdEntryDictionary] ];
    NSLog(@"%@",rootArray);
    
    // 課題2
    TestQueue *testQueue =[[TestQueue alloc]init];
    NSLog(@"TestQueue Size %d",[testQueue size]);
    
    [testQueue push:@"Queue a"];
    [testQueue push:@"Queue b"];
    [testQueue push:@"Queue c"];
    
    NSLog(@"TestQueue Size %d",[testQueue size]);
    NSLog(@"TestQueue Size %@",[testQueue pop]);


    TestStack *testStack =[[TestStack alloc]init];
    NSLog(@"TestStack Size %d",[testStack size]);
    
    [testStack push:@"Stack a"];
    [testStack push:@"Stack b"];
    [testStack push:@"Stack c"];
    
    NSLog(@"TestStack Size %d",[testStack size]);
    NSLog(@"TestStack Size %@",[testStack pop]);
    
}


-(NSDictionary *)createFirstEntryDictionary
{
    NSMutableDictionary *firstDic =  [NSMutableDictionary dictionary];
    [firstDic setObject:@"mixi" forKey:@"domain"];
    
    NSArray *entryArray = @[@"list_voice.pl",@"list_diary.pl",@"list_mymall_item.pl"];
    [firstDic setObject:entryArray forKey:@"entry"];

    return firstDic;
}


-(NSDictionary *)createSecondEntryDictionary
{
    //second element
    NSMutableDictionary *secondDic =  [NSMutableDictionary dictionary];
    [secondDic setObject:@"mmall.jp" forKey:@"domain"];
    
    
    NSArray *queryArray = @[@{@"tag_id":[NSNumber numberWithInt:7]}];
    NSDictionary *entryDic = @{@"path":@"add_diary.pl",@"query": queryArray};

    [secondDic setObject:@[entryDic] forKey:@"entry"];
    
    return secondDic;
}

-(NSDictionary *)createThirdEntryDictionary
{
    
    return @{@"domain":@"itunes.apple.com"};
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
