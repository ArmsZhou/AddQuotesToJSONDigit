//
//  NSMutableString+AddQuotesToJSONDigit.m
//  QDSpark
//
//  Created by ucsmy on 16/7/20.
//  Copyright © 2016年 QD. All rights reserved.
//

#import "NSMutableString+AddQuotesToJSONDigit.h"

@implementation NSMutableString (AddQuotesToJSONDigit)

- (void)addQuotesToJSONDigit:(BOOL)checkJsonValid
{
    if (checkJsonValid) {
        id json = [NSJSONSerialization JSONObjectWithData: [self dataUsingEncoding: NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: nil];
        if (![NSJSONSerialization isValidJSONObject:json]) {
            return;
        }
    }
    
    NSInteger startIndex = -1;
    BOOL isScanArray = NO;
    BOOL isScanString = NO;
    
    for (NSInteger i = 0; i < self.length; i++)
    {
        unichar c = [self characterAtIndex:i];
        if (':' == c)
        {
            NSInteger j = i + 1;
            char nextC = [self characterAtIndex:j];
            while (' ' == nextC) {
                j++;
                nextC = [self characterAtIndex:j];
            }
            char nextNextC = [self characterAtIndex:j + 1];
            
            if ('"' == nextC)
            {
                isScanString = YES;
                i = j;
            }
            else if ('0' <= nextC && nextC <= '9' && !isScanString)
            {
                startIndex = j;
                i = j;
            }
            else if ('[' == nextC && '0' <= nextNextC && nextNextC <= '9' && !isScanString)
            {
                isScanArray = YES;
                startIndex = j + 1;
                i = j + 1;
            }
        }
        else if ('"' == c && isScanString)
        {
            isScanString = NO;
        }
        else if (!(('0' <= c && c <= '9') || '.' == c) && -1 != startIndex && !isScanString)
        {
            [self insertString: @"\"" atIndex: i];
            [self insertString: @"\"" atIndex: startIndex];
            i += 2;
            if (!isScanArray)
            {
                startIndex = -1;
            }
            else
            {
                if(',' == c)
                {
                    startIndex = i + 1;
                }
                else if(']' == c)
                {
                    isScanArray = NO;
                    startIndex = -1;
                }
            }
        }
    }
}

@end
