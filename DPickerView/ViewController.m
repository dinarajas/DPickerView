//
//  ViewController.m
//  DPickerView
//
//  Created by Dinesh Raja on 21/06/13.
//  Copyright (c) 2013 dina.raja.s@gmail.com . All rights reserved.
//

#import "ViewController.h"
#import "PickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pickerViewButtonPressed:(id)sender {
    PickerViewController *pickerView = [[PickerViewController alloc]initWithNibName:@"PickerViewController" bundle:nil];
    [self.navigationController pushViewController:pickerView animated:YES];
}
@end
