//
//  XTYImageShowView.m
//  JingXi
//
//  Created by 徐天宇 on 15/4/24.
//  Copyright (c) 2015年 lakala.com. All rights reserved.
//

#import "XTYImageShowView.h"
#import "AppDelegate.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define H(v)                    (v).frame.size.height
#define MaxY(v)                 CGRectGetMaxY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
@interface XTYImageShowView ()<UIScrollViewDelegate,UIActionSheetDelegate>
@property(strong,nonatomic)UIControl *overlayView;
@property(strong,nonatomic)UILabel *tipLabel;
@property(strong,nonatomic)UIScrollView *imageScrollView;
@property(strong,nonatomic)NSMutableArray *imageArrs;
@property(assign,nonatomic)NSInteger currenNumber;
@property(strong,nonatomic)UIButton * deleteButton;
@end

@implementation XTYImageShowView
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (!buttonIndex) {
        //删除
        [self deleteImage];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currenNumber = scrollView.contentOffset.x/ScreenWidth;
    [self updateTips];
}
-(void)updateTips
{
    NSString *tipText = [NSString stringWithFormat:@"%ld/%ld",self.currenNumber+1,(unsigned long)_imageArrs.count];
    _tipLabel.text = tipText;
}
-(void)deleteImage
{
    if ([self.delegate respondsToSelector:@selector(XTYImageShowViewDeleteButtonClickWithImageIndex:)]) {
        UIImageView *imageView = (UIImageView*)[self.imageScrollView viewWithTag:self.currenNumber*10+10];
        [UIView animateWithDuration:0.5 animations:^{
            [imageView setCenter:CGPointMake(MaxX(imageView), imageView.center.y)];
            [imageView setTransform:CGAffineTransformMakeScale(0.1,0.1)];
            [imageView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.delegate XTYImageShowViewDeleteButtonClickWithImageIndex:self.currenNumber];
            if (self.imageArrs.count) {
                [self.imageArrs removeObjectAtIndex:self.currenNumber];
            }
            [self reloadData];
        }];
        
    }else
    {
        NSLog(@"%@\n请指定delegate,并实现deleteButtonClickWithImageIndex:代理方法",[self class]);
    }
}

-(void)reloadData
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (self.currenNumber>0) {
        self.currenNumber -=1;
    }
    if (self.imageArrs.count) {
     
        [_imageScrollView setContentOffset:CGPointMake(ScreenWidth*(self.currenNumber), 0)];
        [self initViewAllowDelete:YES];
        [self updateTips];
        
    }else{
        [self disMiss];
    }
    
}
-(void)deleteButtonClicked
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"要删除这张照片吗?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    [actionSheet showInView:self];
}
-(void)initViewAllowDelete:(BOOL)allow
{
    self.backgroundColor = [UIColor blackColor];
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];

    [self updateTips];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor whiteColor];
    [self addSubview:_tipLabel];
    if (allow) {
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-H(_tipLabel),20 , H(_tipLabel), H(_tipLabel))];
        [_deleteButton setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
        [_deleteButton setTintColor:[UIColor whiteColor]];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
    }
    _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MaxY(_tipLabel), ScreenWidth, ScreenHeight-MaxY(_tipLabel))];
    _imageScrollView.delegate = self;
    _imageScrollView.backgroundColor = [UIColor clearColor];
    _imageScrollView.contentSize = CGSizeMake(ScreenWidth*_imageArrs.count, H(_imageScrollView));
    _imageScrollView.pagingEnabled = YES;
    for (int i = 0;i<_imageArrs.count;i++) {
        UIImage *image = _imageArrs[i];
        CGFloat imageHeight = image.size.height / image.size.width*ScreenWidth;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, H(_imageScrollView)/2-imageHeight/2, ScreenWidth, imageHeight)];
        imageView.image = image;
        imageView.tag = 10*i+10;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMiss)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        [_imageScrollView addSubview:imageView];
    }
    [_imageScrollView setContentOffset:CGPointMake(ScreenWidth*(_currenNumber), _imageScrollView.contentOffset.y)];
    [self addSubview:_imageScrollView];

}

-(void)disMiss
{
    
    [[XTYImageShowView shareXTYImageShowView].overlayView removeFromSuperview];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [XTYImageShowView shareXTYImageShowView].overlayView = nil;

}
+(void)showWithImages:(NSArray *)images andCurrenIndex:(NSInteger)index allowDelete:(BOOL)allow
{
    [XTYImageShowView shareXTYImageShowView].imageArrs = [NSMutableArray arrayWithArray:images];
    [XTYImageShowView shareXTYImageShowView].currenNumber = index;
    [[XTYImageShowView shareXTYImageShowView]initViewAllowDelete:allow];
    [[XTYImageShowView shareXTYImageShowView]show];
}
- (UIControl *)overlayView {
    if(!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.backgroundColor = [UIColor redColor];

    }
    return _overlayView;
}
+(XTYImageShowView *)shareXTYImageShowView
{
    static dispatch_once_t once;
    static XTYImageShowView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}
-(void)show
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self.overlayView];
            break;
        }
    }
    if (!self.superview) {
        [self.overlayView addSubview:self];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
