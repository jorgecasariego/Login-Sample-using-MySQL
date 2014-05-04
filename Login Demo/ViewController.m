//
//  ViewController.m
//  Login Demo
//
//  Created by Jorge Casariego on 02/05/14.
//  Copyright (c) 2014 Jorge Casariego. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *_loginResponseData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // endEditing: This method looks at the current view and its subview hierarchy for the text field that is currently the first responder.
    // If it finds one, it asks that text field to resign as first responder
    [[self view] endEditing:TRUE];
}


- (IBAction)loginClicked:(id)sender
{
    //Test if all fields are filled
    if(self.usernameTextField.text.length > 0 && self.passwordTextField.text.length>0)
    {
        
        //Set request body
        NSString *loginDataString = [NSString stringWithFormat:@"Username=%@&Password=%@", self.usernameTextField.text, self.passwordTextField.text];
        
        //Fire off request to login
        [self createAndFireOffRequest:@"http://localhost:8888/sampleApp/login.php" withBody:loginDataString];
    }
    else
    {
        //Create the alert
        UIAlertView *missingFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        //Display the alert
        [missingFieldsAlert show];
    }
}

- (IBAction)newUserButtonClicked:(id)sender
{
    //Show registration field
    self.emailLabel.alpha = 1;
    self.emailTextField.alpha = 1;
    self.registerButton.alpha = 1;
    
    
    //Hide loggin button
    self.loginButton.alpha = 0;
    self.addUserButton.alpha = 0;
    
    
}

- (IBAction)registerClicked:(id)sender
{
    //Test if all fields are filled
    if(self.usernameTextField.text.length > 0 &&
       self.passwordTextField.text.length > 0 &&
       self.emailTextField.text.length > 0)
    {
        //Set request body
        NSString *registerDataString = [NSString stringWithFormat:@"Username=%@&Password=%@&Email=%@", self.usernameTextField.text, self.passwordTextField.text, self.emailTextField.text];
        
        //Fire off request to register
        [self createAndFireOffRequest:@"http://localhost:8888/sampleApp/adduser.php" withBody:registerDataString];
        
    }
    else
    {
        //Create the alert
        UIAlertView *missingFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        //Display the alert
        [missingFieldsAlert show];
    }
}

- (void)createAndFireOffRequest:(NSString *)url withBody:(NSString *)bodyString
{
    //Fire request to login the user
    NSURL *nsurl = [NSURL URLWithString:url];
    
    NSMutableURLRequest *resquest = [NSMutableURLRequest requestWithURL:nsurl];
    
    //Set the request method
    resquest.HTTPMethod = @"POST";
    
    //Set the request header values
    [resquest setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //Set request body
    NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //Set request body to request
    resquest.HTTPBody = data;
    
    [NSURLConnection connectionWithRequest:resquest delegate:self];
}

#pragma mark NSURLConnection Data Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //Initialize the data object
    _loginResponseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //Append the newly downloaded data
    [_loginResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithData:_loginResponseData encoding:NSUTF8StringEncoding];
    
    if([responseString isEqualToString:@"Logged in!"])
    {
        UIAlertView *logginAlert = [[UIAlertView alloc] initWithTitle:@"Logged In!" message:@"Loggin Successfully" delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];

        [logginAlert show];
        
        //Segue into home screen
    }
    else if([responseString isEqualToString:@"Loggin Faile!"])
    {
        UIAlertView *logginErrorAlert = [[UIAlertView alloc] initWithTitle:@"Logged In Failed!" message:@"Loggin Failed" delegate:self cancelButtonTitle:@"Cancel!" otherButtonTitles:nil];
        
        [logginErrorAlert show];
    }
    else if([responseString isEqualToString:@"User added"])
    {
        UIAlertView *registerAlert = [[UIAlertView alloc] initWithTitle:@"Register" message:@"Account created!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        
        [registerAlert show];
        
        //Segue into home screen
    }
}

@end
