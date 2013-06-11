//
//FocusViewController.m
//ThumbnailFocus
//
//Created by 鄭 基旭 on 2013/04/18.
//Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "FocusViewController.h"

static NSTimeInterval const kDefaultOrientationAnimationDuration = 0.4;

@interface FocusViewController ()
@property (nonatomic, assign) UIDeviceOrientation previousOrientation;
@end

//⬇ Answer：」マークがあるラインにコメントで簡単な解説文を書いてください。

@implementation FocusViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainImageView = nil;
    self.contentView   = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //⬇Answer：
    //NSNotificationCenterに画面回転時の通知を受け取るように登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    //⬇Answer：
    //UIDeviceで画面回転時の通知を開始
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //⬇Answer：
    //NSNotificationCenterに画面回転時の通知を受け取りを解除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    //⬇Answer：
    ////UIDeviceで画面回転時の通知を終了
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (NSUInteger)supportedInterfaceOrientations
{
    //⬇Answer：
    
    //サポートする画面の向きを返却します。この場合は縦画面をサポートしています。
    return(UIInterfaceOrientationMaskPortrait);
}

- (BOOL)isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    switch (toInterfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
        
        return([self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortrait);
        
        case UIInterfaceOrientationPortraitUpsideDown:
        
        return([self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortraitUpsideDown);
        
        case UIInterfaceOrientationLandscapeLeft:
        
        return([self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft);
        
        case UIInterfaceOrientationLandscapeRight:
        
        return([self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeRight);
    }
}

/////////////////////////////////////////////////////////////
//⬇Answer： 次の関数は回転時のアニメーションを担当しています。
//　82ラインから140ラインまで、すべてのラインにコメントを書いてください。
/////////////////////////////////////////////////////////////
- (void)updateOrientationAnimated:(BOOL)animated
{
    //座標変換の構造体を格納するクラスを宣言
    CGAffineTransform transform;
    //インターバル型を宣言
    NSTimeInterval    duration = kDefaultOrientationAnimationDuration;
    
    //以前の端末向きと比較。同じ場合は何もしない
    if ([UIDevice currentDevice].orientation == self.previousOrientation) {
        return;
    }
    
    //現在の端末の向きが横 且つ 前の向きが横　または 現在の端末の向きが縦 且つ 前の向きが縦
    if ((UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsLandscape(self.previousOrientation)) ||
        (UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsPortrait(self.previousOrientation))) {
        //インターバルを2に設定
        duration *= 2;
    }
    
    //現在の端末の向きが縦 または 親のViewControllerが現在の端末の向きサポートしているかを判定
    if (([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait) ||
        [self isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)[UIDevice currentDevice].orientation]) {
        transform = CGAffineTransformIdentity;
    } else {
        //端末の向きを判定
        switch ([UIDevice currentDevice].orientation)
        {
            //端末横向き+ホームボタンが左
            case UIInterfaceOrientationLandscapeLeft:
            if (self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                transform = CGAffineTransformMakeRotation(-M_PI_2);
            } else {
                transform = CGAffineTransformMakeRotation(M_PI_2);
            }
            break;
            
            //端末横向き+ホームボタンが右
            case UIInterfaceOrientationLandscapeRight:
            if (self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                transform = CGAffineTransformMakeRotation(M_PI_2);
            } else {
                transform = CGAffineTransformMakeRotation(-M_PI_2);
            }
            break;
            
            //端末縦＋ホームボタン下
            case UIInterfaceOrientationPortrait:
            transform = CGAffineTransformIdentity;
            break;
            
            //端末縦＋ホームボタン上
            case UIInterfaceOrientationPortraitUpsideDown:
            
            transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
            //端末うつ伏せ
            case UIDeviceOrientationFaceDown:
            //端末仰向け
            case UIDeviceOrientationFaceUp:
            //向きが不明
            case UIDeviceOrientationUnknown:
            
            return;
        }
    }
    
    //Location(0,0)、CGRectMake(0,0,0,0)のCGRectを作成
    CGRect frame = CGRectZero;
    
    //アニメーションがフラグがYESの場合
    if (animated) {
        //アニメーション処理を行う
        frame = self.contentView.frame;
        [UIView animateWithDuration:duration
                         animations:^{
                             self.contentView.transform = transform;
                             self.contentView.frame = frame;
                         }];
    } else { //アニメーションフラグがNOの場合
        //アニメーションを行わずにサイズを変更
        frame                      = self.contentView.frame;
        self.contentView.transform = transform;
        self.contentView.frame     = frame;
    }
    //前の端末の向き情報を更新
    self.previousOrientation = [UIDevice currentDevice].orientation;
}

#pragma mark - Notifications
//⬇Answer：こちはいつ呼ばれますか？
//端末の画面回転をNSNotificationCenterが認識したとき
- (void)orientationDidChangeNotification:(NSNotification *)notification
{
    [self updateOrientationAnimated:YES];
}

@end