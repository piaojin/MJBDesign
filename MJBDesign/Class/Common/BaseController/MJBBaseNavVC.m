//
//  MJBBaseNavVC.m
//  MJBangProject
//
//  Created by DavidWang on 16/7/25.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "MJBBaseNavVC.h"

@interface MJBBaseNavVC ()

@end

@implementation MJBBaseNavVC

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
