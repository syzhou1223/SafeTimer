//
//  ViewController.m
//  SafaTimer
//
//  Created by zhouzhou on 2018/9/18.
//  Copyright © 2018年 zhouzhou. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *tapButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [tapButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [tapButton setTitle:@"点我" forState:UIControlStateNormal];
    tapButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:tapButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapButton:(id)sender {
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self presentViewController:detailVC animated:YES completion:^{
        ;
    }];
}


@end
