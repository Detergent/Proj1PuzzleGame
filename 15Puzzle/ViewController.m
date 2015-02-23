//
//  ViewController.m
//  15Puzzle
//
//  Created by Justin Guarino on 2/22/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "ViewController.h"
#import "PuzzleBrain.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *onePos;
@property (weak, nonatomic) IBOutlet UIButton *twoPos;
@property (weak, nonatomic) IBOutlet UIButton *threePos;
@property (weak, nonatomic) IBOutlet UIButton *fourPos;
@property (weak, nonatomic) IBOutlet UIButton *fivePos;
@property (weak, nonatomic) IBOutlet UIButton *sixPos;
@property (weak, nonatomic) IBOutlet UIButton *sevenPos;
@property (weak, nonatomic) IBOutlet UIButton *eightPos;
@property (weak, nonatomic) IBOutlet UIButton *ninePos;
@property (weak, nonatomic) IBOutlet UIButton *tenPos;
@property (weak, nonatomic) IBOutlet UIButton *elevenPos;
@property (weak, nonatomic) IBOutlet UIButton *twelvePos;
@property (weak, nonatomic) IBOutlet UIButton *thirteenPos;
@property (weak, nonatomic) IBOutlet UIButton *fourteenPos;
@property (weak, nonatomic) IBOutlet UIButton *fifteenPos;
@property (weak, nonatomic) IBOutlet UIButton *blankPos;
@property (weak, nonatomic) IBOutlet UIButton *shufle;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UISlider *difficulty;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"View did load.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSwipeTile:(UIButton *)sender{
    NSLog(@"tile slide");
}
- (IBAction)swipeGestureCheck:(UISwipeGestureRecognizer *)sender{
    NSLog(@"Swipe gesture recognized");
    
}
- (IBAction)didTapShuffle:(UIButton *)sender{
    NSLog(@"Shuffle pressed");
}

- (IBAction)didTapReset:(UIButton *)sender{
    NSLog(@"Reset pressed");
}

- (IBAction)didMoveSlider:(UISlider *)sender{
    NSLog(@"Slider moved");
}

@end
