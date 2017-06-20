//
//  AppDelegate.m
//  NSLock
//
//  Created by Visitor on 15/3/9.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    NSMutableArray *_dataArray;
    NSLock *_lock;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    // 线程锁、为了保护在多个线程中同时操作同一个变量，这个变量的安全性
    
    // 生产者消费者模型
    
    // 死锁(我们需要安排好线程执行的顺序，不要出现锁住一个变量再去执行操作另外一个变量的情况)
    
    _dataArray = [[NSMutableArray alloc] init];
    
    _lock = [[NSLock alloc] init];
    
    
    
    [self performSelectorInBackground:@selector(thread1) withObject:nil];
    [self performSelectorInBackground:@selector(thread2) withObject:nil];
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)thread1
{
    sleep(arc4random()%3);
    if(_dataArray.count<15)
    {
        // 加锁
        [_lock lock];
        [_dataArray addObject:@"1"];
        // 解锁
        [_lock unlock];
    }
//    [_lock lock];
//    sleep(10);
//    NSLog(@"thread1");
//    [_lock unlock];
}

- (void)thread2
{
    sleep(arc4random()%3);
    if(_dataArray.count>0)
    {
        
        [_lock lock];
        [_dataArray removeLastObject];
        [_lock unlock];
    }
//    [_lock lock];
//    sleep(5);
//    NSLog(@"thread2");
//    [_lock unlock];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
