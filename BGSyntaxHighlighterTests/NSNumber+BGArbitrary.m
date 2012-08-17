//
//  NSNumber+BGArbitrary.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+BGArbitrary.h"
#import "NLTQuickCheck.h"

@implementation NSNumber (BGArbitrary)
+ (id)scrollYArbitrary {
    NLTQGen *quadratic = [NLTQGen quadraticGenWithA:1<<16 b:1 c:1];
    NLTQGen *doubleGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        NLTQGen *chooser = [NLTQGen randomGen];
        [chooser resizeWithMinimumSeed:-random maximumSeed:+random];
        random = [[chooser valueWithProgress:progress] intValue];
        int place = [[NSString stringWithFormat:@"%d",random] length] - 2;
        int l = [[NLTQStandardGen standardGenWithMinimumSeed:2 maximumSeed:place] currentGeneratedValue];
        int base = 10;
        for (int i = 1; i < l; i++) {
            base *= 10;
        }
        return [NSNumber numberWithDouble:(double)random/(double)base];
        
    }];
    [doubleGen bindingGen:quadratic];
    return doubleGen;    
}
@end
