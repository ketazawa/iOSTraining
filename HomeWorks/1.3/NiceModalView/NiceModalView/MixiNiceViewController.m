//
//  MixiNiceViewController.m
//  NiceModalView
//
//  Created by 鄭 基旭 on 2013/04/15.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "MixiNiceViewController.h"
#import "UIViewController+NiceAnimation.h"

@interface MixiNiceViewController ()

@end

@implementation MixiNiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return(self);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger      allImageCount = 5;
    
    NSMutableArray *sampleImages = [NSMutableArray array];
    for (int currentIndex = 0; currentIndex < allImageCount; currentIndex++)
        {
        NSString *filename = [NSString stringWithFormat:@"%d.jpg", currentIndex];
        UIImage  *img      = [UIImage imageNamed:filename];
        [sampleImages addObject:img];
        }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(clickClose:)];
    
    static int index;
    index++;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[sampleImages objectAtIndex:index % allImageCount]];
    // insertSubview と addSubViewの違いを探してみましょう
    [self.view insertSubview:imageView atIndex:0];
    //    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // call this method where viewWillAppear
    [self animationPopFrontScaleUp];
}

- (IBAction)clickButtons:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (button.tag == 1) {
        [self clickPush:sender];
    }else if (button.tag == 2) {
        [self clickModalView:sender];
    }
}

- (void)clickPush:(id)sender
{
    MixiNiceViewController *viewController = [[MixiNiceViewController alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickModalView:(id)sender
{
    MixiNiceViewController *viewController = [[MixiNiceViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    [self animationPushBackScaleDown];
}

- (void)clickClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
