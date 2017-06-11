//
//  UIBarButtonItem+Extension.h
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  create UIBarButtonItem with UIButton
 *
 *  @param target      The target is the object to which the action message is sent which item is clicked
 *  @param action           A selector identifying an action message
 *  @param image            Normal Image
 *  @param highlightedImage  highlighted Image
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

@end
