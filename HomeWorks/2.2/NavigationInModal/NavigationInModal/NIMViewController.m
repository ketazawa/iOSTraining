//
//NIMViewController.m
//NavigationInModal
//
//Created by 武田 祐一 on 2013/04/17.
//Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "NIMViewController.h"
#import "NIMModalViewController.h"

@interface NIMViewController ()

@end

@implementation NIMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%d", self.navigationController.viewControllers.count];
    
    UIBarButtonItem *pushButton = [[UIBarButtonItem alloc]initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pressPushButton)];
    [self.navigationItem setRightBarButtonItem:pushButton];
    
    UIBarButtonItem *rootButton = [[UIBarButtonItem alloc]initWithTitle:@"Root" style:UIBarButtonItemStylePlain target:self action:@selector(pressRootButton)];
    [self.navigationItem setLeftBarButtonItem:rootButton];
    
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

#pragma -mark PrivateMethod
- (void)pressPushButton
{
    NSLog(@"Pressed Push Button");
    
    [self.navigationController pushViewController:[[NIMViewController alloc]init] animated:YES];
}

- (void)pressRootButton
{
    NSLog(@"Pressed Root Button");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
