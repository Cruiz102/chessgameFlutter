

import 'package:flutter/material.dart';
import 'chess_piece_data.dart';
import 'constant.dart';
import 'package:provider/provider.dart';
import'data.dart';
import 'game_logic.dart';

/// This class is maded so we can change the parameter maxSimultaneousDrags
/// on the DragTarget inside the [ChessCell]. To build the DragTarget widget
/// that correnspond with the turn and his pieceData color.

class ColorDraggable extends StatefulWidget {
   final  List chessCellData  ;
   final int index;
   final int letter;
   const ColorDraggable({Key? key,  required  this.chessCellData, required  this.index, required this.letter}) : super(key: key);

  @override
  State<ColorDraggable> createState() => _ColorDraggableState();
}

class _ColorDraggableState extends State<ColorDraggable> {
  @override
  Widget build(BuildContext context) {
    
   late DragTarget piece ;
      if (widget.chessCellData[2] == "white"){
      piece =  DragTarget<ChessPieceData>(
      builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
        maxSimultaneousDrags: Provider.of<GameController>(context).whiteMove,
      data: ChessPieceData( image:widget.chessCellData[0], index: widget.index, letter: widget.letter, name: widget.chessCellData[1], color: widget.chessCellData[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      onDraggableCanceled: (details, q) {
    
        
      },
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position)
       {return const Offset(25,25);}
,
      feedback: Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0]
        ,

      child:  Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0],
      );
  },
  onWillAccept: (data) {
    return checkPieces(data, widget.index, widget.letter, context);
  },
  onAccept: (data) {
    //Set Piece to the new position
    Provider.of<DataArray>(context, listen: false).setPiece(widget.index, widget.letter, [data.image, data.name, data.color]);
    // Set Previous Position to Null State.
    Provider.of<DataArray>(context, listen: false).setPiece(data.index, data.letter, N);

    //Promote Pawns
    if(checkforPromotion(context)){
    promote(context);
    }
    // Change Turns
    else{
    Provider.of<GameController>(context, listen: false).changeTurns();
    }
    // Set Check if the opposite king is in check
    var newPiece = ChessPieceData(index:widget.index,letter: widget.letter, image:data.image,name: data.name, color:data.color);
      if(inCheck(newPiece, context)){
      print("Black Check");
      Provider.of<GameController>(context, listen: false).changeWhiteCheck(true);
    }
    // This conditioner update the position of the king if the moves. This is important to check if the king is in check.
    if(data.name == "kingW"){
      Provider.of<GameController>(context, listen: false).updateKingPosition("white", widget.index, widget.letter);
    }
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
      data: ChessPieceData( image:widget.chessCellData[0], index: widget.index, letter: widget.letter, name: widget.chessCellData[1], color: widget.chessCellData[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position)
       {return const Offset(28,28);},
      feedback: Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0],
      child: Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0],
      );
  },
  onWillAccept: (data) {
    return checkPieces(data, widget.index, widget.letter, context);
  },
  onAccept: (data) {
    //Set Piece to the new position
    Provider.of<DataArray>(context, listen: false).setPiece(widget.index, widget.letter, [data.image, data.name, data.color]);
    // Set Previous Position to Null State.
    Provider.of<DataArray>(context, listen: false).setPiece(data.index, data.letter, N);

    if(checkforPromotion(context)){
    promote(context);
    }
    else{
    Provider.of<GameController>(context, listen: false).changeTurns();
    }
    // Set Check if the opposite king is in check
    var newPiece = ChessPieceData(index:widget.index,letter: widget.letter, image:data.image,name: data.name, color:data.color);
      if(inCheck(newPiece, context)){
      print("White Check");
      Provider.of<GameController>(context, listen: false).changeWhiteCheck(true);
    }
    // Update kings Black position
    if(data.name == "kingB"){
    Provider.of<GameController>(context, listen: false).updateKingPosition("black", widget.index, widget.letter);
    }


  },
  );
  }

  
    return piece;

    
}
}
  
