//
//  ViewController.m
//  ClipboardExample
//
//  Created by Cristian Sava on 29/03/15.
//
//

#import "ViewController.h"
#import "SVToast.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *pasteTextButton;
@property (weak, nonatomic) IBOutlet UILabel *pastedTextLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inputTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inputTextFieldChanged:(UITextField *)sender
{
    if( [self.inputTextField.text length] ) self.pasteTextButton.enabled = YES;
    else self.pasteTextButton.enabled = NO;
    
    [self sendToClipboardText:self.inputTextField.text];
}

- (IBAction)pasteTextPressed:(UIButton *)sender
{
    NSString *clipboardText = self.fetchFromClipboard;
    
    if( [clipboardText length] )
    {
        self.pastedTextLabel.text = clipboardText;
        [self.view addSubview:[[SVToast alloc] initWithText:@"Text pasted." andTimeout:1.0]];
    }
    else [self.view addSubview:[[SVToast alloc] initWithText:@"Paste failed." andTimeout:1.0]];
}

// Hide the keyboard when Return is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)sendToClipboardText:(NSString *)text
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:text];
}

- (NSString *)fetchFromClipboard
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    return pb.string;
}

@end
