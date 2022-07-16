import 'chess_piece_data.dart';
import 'package:flutter/material.dart';
import 'data_array.dart';
import 'package:provider/provider.dart';
import'utils.dart';


int border = 0;


bool checkforRook(ChessPieceData pieceData , int index, int letter, BuildContext context , bool queen ){
  if(pieceData.name == 'rW' || pieceData.name == 'rB'|| queen){
    if(pieceData.letter == letter || pieceData.index == index){
   // If there  is a piece that block the road in the down return false  
   if(pieceData.index  < index) {
    for(int i = 1; i<  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), letter)[1] != "N" ){
        print("Ok");
        return  false;}
    }}
    // If there is a piece that block the  road in the up return false
    else if(pieceData.index  > index) {
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), letter)[1] != "N" ){
        print("qqa");
        return false;}
    }}
    // If there is a piece that block the road in the left return false
    else if(pieceData.letter  > letter) {
      for(int i = 1; i <  (letter - pieceData.letter ).abs() ; i++){
      if(context.read<DataArray>().getPiece(index, clampBorder(pieceData.letter -i))[1] != "N" ){
        print("qqa");
        return false;}
    }}
    // If there is a piece that block the road in the right return false
    else if(pieceData.letter < letter){
    for(int i = 1; i < (letter - pieceData.letter).abs() ; i++){
      if(Provider.of<DataArray>(context,listen:false).getPiece(index, clampBorder(pieceData.letter + i))[1] != "N" ){
        print([pieceData.letter, letter] );
        return  false;}
    }}

    // create an if statement that check if the space has a piece with same color of the pieceData
    // if so return false
    if(Provider.of<DataArray>(context,listen:false).getPiece(index, letter)[2] == pieceData.color){
      print("Is the same color");
      return false;
    }

    return true;
    }
  }
  return false;
}

bool checkforKing(ChessPieceData pieceData , int index, int letter, BuildContext context ){
  if(pieceData.name == 'kingW' || pieceData.name == 'kingB'){
int l= pieceData.letter;
int i  = pieceData.index;
Function getPiece = context.read<DataArray>().getPiece;
bool move = clampBorder(l + 1) == letter  && i == index 
          ||clampBorder(l- 1) == letter && i == index 
          ||clampBorder(i + 1) == index  && l == letter 
          ||clampBorder(i -1) == index && l == letter 
          ||clampBorder(l + 1) == letter && clampBorder(i + 1) == index 
          ||clampBorder(l - 1) == letter && clampBorder(i - 1) == index 
          ||clampBorder(l + 1) == letter && clampBorder(i - 1 )== index 
          ||clampBorder(l - 1) == letter && clampBorder(i + 1) == index ;
    if(!move ){
      return false;
    }
    if(getPiece(index, letter)[2] == pieceData.color){
      print("Is the same color");
      return false;
    }
    return true;
  }
  return false;

}

bool checkforBishop(ChessPieceData pieceData , int index, int letter, BuildContext context, bool queen){
  if(pieceData.name == 'bW' || pieceData.name == 'bB' || queen){

    if(context.read<DataArray>().getPiece(index, letter)[2] == pieceData.color ){
      print("same color");
      return false;
    }
    // check if letter and index are in the full diogonal of the piece.
    for(int i = 1; i < 8; i++){
      // Down right
      if(pieceData.index + i == index && pieceData.letter + i == letter){
        print("yess");
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), clampBorder(pieceData.letter + i))[1] != "N" ){
        print("Down right");
        return false;
        }
        }
        return true;
       
      }
      //Down Left
      if(pieceData.index + i == index && pieceData.letter - i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), clampBorder(pieceData.letter - i))[1] != "N" ){
        print("DownLeft");
        return false;
        }
       }
       return true;
      }
      //Up right
      if(pieceData.index - i == index && pieceData.letter + i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), clampBorder(pieceData.letter + i))[1] != "N" ){
        print("Up right");
        return false;
        }
       }
       return true;
      }
      //Up left
      if(pieceData.index - i == index && pieceData.letter - i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() -1 ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), clampBorder(pieceData.letter - i))[1] != "N" ){
        print("Up left");
        return false;
        }
       }
        return true;
      }
    }
  }
  print([pieceData.index, pieceData.letter, index, letter]);
  return false;
}

bool checkforQueen(ChessPieceData pieceData , int index, int letter, BuildContext context){
  if(pieceData.name == 'qW' || pieceData.name == 'qB'){
    if(pieceData.letter == letter || pieceData.index == index){
      return true;
    }
    // check if letter and index are in the full diogonal of the piece.
    for(int i = 1; i < 8; i++){
      if(pieceData.letter + i == letter && pieceData.index + i == index){
        return true;
      }
      if(pieceData.letter - i == letter && pieceData.index + i == index){
        return true;
      }
      if(pieceData.letter + i == letter && pieceData.index - i == index){
        return true;
      }
      if(pieceData.letter - i == letter && pieceData.index - i == index){
        return true;
      }
    }

  }
  return false;
}

bool checkforPawn(ChessPieceData pieceData , int index, int letter, BuildContext context){
  if (pieceData.letter == 7 || pieceData.letter == 0 || pieceData.index == 7 || pieceData.index == 0){
    border = 0;
  }
  else{
    border = 1;
  }
  if(pieceData.name == "pW"){
    // Behaviour for the white pawn.
       //Check if the piece has others pieces in his front diagonal to see if is possible to take a piece.
     if((context.read<DataArray>().getPiece(pieceData.index - 1, clampBorder(pieceData.letter+ 1))[1] != "N"||
    context.read<DataArray>().getPiece(pieceData.index - 1, clampBorder(pieceData.letter - 1) )[1] != "N")
    && pieceData.index - 1 == index && pieceData.letter != letter&&
    context.read<DataArray>().getPiece(pieceData.index - 1, clampBorder(pieceData.letter + 1))[2] != "white"&&
    context.read<DataArray>().getPiece(pieceData.index - 1, clampBorder(pieceData.letter +1))[2] != "white"){
      print([pieceData.index, index] );
      return true;
    }
        // If there is a Pieces  in front cancel the move.
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 1) , pieceData.letter)[1] != "N"){
      return false;
    }
        // Check if there is no Pieces ahead so the pawn can move forward
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 1) , pieceData.letter )[1] == "N"
    && pieceData.index - 1 == index && pieceData.letter == letter){
      print([pieceData.index, index]);
      return true;
    }
    
  }
  if(pieceData.name == "pB"){
    // The same behavior as before with the change that this is for the black pawn.
    //Check if the piece has others pieces in his front diagonal to see if is possible to take a piece.
    if((context.read<DataArray>().getPiece(pieceData.index + 1, pieceData.letter+ border)[1] != "N"||
    context.read<DataArray>().getPiece(pieceData.index + 1, pieceData.letter- border)[1] != "N")&&
    pieceData.index + 1 == index && pieceData.letter != letter&&
    context.read<DataArray>().getPiece(pieceData.index + 1, pieceData.letter - border)[2] != "black"&&
    context.read<DataArray>().getPiece(pieceData.index + 1, pieceData.letter + border)[2] != "black"){
      print([pieceData.letter, letter]);
      print("mmmeq");
      return true;
    }
    // If there is a Pieces  in front cancel the move.
    if(context.read<DataArray>().getPiece(pieceData.index +1 , pieceData.letter)[1] != "N"){
      return false;
    }
    // Check if there is no Pieces ahead so the pawn can move forward
    if(context.read<DataArray>().getPiece(pieceData.index + 1 , pieceData.letter )[1] == "N"
    && pieceData.index + 1 == index && pieceData.letter == letter){
      print([pieceData.index, index]);
      return true;
    }
  }
  return false;
}

bool checkforKnight(ChessPieceData pieceData , int index, int letter, BuildContext context){
  if(pieceData.name == "kW" || pieceData.name == "kB"){
    if(pieceData.letter + 2 == letter && pieceData.index + 1 == index){
      return true;
    }
    if(pieceData.letter + 2 == letter && pieceData.index - 1 == index){
      return true;
    }
    if(pieceData.letter - 2 == letter && pieceData.index + 1 == index){
      return true;
    }
    if(pieceData.letter - 2 == letter && pieceData.index - 1 == index){
      return true;
    }
    if(pieceData.letter + 1 == letter && pieceData.index + 2 == index){
      return true;
    }
    if(pieceData.letter + 1 == letter && pieceData.index - 2 == index){
      return true;
    }
    if(pieceData.letter - 1 == letter && pieceData.index + 2 == index){
      return true;
    }
    if(pieceData.letter - 1 == letter && pieceData.index - 2 == index){
      return true;
    }
  }
  return false ;
}

// Create a function that check if a piece can move to a cell.
// If there is no other piece that block his cell

