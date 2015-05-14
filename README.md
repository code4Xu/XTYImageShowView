# XTYImageShowView

导入#import "XTYImageShowView.h"
/**
 *  显示图片查看器
 *
 *  @param images      图片数组
 *  @param clickNumber 当前图片下标
 *  @param allow 允许删除
 */
 [XTYImageShowView showWithImages:images andCurrenIndex:0 allowDelete:YES];
 
 如果allowDelete = YES  需要实现delegate
 /**
 *  删除图片回调
 *
 *  @param index 返回图片下标
 */
-(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index;
