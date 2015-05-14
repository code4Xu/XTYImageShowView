# XTYImageShowView

#import "XTYImageShowView.h"
/**
 *  Picture browsing
 *
 *  @param images      images array
 *  @param clickNumber current image index
 *  @param allow allow delete
 */



 [XTYImageShowView showWithImages:images andCurrenIndex:0 allowDelete:YES];
 
 if allowDelete = YES  need achieve delegate
 /**
 *  delete button click
 *
 *  @param index delete image index
 */


-(void)XTYImageShowViewDeleteButtonClickWithImageIndex:(NSInteger)index;
