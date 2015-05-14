//
//  ViewController.m
//  XTYImageShowView
//
//  Created by lakala on 15/5/14.
//  Copyright (c) 2015年 lakala. All rights reserved.
//

#import "ViewController.h"
#import "XTYImageShowView.h"
@interface ViewController ()<XTYImageShowViewDelegate>

@end

@implementation ViewController
-(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index
{
    NSLog(@"删除%d",index);
//这里进行删除图片后的相关操作
}
-(void)showImageManage
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (int i = 0 ;  i < 4 ; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",i]];
        [images addObject:image];
    }
    [XTYImageShowView shareXTYImageShowView].delegate = self;
    [XTYImageShowView showWithImages:images andCurrenIndex:0 allowDelete:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showImageManage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
