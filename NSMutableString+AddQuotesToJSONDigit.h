//
//  NSMutableString+AddQuotesToJSONDigit.h
//  QDSpark
//
//  Created by ucsmy on 16/7/20.
//  Copyright © 2016年 QD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (AddQuotesToJSONDigit)

/**
 *  对JSONString里的数值value添加引号转为字符类型，防止精度缺失
 *
 *  @param checkJsonValid 转换前是否检测JSON合法性
 */
- (void)addQuotesToJSONDigit:(BOOL)checkJsonValid;

@end
