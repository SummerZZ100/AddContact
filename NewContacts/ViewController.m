//
//  ViewController.m
//  NewContacts
//
//  Created by ZhangXiaosong on 2018/11/21.
//  Copyright © 2018 ZhanXiaosong. All rights reserved.
//

#import "ViewController.h"
#import "ContactTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    
    [button setTitle:@"添加客服" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(100, 100, 100, 40)];
    [button addTarget:self action:@selector(btnClikc) forControlEvents:UIControlEventTouchUpInside];
    
}
    
    -(void)btnClikc
    {
        ContactTool *contactTool = [[ContactTool alloc] init];
        [contactTool createPhoneContact];
    }


@end
