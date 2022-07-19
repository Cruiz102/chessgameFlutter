

import 'package:flutter/material.dart';
import 'chess_piece_data.dart';
import 'constant.dart';
import 'package:provider/provider.dart';
import'data.dart';
import 'game_logic.dart';
/// This class is maded so we can change the parameter maxSimultaneousDrags
/// on the DragTarget inside the [ChessCell]. To build the DragTarget widget
/// that correnspond with the turn and his pieceData color.

class ColorDraggable extends StatelessWidget {
    final  List chessCellData  ;
   final int index;
   final int letter;
   const ColorDraggable({Key? key,  required  this.chessCellData, required  this.index, required this.letter}) : super(key: key);
  
  
//TODO: Remove the turn variable and substitute it with the Gamecontroller  Variables.

  @override
  Widget build(BuildContext context) {
   late DragTarget piece ;
      if (chessCellData[2] == "white"){
        piece =  DragTarget<ChessPieceData>(
    builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
        maxSimultaneousDrags: Provider.of<GameController>(context).whiteMove,
      data: ChessPieceData( image:chessCellData[0], index: index, letter: letter, name: chessCellData[1], color: chessCellData[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      onDragCompleted: () {
        Provider.of<DataArray>(context, listen: false).setPiece(index, letter, N);
        // Set Turn opposite so the  other player can move his pieces
          if(checkforPromotion(context)){
            print("ok babe");
          promote(context);
        }
        else{
          Provider.of<GameController>(context, listen: false).changeTurns();
        }
      },
      feedback: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      child: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      );
  },
  onWillAccept: (data) {
    return checkPieces(data, index, letter, context);
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  );
  }
  // Drag Target for Blacks Pieces
  else{
    piece =  DragTarget<ChessPieceData>(
    builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
      maxSimultaneousDrags: Provider.of<GameController>(context).blackMove,
      data: ChessPieceData( image:chessCellData[0], index: index, letter: letter, name: chessCellData[1], color: chessCellData[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      onDragCompleted: () {
        Provider.of<DataArray>(context, listen: false).setPiece(index, letter, N);
        // Set Turn opposite so the  other player can move his pieces
        if(checkforPromotion(context)){
          promote(context);

        }
        else{
          Provider.of<GameController>(context, listen: false).changeTurns();
        }
      },
      feedback: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      child: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      );
  },
  onWillAccept: (data) {
    return checkPieces(data, index, letter, context);
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  );
  }

  
    return piece;
}
}
  
