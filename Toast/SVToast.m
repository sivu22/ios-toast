/*
 Copyright (c) 2014 Cristian Sava <cristianzsava@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE
 */

#import "SVToast.h"

@interface SVToast ()

@property (readwrite, nonatomic) NSTimeInterval timeout;

@end

@implementation SVToast

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithText:(NSString *)text andTimeout:(NSTimeInterval)timeout
{
    self = [self init];
    if( self != nil )
    {
        self.text = text;
        _timeout = timeout;
        if( _timeout <= 0.0f ) _timeout = TOAST_DEFAULT_TIMEOUT;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        self.textColor = [UIColor colorWithWhite:1.0f alpha:0.95f];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
                                | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    return self;
}

- (void)didMoveToSuperview
{
    UIView *parent = self.superview;
    
    if( parent )
    {
        CGSize maximumLabelSize = CGSizeMake( 300, 200 );
        CGRect textRect = [self.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil];
        CGSize expectedLabelSize = CGSizeMake( textRect.size.width, textRect.size.height );
        expectedLabelSize = CGSizeMake( expectedLabelSize.width + 40, expectedLabelSize.height + 40 );
        
        self.frame = CGRectMake( parent.center.x - expectedLabelSize.width / 2, parent.center.y - expectedLabelSize.height / 2,
                                    expectedLabelSize.width, expectedLabelSize.height );
        
        CALayer *layer = self.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 8.0f;
        
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:_timeout];
    }
}

- (void)dismiss:(id)sender
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^ { self.alpha = 0; }
                     completion:^ (BOOL finished) { [self removeFromSuperview]; }];
}

@end
