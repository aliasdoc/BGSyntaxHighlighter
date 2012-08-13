//
//  BGCodeObject.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGCodeObject.h" 

@interface BGCodeObject()
@property NSMutableArray *lines;
@end

@implementation BGCodeObject
@synthesize lines = _lines;

- (id)initWithCodeString:(NSString *)codeString {
    
    self = [super init];
    if(self) {
        NSArray *lines = [codeString componentsSeparatedByString:@"\n"];
        self.lines = [NSMutableArray arrayWithArray:lines];
    }
    return self;
}

- (NSInteger)numberOfCodeLines {
    return [self.lines count];
}

- (NSString *)codeStringForLineAtIndex:(NSInteger)index {
    return [self.lines objectAtIndex:index];
}
@end
