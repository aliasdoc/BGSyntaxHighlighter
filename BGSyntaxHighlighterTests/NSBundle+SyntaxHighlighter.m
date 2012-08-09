//
//  NSBundle+SyntaxHighlighter.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSBundle+SyntaxHighlighter.h"

@implementation NSBundle (SyntaxHighlighter)
+ (NSString *)codeStringForResouce:(NSString *)resouce ofType:(NSString*)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:resouce ofType:type];
    NSString *soruce = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:NULL];
    return soruce;
}
@end
