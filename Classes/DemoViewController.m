//
//
//  initiated by Jason Lam (cofounder @WaveSpread) on 8/28/11.
//  Copyright 2012 keyboards.hk
//
//  Initiators/root branches
//      iOS code: https://github.com/jasonlamkk/iOSNumPadDoneButton/
//      Concept and Graphic Reference : 2008/2009 Neoos GmbH
//      http://www.neoos.ch/blog/37-uikeyboardtypenumberpad-and-the-missing-return-key
//      Major Update :
//        - support multiple textfields in same page, each of different type
//        - support dynamic done button text by using empty button background image and textlable 
//  Contributors:
//      https://github.com/jasonlamkk/iOSNumPadDoneButton/contributors
//

#import "DemoViewController.h"


@implementation DemoViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 26)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.returnKeyType = UIReturnKeyDone;
    textField.textAlignment = UITextAlignmentLeft;
    textField.text = @"12345";
    textField.delegate = self;
    [self.view addSubview:textField];
    
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.keyboardType = UIKeyboardTypeEmailAddress;
    textField2.returnKeyType = UIReturnKeyDone;
    textField2.textAlignment = UITextAlignmentLeft;
    textField2.text = @"amail@gmail.com";
    textField2.delegate = self;
    [self.view addSubview:textField2];
    
    UITextField * textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 300, 30)];
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.keyboardType = UIKeyboardTypePhonePad;
    textField3.returnKeyType = UIReturnKeySearch;
    textField3.textAlignment = UITextAlignmentLeft;
    textField3.text = @"1234";
    textField3.delegate = self;
    [self.view addSubview:textField3];
    [textField3 release];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void) check{
    
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)_textField{
    /*BOOL showNow = NO;
    if (_keyboardIsShowing) {
        if (_lastKeyboardType!=UIKeyboardTypeNumberPad && 
        _lastKeyboardType!=UIKeyboardTypePhonePad) {
            showNow = YES;
        }
    }*/
    UIKeyboardType tmpKeyType = _lastKeyboardType;
    //UIReturnKeyType tmpReturnKeyType = _lastReturnKeyType;
    _lastKeyboardType = _textField.keyboardType;
    _lastReturnKeyType = _textField.returnKeyType;
    switch (tmpKeyType) {
        //last one open custom button
        case UIKeyboardTypePhonePad:
        case UIKeyboardTypeNumberPad:
            switch (_textField.keyboardType) {
                case UIKeyboardTypePhonePad:
                case UIKeyboardTypeNumberPad:
                    //do nothing
                    break;
                    
                default:
                    
                    [self performSelector:@selector(hideCustomKeyboardDoneButton) withObject:nil afterDelay:0.1];
                    
                    break;
            }
            break;
            
        // last one hide custom button
        default:
            switch (_textField.keyboardType) {
                case UIKeyboardTypePhonePad:
                case UIKeyboardTypeNumberPad:
                    [self performSelector:@selector(showCustomKeyboardDoneButton) withObject:nil afterDelay:0.1];
                    break;
                    
                default:
                      //do nothing
                    break;
            }
            break;
    }
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)_textField{
    weakRefTextField = _textField;
}
-(BOOL) textFieldShouldEndEditing:(UITextField *)_textField{
    return YES;
    
}
-(void) hideCustomKeyboardDoneButton{
    _lastReturnKeyType = 0;
    _lastKeyboardType = 0;
    if (numberPadDoneButton) {
        [numberPadDoneButton removeFromSuperview];
    }
}
-(void) showCustomKeyboardDoneButton{
    
    if ([[[UIApplication sharedApplication] windows] count]<2) {
        [self performSelector:@selector(showCustomKeyboardDoneButton) withObject:nil afterDelay:0.1];
    }
    
    
    if (nil==numberPadDoneButton) {
        numberPadDoneButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        numberPadDoneButton.adjustsImageWhenHighlighted =NO;
        if ([[[UIDevice currentDevice] systemVersion] hasPrefix:@"3"]) {
            [numberPadDoneButton setBackgroundImage:[UIImage imageNamed:@"EmptyUp3.png"] forState:UIControlStateNormal];
            UIImage * imageDown3 = [UIImage imageNamed:@"EmptyDown3.png"];
            [numberPadDoneButton setBackgroundImage:imageDown3 forState:UIControlStateHighlighted];
            [numberPadDoneButton setBackgroundImage:imageDown3 forState:UIControlStateSelected];
            
        } else { 
            [numberPadDoneButton setBackgroundImage:[UIImage imageNamed:@"EmptyUp.png"] forState:UIControlStateNormal];
            
            UIImage * imageDown = [UIImage imageNamed:@"EmptyDown.png"];
            [numberPadDoneButton setBackgroundImage:imageDown forState:UIControlStateHighlighted];
            [numberPadDoneButton setBackgroundImage:imageDown forState:UIControlStateSelected];
        }
        
        //numberPadDoneButton.titleLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
        [numberPadDoneButton.titleLabel setFont:[UIFont fontWithName:@"Courier-Bold" size:18.f]];
        ///numberPadDoneButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [numberPadDoneButton setTitleColor: [UIColor colorWithRed:76.0/255.0 green:85.0/255.0 blue:98.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [numberPadDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [numberPadDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        numberPadDoneButton.userInteractionEnabled = YES;
        numberPadDoneButton.enabled = YES;
        //numberPadDoneButton.showsTouchWhenHighlighted = YES;
        numberPadDoneButton.clearsContextBeforeDrawing =YES;
        numberPadDoneButton.clipsToBounds = YES;
    
        [numberPadDoneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    // create custom button
    
    // locate keyboard view
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    NSLog(@"%d",_keyboardIsShowing);
    if (_keyboardIsShowing) {
        numberPadDoneButton.frame = CGRectMake(0, 480-53, 106, 53);
        [tempWindow addSubview:numberPadDoneButton];
    }else{
        numberPadDoneButton.frame = CGRectMake(0, 480-53+163, 106, 53);
        [tempWindow addSubview:numberPadDoneButton];
       
        [UIView animateWithDuration:0.15 animations:^(void){
        
            numberPadDoneButton.frame = CGRectMake(0, 480-53, 106, 53);
        }];
    
    }
    
    _keyboardIsShowing = YES;
    /*}else{
        
        numberPadDoneButton.frame = CGRectMake(0, 163, 106, 53);
        UIView* keyboard;
        for(int i=0; i<[tempWindow.subviews count]; i++) {
            keyboard = [tempWindow.subviews objectAtIndex:i];
            // keyboard view found; add the custom button to it
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:numberPadDoneButton];
        }
    }*/
    switch (_lastReturnKeyType) {
        case UIReturnKeyGo:
            [numberPadDoneButton setTitle:@"Go" forState:UIControlStateNormal];
            break;
        
        default:
            [numberPadDoneButton setTitle:@"Done" forState:UIControlStateNormal];
            break;
    }
}
-(void) textFieldDidEndEditing:(UITextField *)_textField{
    [self hideCustomKeyboardDoneButton];
}
/*
- (void)keyboardWillChange:(NSNotification *)note {
    NSLog(@"keyboardWillChange");
}*/
- (void)keyboardWillHide:(NSNotification *)note {
    _keyboardIsShowing = NO;
}
- (void)keyboardWillShow:(NSNotification *)note { 
    return;
    switch (_lastKeyboardType) {
        case UIKeyboardTypePhonePad:
        case UIKeyboardTypeNumberPad:
            [self showCustomKeyboardDoneButton];
            break;
            
        default:
            break;
    }
}

- (void)doneButton:(id)sender {
    if (weakRefTextField) {
        [weakRefTextField resignFirstResponder];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [textField release];
    [textField2 release];
    [super dealloc];
}


@end
