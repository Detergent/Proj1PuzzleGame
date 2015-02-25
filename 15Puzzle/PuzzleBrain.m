//
//  PuzzleBrain.m
//  15Puzzle
//
//  Created by student on 2/23/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "PuzzleBrain.h"

@interface PuzzleBrain()

@property (nonatomic) int blankRow;
@property (nonatomic) int blankCol;
@property (nonatomic, strong) NSMutableArray *winBoard;
@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) NSMutableArray *copBoard;
@property (nonatomic) NSTimer * timer;
@property (nonatomic) int rowSearch;
@property (nonatomic) int colSearch;
@property (nonatomic) NSMutableArray *buttonTracker;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) int validMoves;

@end

@implementation PuzzleBrain


-(NSMutableArray*) board
{
    if(!_board){
        _winBoard = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_winBoard addObject:[[NSMutableArray alloc] initWithCapacity:4]];
        _board = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_board addObject:[[NSMutableArray alloc] initWithCapacity:4]];
    
        self.blankRow=3;
        self.blankCol=3;
        self.rowSearch=0;
        self.colSearch=0;
        self.validMoves=0;
        self.isAnimating=false;
    }
    return _board;
}

-(void) addButtons:(NSMutableArray*) buttons
{
    //Load buttons from array created in ViewController
    //into board and winBoard;
    for(int i=0; i<4; i++){
        self.board[0][i]=buttons[i];
        self.winBoard[0][i]=buttons[i];
    }
    for(int i=0; i<4; i++){
        self.board[1][i]=buttons[i+4];
        self.winBoard[1][i]=buttons[i+4];
    }
    for(int i=0; i<4; i++){
        self.board[2][i]=buttons[i+8];
        self.winBoard[2][i]=buttons[i+8];
    }
    for(int i=0; i<4; i++){
        self.board[3][i]=buttons[i+12];
        self.winBoard[3][i]=buttons[i+12];
    }
    
    
    NSLog(@"Current blankRow: %d", self.blankRow);
    NSLog(@"Current blankCol: %d", self.blankCol);
}

-(BOOL) moveButton: (NSString*) direction
{
    UIButton *tempBlank = self.board[self.blankRow][self.blankCol];
    if([direction isEqualToString:@"right"]){
        if(self.blankCol==0)
            return false;
        [self swapA:self.board[self.blankRow][self.blankCol-1] swapB:tempBlank];
        self.blankCol--;
        self.validMoves++;
    }
    if([direction isEqualToString:@"left"]){
        if(self.blankCol==3)
            return false;
        [self swapA:self.board[self.blankRow][self.blankCol+1] swapB:tempBlank];
        self.blankCol++;
        self.validMoves++;
    }
    if([direction isEqualToString:@"up"]){
        if(self.blankRow==3)
            return false;
        [self swapA:self.board[self.blankRow+1][self.blankCol] swapB:tempBlank];
        self.blankRow++;
        self.validMoves++;
    }
    if([direction isEqualToString:@"down"]){
        if(self.blankRow==0)
            return false;
        [self swapA:self.board[self.blankRow-1][self.blankCol] swapB:tempBlank];
        self.blankRow--;
        self.validMoves++;
    }
    self.board[self.blankRow][self.blankCol]=tempBlank;
    return true;
}

-(void) swapA:(UIButton *) buttonA swapB:(UIButton *) buttonB
{
    int aRow, aCol, bRow, bCol;
    for(int row=0; row<4; row++){
        for(int col=0; col<4; col++){
            if(self.board[row][col]==buttonA){
                aRow=row;
                aCol=col;
            }
            else if(self.board[row][col]==buttonB){
                bRow=row;
                bCol=col;
            }
        }
    }

    [self animateA:buttonA buttonB:buttonB];
    
    (NSLog(@"Button A switched with Button B"));
    self.board[aRow][aCol]=buttonB;
    self.board[bRow][bCol]=buttonA;
    
}
-(void) animateA:(UIButton *) buttonA buttonB:(UIButton*) buttonB
{
    self.isAnimating=TRUE;
    CGRect tempFrame = buttonA.frame;
    [UIView animateWithDuration:.5 animations:^{
        buttonA.frame=buttonB.frame;
        buttonB.frame=tempFrame;
    } completion:^(BOOL finished) {
        self.isAnimating=false;
    }];
}

-(BOOL) shouldTheGameContinue
{
    if(self.validMoves==0)
        return true;
    for(int row=0; row<4; row++)
        for(int col=0; col<4; col++)
            if(self.board[row][col]!=self.winBoard[row][col])
                return true;
    return false;
}

-(void) resetGame:(NSMutableArray*) buttons;
{
    self.copBoard=[[NSMutableArray alloc] initWithArray:self.winBoard copyItems:YES];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(timeHandler:) userInfo:nil repeats:YES];
    self.buttonTracker=buttons;
    self.blankRow=3;
    self.blankCol=3;
    self.validMoves=0;
}
-(void) timeHandler:(NSTimer*) timer
{
    int row=self.rowSearch;
    int col=self.colSearch;
    
    if(self.board[row][col]!=self.copBoard[row][col])
        [self swapA:self.board[row][col] swapB:self.copBoard[row][col]];
    
    self.colSearch++;
    if(self.rowSearch==3 && self.colSearch==3){
        self.rowSearch=0;
        self.colSearch=0;
        self.copBoard=nil;
        [self addButtons:self.buttonTracker];
        [timer invalidate];
        return;
    }
    else if(self.colSearch>3){
        self.colSearch=0;
        self.rowSearch++;
    }

}

-(void) shuffleBoard:(int) num
{
    
}

@end