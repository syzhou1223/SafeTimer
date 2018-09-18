//
//  DetailViewController.m
//  SafaTimer
//
//  Created by zhouzhou on 2018/9/18.
//  Copyright © 2018年 zhouzhou. All rights reserved.
//

#import "DetailViewController.h"
#import "ForwardingObject.h"

#define Test 1
@interface DetailViewController () {
    UILabel *_tipsLabel;
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _tipsLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    _tipsLabel.font = [UIFont systemFontOfSize:30];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipsLabel];
    
    UIButton *tapButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [tapButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [tapButton setTitle:@"点我" forState:UIControlStateNormal];
    tapButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tapButton];
    
    
    __weak typeof(_tipsLabel) tipsLabel = _tipsLabel;
    __weak typeof(self) weakSelf = self;
    
    if (Test == 1) {
        //使用ForwardingObject来转发消息，不会出现NSTimer强引用住self的情况
        _timer = [NSTimer timerWithTimeInterval:1 target:[ForwardingObject forwardWithTarget:self] selector:@selector(refreshTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
    } else if (Test == 2) {
        //使用block，不会出现循环引用的情况，但是要iOS10以后再支持
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            tipsLabel.text = [[NSDate date] description];
            NSLog(@"%@ \n",[NSDate date]);
            
            [weakSelf refreshTime];
        }];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
    } else if (Test == 3) {
        //timer会强引用住self,导致self无法释放，dealloc不会执行，timer也会一直在后台执行
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
    } else if (Test == 4) {
        //给ForwaringObject发一个不存在的方法，不会crash
        ForwardingObject *obj = [[ForwardingObject alloc] init];
        [obj performSelector:@selector(refreshTime)];
    }
}

- (void)refreshTime {
    _tipsLabel.text = [[NSDate date] description];
    NSLog(@"refreshTime:%@",[NSDate date]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"DetailViewController dealloc");
    [self.timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
