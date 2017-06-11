//
//  WBEmotionTextView.m
//  微博
//
//  Created by BJT on 17/6/1.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionTextView.h"
#import "WBEmotion.h"
#import "WBEmotionAttachment.h"

@implementation WBEmotionTextView

-(void)insertEmotion:(WBEmotion *)emotion
{
    if (emotion.code) { // emoji
        
        // 替换光标选中文本
        [self insertText:[emotion.code emoji]];
        
    }else if(emotion.png){
        
        // 创建表情附件
        WBEmotionAttachment *attachment = [[WBEmotionAttachment alloc] init];
        attachment.emotion = emotion;
        // 设置 位置/尺寸
        CGFloat attachWH = self.font.lineHeight;
        attachment.bounds = CGRectMake(0, -4, attachWH , attachWH);
        
        NSMutableAttributedString *attachStrM = [NSMutableAttributedString mutableAttributedStringWithAttachment:attachment];
        // 添加字体属性,解决 textView 输入 文字/表情变小的问题
        [attachStrM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attachStrM.length)];
        
        [self insertAttributeText:attachStrM];
        

    }
    
}
/**
 *  把表情转换成相应文本,构成一个完整的微博文本内容
 */
-(NSString *)fullText
{
    //    WBLog(@"%@----%@",self.text,self.attributedText.string);
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        WBEmotionAttachment *emotionAtt = attrs[@"NSAttachment"];
        WBEmotion *emotion = emotionAtt.emotion;
        
        if (emotion) { // 表情, 把 表情附件 转成 表情描述文本
            
            [fullText appendString:emotion.chs];
        }else{  // 普通文本
            
            NSAttributedString *attStr = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:attStr.string];
        }
        
//        WBLog(@"%@",attrs);
//        WBLog(@"%@",NSStringFromRange(range));
        
    }];
    
//    WBLog(@"%@",fullText);
    
    return fullText;
}



@end
