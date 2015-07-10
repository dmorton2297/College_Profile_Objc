//
//  DetailViewController.m
//  College_Profile_Objc
//
//  Created by Dan Morton on 7/9/15.
//  Copyright (c) 2015 Dan Morton. All rights reserved.
//

#import "DetailViewController.h"
#import "CollegeProfile-Swift.h"
#import "MapViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *populationTextField;
@property (weak, nonatomic) IBOutlet UIImageView *collegeImageView;

@end

@implementation DetailViewController : UIViewController

@synthesize college;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text = college.name;
    self.populationTextField.text = [NSString stringWithFormat:@"%ld", (long)college.population];
    self.collegeImageView.image = college.image;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1){
        college.name = textField.text;
    }
    else{
        NSInteger population = textField.text.integerValue;
        if (population){
            college.population = population;
        }
        else{
            textField.text = [NSString stringWithFormat:@"%ld",(long)college.population];
        }
    }
    
    [textField resignFirstResponder];
    return true;
}


- (IBAction)changePictureButtonTapped:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (! image)
        image = info[UIImagePickerControllerEditedImage];
    
    self.collegeImageView.image = image;
    college.image = image;
    [picker dismissViewControllerAnimated:true completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapViewController *dvc = (MapViewController *)segue.destinationViewController;
    dvc.locationName = college.name;
}
@end
