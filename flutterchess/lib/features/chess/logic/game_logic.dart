import '../repository/chess_piece_data.dart';
import 'package:flutter/material.dart';
import 'package:flutterchess/features/chess/data/game_controller_provider.dart';
import 'package:provider/provider.dart';
import'utils.dart';
import 'package:vector_math/vector_math.dart';
import '../data/data_array_provider.dart';
import 'package:flutterchess/features/main_window/data/widget_on_screen.dart';



bool checkforRook(ChessPieceData pieceData , int index, int letter, BuildContext context, bool queen, isMock  ){
  if(pieceData.name == 'rW' || pieceData.name == 'rB'|| queen){
    if(pieceData.letter == letter || pieceData.index == index){
   // If there  is a piece that block the road in the down return false  
   if(pieceData.index  < index) {
    for(int i = 1; i<  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), letter, isMock)[1] != "N" ){
        return  false;}
    }}
    // If there is a piece that block the  road in the up return false
    else if(pieceData.index  > index) {
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), letter, isMock)[1] != "N" ){
        return false;}
    }}
    // If there is a piece that block the road in the left return false
    else if(pieceData.letter  > letter) {
      for(int i = 1; i <  (letter - pieceData.letter ).abs() ; i++){
      if(context.read<DataArray>().getPiece(index, clampBorder(pieceData.letter -i), isMock)[1] != "N" ){
        return false;}
    }}
    // If there is a piece that block the road in the right return false
    else if(pieceData.letter < letter){
    for(int i = 1; i < (letter - pieceData.letter).abs() ; i++){
      if(Provider.of<DataArray>(context,listen:false).getPiece(index, clampBorder(pieceData.letter + i), isMock)[1] != "N" ){
        return  false;}
    }}

    // create an if statement that check if the space has a piece with same color of the pieceData
    // if so return false
    if(Provider.of<DataArray>(context,listen:false).getPiece(index, letter, isMock)[2] == pieceData.color){
      return false;
    }


    return true;
    }
  }
  return false;
}

bool checkforKing(ChessPieceData pieceData , int index, int letter, BuildContext context, bool isMock ){
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
    if(getPiece(index, letter, isMock)[2] == pieceData.color){
      return false;
    }
    return true;
  }
  return false;

}

bool checkforBishop(ChessPieceData pieceData , int index, int letter, BuildContext context, bool queen, isMock){
  if(pieceData.name == 'bW' || pieceData.name == 'bB'|| queen ){

    if(context.read<DataArray>().getPiece(index, letter, isMock)[2] == pieceData.color ){
      return false;
    }
    // check if letter and index are in the full diogonal of the piece.
    for(int i = 1; i < 8; i++){
      // Down right
      if(pieceData.index + i == index && pieceData.letter + i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), clampBorder(pieceData.letter + i), isMock)[1] != "N" ){
        return false;
        }
        }
        return true;
       
      }
      //Down Left
      if(pieceData.index + i == index && pieceData.letter - i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +i), clampBorder(pieceData.letter - i), isMock)[1] != "N" ){
        return false;
        }
       }
       return true;
      }
      //Up right
      if(pieceData.index - i == index && pieceData.letter + i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), clampBorder(pieceData.letter + i), isMock)[1] != "N" ){
        return false;
        }
       }
       return true;
      }
      //Up left
      if(pieceData.index - i == index && pieceData.letter - i == letter){
        for(int i = 1; i <  (index - pieceData.index ).abs() ; i++){
      if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -i), clampBorder(pieceData.letter - i), isMock)[1] != "N" ){
        return false;
        }
       }
        return true;
      }
    }
  }
  return false;
}

bool checkforQueen(ChessPieceData pieceData , int index, int letter, BuildContext context, bool isMock){
  if(pieceData.name == "qW" || pieceData.name == "qB"){
  if(checkforBishop(pieceData, index, letter, context, true, isMock)|| checkforRook(pieceData, index, letter, context, true, isMock)){
    return true;
  }}
  return false;
}

bool checkforPawn(ChessPieceData pieceData , int index, int letter, BuildContext context, bool isMock){
  if(pieceData.name =="pW"){
           // Check if where is going to land there is not a piece from the same color
      if(context.read<DataArray>().getPiece(index, letter, isMock)[2] == pieceData.color ){
      return false;
    }
    // If there is a  Piece in the Left of the pawn Takes
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 1), clampBorder(pieceData.letter - 1), isMock)[1] != "N"
    && pieceData.index - 1 == index && pieceData.letter - 1 == letter){
      return true;
    }

    // If there is a  Piece in the Right of the pawn Takes
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 1), clampBorder(pieceData.letter + 1), isMock)[1] != "N"
    && pieceData.index - 1 == index && pieceData.letter + 1 == letter){
      return true;
    }
    
    // If the pawn didn't move yet he can move two spaces
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 2), pieceData.letter, isMock)[1] == "N"
    && pieceData.index - 2 == index && pieceData.letter == letter && pieceData.index == 6){
      return true;
    }
        // If there is a Pieces  in front cancel the move.
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index -1) , pieceData.letter, isMock)[1] != "N"){
      return false;
    }

     // Check if there is no Pieces ahead so the pawn can move forward
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index - 1) , pieceData.letter, isMock )[1] == "N"
    && pieceData.index - 1 == index && pieceData.letter == letter){
      return true;
    }
  }
  if(pieceData.name == "pB"){
       // Check if where is going to land there is not a piece from the same color
      if(context.read<DataArray>().getPiece(index, letter, isMock)[2] == pieceData.color ){
      return false;
    }
    // If there is a  Piece in the Left of the pawn Takes
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index + 1), clampBorder(pieceData.letter - 1), isMock)[1] != "N"
    && pieceData.index + 1 == index && pieceData.letter - 1 == letter){
      return true;
    }

    // If there is a  Piece in the Right of the pawn Takes
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index + 1), clampBorder(pieceData.letter + 1), isMock)[1] != "N"
    && pieceData.index + 1 == index && pieceData.letter + 1 == letter){
      return true;
    }
    
     //If the pawn didn't move yet he can move two spaces
    if(Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(pieceData.index + 2), pieceData.letter, isMock)[1] == "N"
    && pieceData.index + 2 == index && pieceData.letter == letter && pieceData.index == 1){
      return true;
    }
        // If there is a Pieces  in front cancel the move.
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index +1) , pieceData.letter, isMock)[1] != "N"){
      return false;
    }

     // Check if there is no Pieces ahead so the pawn can move forward
    if(context.read<DataArray>().getPiece(clampBorder(pieceData.index + 1) , pieceData.letter, isMock )[1] == "N"
    && pieceData.index + 1 == index && pieceData.letter == letter){
      return true;
    }
  }
  return false;
}

bool checkforKnight(ChessPieceData pieceData , int index, int letter, BuildContext context, isMock){
  if(pieceData.name == "kW" || pieceData.name == "kB"){
    if(context.read<DataArray>().getPiece(index,letter, isMock)[2] == pieceData.color){
      return false;
    }
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
  return false;
  }



// Execute all pieces checks in one Function 
bool checkPieces(var pieceData , int index, int letter, BuildContext context, bool isMock) {
  if ( pieceData.index == index && pieceData.letter == letter) {
      return false;
    }
  if(checkforRook(pieceData, index, letter, context,false, isMock)){
    return true;
  } 
  if(checkforBishop(pieceData, index, letter, context, false, isMock)){
    return true;
  }
  if(checkforQueen(pieceData, index, letter, context, isMock)){
    return true;
  }
  if(checkforPawn(pieceData, index, letter, context, isMock)){
    return true;
  }
  if(checkforKnight(pieceData, index, letter, context, isMock) ){
    return true;
  }
  if(checkforKing(pieceData, index, letter, context,isMock)){

    return true;
  }
  return false;
}

//Todo: make Pawn Promotion functionality.
bool checkforPromotion(BuildContext context){
  var firstRow = context.read<DataArray>().getData()[0];
  var lastRow = context.read<DataArray>().getData()[7];
  for(int i = 0; i < 8; i++){
    if(firstRow[i][1] == "pW"){
      return true;
    }
    if(lastRow[i][1] == "pB"){
      return true;
    }
  }
  return false;

}
void promote(BuildContext context){
  // Check if there is a White Pawn in the end of the data array.
  // If so determined in what letter index did the pawn exist.
  // To Initialize a floatingPromotionMenu in the right position
  // of the pawn. 
  // This function will be check each time  a pawn move or a piece  move
  // Then obtain the value of the selected piece and change it in the data
  // Array.\
  var firstRow = context.read<DataArray>().getData()[0];
  var lastRow = context.read<DataArray>().getData()[7];
  List<int> position = [];
  for(int i =0; i < 8; i++){
    if(firstRow[i][1] == "pW"){
      position = [0, i];
      Provider.of<GameController>(context, listen: false).changeWhiteMove();
      Provider.of<WidgetOnScreen>(context, listen: false).setFloatingPromotionMenu(
              position: position,   
              whitePromotion: true,
              context:context);
      
    }
    if(lastRow[i][1] == "pB"){
      position =  [7, i];
      Provider.of<GameController>(context, listen: false).changeBlackMove();
      Provider.of<WidgetOnScreen>(context, listen: false).setFloatingPromotionMenu(
              position: position, 
              whitePromotion: false,
              context:context);
    }

  }


}



List allPossibleMoves(ChessPieceData piece, BuildContext context, bool isMock){
  List<List> possibleMoves = [];
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      if(checkPieces(piece, i, j, context, isMock)){
        possibleMoves.add([i,j]);
      }
    }}

  return possibleMoves;
}
/// Intersection Test: for checks to the king.
bool inCheck(ChessPieceData piece, BuildContext context, isMock){
  List<Vector2> possibleMoves = allPossibleMoves(piece, context, isMock).map((e) => Vector2( e[0].toDouble(), e[1].toDouble() )).toList();
 // print(possibleMoves);
  // We interchange the color Value because we want to identify
  // if the King of the opposite color is in the possible moves of the piece.
  if (piece.color == "white"){
  List<int> kingPosition = Provider.of<GameController>(context, listen: false).getKingPosition("black",isMock);
 // print("king position: $kingPosition");
  Vector2 kingPositionVector = Vector2(kingPosition[0].toDouble(),kingPosition[1].toDouble());
  if(possibleMoves.contains(kingPositionVector)){
    return true;}
  }
  if (piece.color == "black"){
  List<int> kingPosition = Provider.of<GameController>(context, listen: false).getKingPosition("white",isMock);
  Vector2 kingPositionVector = Vector2(kingPosition[0].toDouble(), kingPosition[1].toDouble());
   if(possibleMoves.contains(kingPositionVector)     ){
    print("fwifeb");
    return true;}
  }

  return false;
}

void checkPosibleCheck(String color, BuildContext context, bool isMock){
  //Look for the king of the current player.
  // from the kings position look for his diagonal and horizontal moves.
  // If there is a bishop, rook or queen in the way, add them to the list of possible checks.
  List<int> king = isMock? Provider.of<GameController>(context, listen:false).getKingPosition(color, isMock):
                           Provider.of<GameController>(context,listen:false).getKingPosition(color, false);
  print("Check the king pos: $king , Mock :$isMock");
  // Linear Searchs thought his diagonals and horizontals
  

  if(color =="white"){
  for(int i = 1; i < 8; i++){
    // Checks the  Down of the king. Checking for Black Rooks and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1], isMock )[1] == "rB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1] , isMock)[1] == "qB")&&
       king[0] + i < 8  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1], isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: (king[0] + i), letter: king[1]);
      // Push Piece to the possiblesCheck list.
      print("OK this is to check if there is something Worng WEEEPIII Down ");
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
  
    // Checks the  UP of the king. Checking for Black Rooks and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1], isMock )[1] == "rB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1], isMock )[1] == "qB")&&
       king[0] - i > 0  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1], isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: (king[0] - 1), letter: king[1]);
      // Push Piece to the possiblesCheck list.
      print("OK this is to check if there is something Worng WEEEPIII UP ");
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
    // Checks the  Right of the king. Checking for Black Rooks and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1],isMock )[1] == "rB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1], isMock )[1] == "qB")&&
       king[1] + i < 8  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] + i), isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: (king[0] + 1), letter: king[1]);
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
    // Checks the  Left of the king. Checking for Black Rooks and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(king[0] ,clampBorder(king[1] - i),isMock )[1] == "rB"||
       Provider.of<DataArray>(context, listen: false).getPiece(king[0] ,clampBorder(king[1] - i), isMock )[1] == "qB")&&
       king[1] - i > 0  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] - i), isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: king[0], letter: (king[1] - 1));
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
    //Checks the UP Right Diagonal of the king. Checking for Black Bishop and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] + i), isMock )[1] == "bB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] + i), isMock )[1] == "qB")&&
      ( king[0] + i < 8 || king[1] + i < 8 ) ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] + i), isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: king[0]+i, letter: king[1]+i);
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }

    //Checks the UP Left Diagonal of the king. Checking for Black Bishop and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i), isMock )[1] == "bB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i),isMock )[1] == "qB")&&
       (king[0] + i < 8 || king[1] - i > 0)  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i),isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: king[0]+i, letter: king[1]-i);
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
    //Checks the DOWN Right Diagonal of the king. Checking for Black Bishop and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock )[1] == "bB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock )[1] == "qB")&&
       (king[0] - i > 0 || king[1] + i < 8)  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: king[0]-i, letter: king[1]+i);
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }
    //Checks the DOWN Left Diagonal of the king. Checking for Black Bishop and Queens.
    if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock )[1] == "bB"||
       Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock )[1] == "qB")&&
       (king[0] - i > 0 || king[1] - i > 0)  ){
      List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock );
      ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                  color: possiblePiece[2], index: king[0]- i, letter: king[1] - i);
      // Push Piece to the possiblesCheck list.
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
    }


  }
  }
  if(color == "black"){
    for (int i = 1; i < 8; i++){
      // Checks the Down of the king. Checking for White Rooks and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1],isMock )[1] == "rW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1],isMock )[1] == "qW")&&
         king[0] + i < 8  ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),king[1],isMock );
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: clampBorder(king[0] + i), letter: king[1]);
        // Push Piece to the possiblesCheck list.
        print("What are you doing!!!?? ${king[0] + i}, ${king[1]}");
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      // Checks the UP of the king. Checking for White Rooks and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1],isMock )[1] == "rW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1],isMock )[1] == "qW")&&
         king[0] - i > 0  ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),king[1],isMock );
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: king[0]-i, letter: king[1]);
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      // Checks the Right of the king. Checking for White Rooks and Queens
      if((Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] + i),isMock)[1] == "rW"||
         Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] + i),isMock)[1] == "qW")&&
         king[1] + i < 8  ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] + i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: king[0], letter: (king[1] + i));
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      // Checks the Left of the king. Checking for White Rooks and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] - i),isMock)[1] == "rW"||
         Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] - i),isMock)[1] == "qW")&&
         king[1] - i > 0  ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(king[0],clampBorder(king[1] - i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: king[0], letter: king[1]-i);
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      //Checks the UP Right Diagonal of the king. Checking for White Bishop and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock)[1] == "bW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock)[1] == "qW")&&
        ( king[0] - i > 0 || king[1] + i < 8 ) ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] + i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: (king[0] - i), letter: (king[1] + i));
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      //Checks the UP Left Diagonal of the king. Checking for White Bishop and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock)[1] == "bW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock)[1] == "qW")&&
         (king[0] - i > 0 && king[1] - i > 0)  ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] - i),clampBorder(king[1] - i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: (king[0] - i), letter: (king[1] - i));
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      //Checks the DOWN Right Diagonal of the king. Checking for White Bishop and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] + i),isMock)[1] == "bW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i), clampBorder(king[1] + i),isMock)[1] == "qW")&&
        ( king[0] + i < 8 && king[1] + i < 8 ) ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i), clampBorder(king[1] + i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: clampBorder(king[0]+i), letter: clampBorder(king[1] + i));
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }
      //Checks the DOWN Left Diagonal of the king. Checking for White Bishop and Queens.
      if((Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i),isMock)[1] == "bW"||
         Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i),isMock)[1] == "qW")&&
        ( king[0] + i < 8 && king[1] - i > 0 ) ){
        List possiblePiece = Provider.of<DataArray>(context, listen: false).getPiece(clampBorder(king[0] + i),clampBorder(king[1] - i),isMock);
        ChessPieceData piece = ChessPieceData(image:possiblePiece[0],name: possiblePiece[1],
                                    color: possiblePiece[2], index: king[0]+i, letter: king[1]-i);
        // Push Piece to the possiblesCheck list.
        Provider.of<GameController>(context, listen: false).pushPossibleCheck(piece);
      }






    }
  }

  }


// We change it to bool because we dont want to change the  BlackcheckValue yet.
bool checkForWhiteChecks(BuildContext context, bool value, bool isMock){
  List possibleChecks = Provider.of<GameController>(context, listen: false).possibleWhiteChecks;
  for(int i = 0; i < possibleChecks.length; i++){
     if(inCheck(possibleChecks[i], context,isMock)){
       return true;//Provider.of<GameController>(context, listen: false).changeWhiteCheck(value);
       }
  }
  return false;

}
bool checkForBlackChecks(BuildContext context , bool value, bool isMock){
  List possibleChecks = Provider.of<GameController>(context, listen: false).possibleBlackChecks;
  for(int i = 0; i < possibleChecks.length; i++){
    if(inCheck(possibleChecks[i], context,isMock)){
      print("ISSS in CHECK");
      return true;//Provider.of<GameController>(context, listen: false).changeBlackCheck(value);
      }
      print("IS Not in CHECk");
  }
  return false;

}
// Must be bool because  if in this play the king is not in check.
//The player can move.
bool stillInCheck(var piece, BuildContext context,bool isMock){


   if(piece.color == "white"){
    checkPosibleCheck(piece.color, context,isMock);
    return checkForWhiteChecks(context, false,isMock);
  }
  if(piece.color == "black"){
    checkPosibleCheck(piece.color, context,isMock);
    return checkForBlackChecks(context, false,isMock);
  }
  

    
  
  return false;
}