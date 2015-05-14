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
 *  when delete button clicked
 *
 *  @param index The current image index
 */
-(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index;
@end
/**
 *  imagesShow
 */
@interface XTYImageShowView : UIView
@property(weak,nonatomic)id<XTYImageShowViewDelegate>delegate;
/**
 *  singleton
 *
 *  @return XTYImageShowView
 */
+(XTYImageShowView *)shareXTYImageShowView;
/**
 *  show imagesWithScorll
 *
 *  @param images       images array
 *  @param index        curren image index
 *  @param isAllow      if allow is Yes ,allow delete image. Need to achieve
 -(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index;
 */
+(void)showWithImages:(NSArray *)images andCurrenIndex:(NSInteger)index allowDelete:(BOOL)isAllow;
@end
