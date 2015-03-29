# ios-toast
A simple and lightweight Android-type popup (Toast) for iOS. Appears centered inside the parent view, has round corners and a bit of alpha.

# Usage
- Import the the .h and the .m files inside the project
- <code>#import "SVToast.h"</code> inside the targeted View Controller source file
- Call the Toast init function while specifying the desired text and display timeout in seconds
  <br><code>[self.view.superview addSubview:[[SVToast alloc] initWithText:@"Toast text here." andTimeout:1.0]];</code>
- The toast can also be shown on a previous View Controller, in case the current one will be dismissed right away. In this case, before calling <code>dismissViewControllerAnimated:completion:</code>, you can present the toast using<br>
  <code>[self.previousViewController.view addSubview:[[SVToast alloc] initWithText:@"Success" andTimeout:1.5]];</code>
