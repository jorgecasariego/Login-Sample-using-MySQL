//
//  ViewController.h
//  Login Demo
//
//  Created by Jorge Casariego on 02/05/14.
//  Copyright (c) 2014 Jorge Casariego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *addUserButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end
