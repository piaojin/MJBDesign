//
//  PJExceptionHandler.h
//  MJBDesign
//
//  Created by 美家帮 on 2016/12/23.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJExceptionHandler : NSObject{
   
    BOOL dismissed;
}

@end

void HandleException(NSException *exception);

void SignalHandler(int signal);

void InstallUncaughtExceptionHandler(void);
