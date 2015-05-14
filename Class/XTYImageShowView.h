//
//  XTYImageShowView.h
//  JingXi
//
//  Created by 徐天宇 on 15/4/24.
//  Copyright (c) 2015年 lakala.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTYImageShowViewDelegate <NSObject>
@required
/**
 *  删除图片回调
 *
 *  @param index 返回图片下标
 */
-(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index;
@end
/**
 *  图片查看器
 */
@interface XTYImageShowView : UIView
@property(weak,nonatomic)id<XTYImageShowViewDelegate>delegate;
/**
 *  返回imageShowView实例
 *
 *  @return XTYImageShowView
 */
+(XTYImageShowView *)shareXTYImageShowView;
/**
 *  显示图片查看器
 *
 *  @param images      图片数组
 *  @param clickNumber 当前图片下标
 *  @param allow 允许删除
 */
+(void)showWithImages:(NSArray *)images andCurrenIndex:(NSInteger)index allowDelete:(BOOL)allow;
@end
