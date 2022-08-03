

import 'package:flutter/material.dart';
import 'package:flutterchess/features/chess/repository/chess_piece_data.dart';
import 'package:flutterchess/features/chess/data/constant.dart';
import 'package:provider/provider.dart';
import 'package:flutterchess/features/chess/data/game_controller_provider.dart';
import '../../data/data_array_provider.dart';
import 'package:flutterchess/features/chess/logic/game_logic.dart';

/// This class is maded so we can change the parameter maxSimultaneousDrags
/// on the DragTarget inside the [ChessCell]. To build the DragTarget widget
/// that correnspond with the turn and his pieceData color. This widget is constructed
/// with three diferents options depending on the  chessCellData parameter values given in the
/// the Chess Row widget. This options are for the three possible values on the
/// chessCellData[2] parameter: "white", "black and none" .
/// 
//TODO: Implement InheretedWidget to ColorDraggable. we must implement this to make code cleaner when
// when passing  the parameter ChessCellData to childrens. Especially to the PieceFloatingMenu. This is necessary
// because we need to pass the ChessCellData to the PieceFloatingMenu for calling in check when a Pawn Promotes and check
// if is making check to the king.
/*
class ColorDraggable extends S{
  final  List chessCellData  ;
   final int index;
   final int letter;
   // ignore: use_key_in_widget_constructors
   const ColorDraggable({required this.chessCellData, required this.index, required this.letter, required Widget child}) : super(child: child);
    @override
    bool updateShouldNotify(ColorDraggable oldWidget) {
      return oldWidget.chessCellData != chessCellData;
    }
    static ColorDraggable of(BuildContext context) {
      return context.dependOnInheritedWidgetOfExactType<ColorDraggable>();
    }
}
*/

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

      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position)
       {return const Offset(25,25);}
,
      feedback: Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0]
        ,

      child:  Provider.of<DataArray>(context).getPiece(widget.index, widget.letter)[0],
      );
  },
  onWillAccept: (data) {
    //clear the possible checks each time a piece is dragged
    Provider.of<GameController>(context, listen: false).clearPossibleCheck();
    stillInCheck(data,context);
    bool canMove = checkPieces(data, widget.index, widget.letter, context) 
                  && !Provider.of<GameController>(context, listen:false).inWhiteCheck;
    print(canMove);
    return canMove;
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
        print(widget.chessCellData[2]);
      Provider.of<GameController>(context, listen: false).changeBlackCheck(true);
      print("Black Check ${Provider.of<GameController>(context, listen: false).inBlackCheck}");
    }
    // This conditioner update the position of the king if the moves. This is important to check if the king is in check.
    if(data.name == "kingW"){
    Provider.of<GameController>(context, listen: false).updateKingPosition("white", widget.index, widget.letter);
    }
  },
  );
  }
  // Drag Target for Blacks Pieces
  if(widget.chessCellData[2] == "black"){
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
    //TODO: add still in check in this part too.
   // stillInCheck(data,context);
   // bool canMove = checkPieces(data, widget.index, widget.letter, context) && Provider.of<GameController>(context, listen: false).inBlackCheck;
    return checkPieces(data, widget.index, widget.letter, context) ; 
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
    var datainfo = Provider.of<DataArray>(context, listen: false).getPiece(widget.index, widget.letter);
    var newPiece = ChessPieceData(image:datainfo[0], name:datainfo[1], color:datainfo[2], index:widget.index, letter: widget.letter);
      if(inCheck(newPiece, context)){
      Provider.of<GameController>(context, listen: false).changeWhiteCheck(true);
      print("White ${Provider.of<GameController>(context, listen: false).inWhiteCheck}");
    }
    // Update kings Black position
    if(data.name == "kingB"){
    Provider.of<GameController>(context, listen: false).updateKingPosition("black", widget.index, widget.letter);
    }


  },
  );
  }
  if(widget.chessCellData[2] == "none"){
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
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position)
       {return const Offset(25,25);},
      feedback: widget.chessCellData[0],
       child: widget.chessCellData[0],);
},
//TODO: Something is wrong in the stillIn Check function. It does not return the correct possiblesCheck


onWillAccept: (data) {
  //clear Possibnles
  Provider.of<GameController>(context, listen: false).clearPossibleCheck();
    stillInCheck(data,context);
    print("black ${Provider.of<GameController>(context, listen: false).inBlackCheck}");
    print("${Provider.of<GameController>(context, listen: false).possibleWhiteChecks.map((e) => [e.index, e.letter, e.color, e.name]).toList()}");
    bool canMove = checkPieces(data, widget.index, widget.letter, context) 
                  && !Provider.of<GameController>(context, listen:false).inBlackCheck;
    print(canMove);
    return canMove;},
onAccept: (data){
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
    var datainfo = Provider.of<DataArray>(context, listen: false).getPiece(widget.index, widget.letter);
    var newPiece = ChessPieceData(image:datainfo[0], name:datainfo[1], color:datainfo[2], index:widget.index, letter: widget.letter);
      if(inCheck(newPiece, context) && newPiece.color == "white"){
      Provider.of<GameController>(context, listen: false).changeBlackCheck(true);
      print("black ${Provider.of<GameController>(context, listen: false).inBlackCheck}");
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(newPiece);
    }
    if(inCheck(newPiece, context) && newPiece.color == "black"){
        Provider.of<GameController>(context, listen: false).changeWhiteCheck(true);
      print("white ${Provider.of<GameController>(context, listen: false).inWhiteCheck}");
      Provider.of<GameController>(context, listen: false).pushPossibleCheck(newPiece);

    }
    //Update King B
    if(data.name == "kingB"){
    Provider.of<GameController>(context, listen: false).updateKingPosition("black", widget.index, widget.letter);
    }
    //Update King W
    if(data.name == "kingW"){
    Provider.of<GameController>(context, listen: false).updateKingPosition("white", widget.index, widget.letter);
    }
}
,
);
  
}
return  piece;
}
}
  
