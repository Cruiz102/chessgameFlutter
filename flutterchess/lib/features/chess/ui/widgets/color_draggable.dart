

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
    int colorMove = 0;
    if(widget.chessCellData[2] == "white"){
      colorMove = Provider.of<GameController>(context).whiteMove;
    }
    else if(widget.chessCellData[2] =="black"){
      colorMove = Provider.of<GameController>(context).blackMove;
    }
    else if(widget.chessCellData[2] =="none"){
      colorMove = 0;
    }
   late DragTarget piece ;
 
     piece =  DragTarget<ChessPieceData>(
    builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
      maxSimultaneousDrags: colorMove,
      data: ChessPieceData( image:widget.chessCellData[0], index: widget.index, letter: widget.letter, name: widget.chessCellData[1], color: widget.chessCellData[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position)
       {return const Offset(25,25);},
      feedback:widget.chessCellData[0], //Provider.of<DataArray>(context,listen:false).getPiece(widget.index, widget.letter,false)[0],
       child: widget.chessCellData[0]);//Provider.of<DataArray>(context,listen:false).getPiece(widget.index, widget.letter,false)[0],);
},



onWillAccept: (data) {
  //clear Possibnles


  Provider.of<GameController>(context, listen: false).clearPossibleCheck();
  //TODO: The MockDataArray work and now you cant move if you are in check. There a bug
  // when moving the king because when moving it it does not detect that is in check.
  
  //TODO: Need to Implement Testing.

  //TODO: There an error related to Promotion.
  
  // Reason of the Bug: We recall the Two todos behing this comment. The problem is that is adding pieces to the
  // MockDataarray but its not deleting thems after trying and testing the move.
  Provider.of<DataArray>(context, listen:false).setMockPiece(widget.index, widget.letter, [data!.image,data.name,data.color]);
  Provider.of<DataArray>(context,listen: false).setMockPiece(data.index, data.letter, N);
      if(data.name == "kingB" || data.name == "kingW"){
    Provider.of<GameController>(context, listen: false).updateKingPosition(data.color, widget.index, widget.letter,true);
    }
  var still = !stillInCheck(data, context,true);
    bool canMove = checkPieces(data, widget.index, widget.letter, context,false) 
                  && still;
   // print("canMove second try: ${ checkPieces(data, widget.index, widget.letter, context,false) }, ${!stillInCheck(data, context,true)}");
   // print("canMove pieces: ${ checkPieces(data, widget.index, widget.letter, context,false) }, ${!stillInCheck(data, context,true)}");
    print("${Provider.of<GameController>(context, listen: false).possibleBlackChecks.map((e) => [e.index, e.letter, e.color, e.name]).toList()}");
    print("${Provider.of<GameController>(context, listen: false).possibleWhiteChecks.map((e) => [e.index, e.letter, e.color, e.name]).toList()}");

    // Redo the MockDataArray after trying the move.
    Provider.of<DataArray>(context, listen:false).setMockPiece(data.index, data.letter, [data.image, data.name,data.color]);
    Provider.of<DataArray>(context, listen:false).setMockPiece(widget.index, widget.letter, N);
    if(data.name == "kingB" || data.name == "kingW"){
    Provider.of<GameController>(context, listen: false).updateKingPosition(data.color, data.index, data.letter,true);
    }

    return canMove;
    },
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
    //Opposite kings Position.
    var datainfo = Provider.of<DataArray>(context, listen: false).getPiece(widget.index, widget.letter,false);
    var newPiece = ChessPieceData(image:datainfo[0], name:datainfo[1], color:datainfo[2], index:widget.index, letter: widget.letter);
      if(inCheck(newPiece, context,false) && newPiece.color == "white"){
      Provider.of<GameController>(context, listen: false).changeBlackCheck(true);
    }
    if(inCheck(newPiece, context,false) && newPiece.color == "black"){
        Provider.of<GameController>(context, listen: false).changeWhiteCheck(true);

    }
    //Update King
    if(data.name == "kingB" || data.name =="KingW"){
    Provider.of<GameController>(context, listen: false).updateKingPosition(data.color, widget.index, widget.letter,false);
    }
}
,
);
  

return  piece;
}
}
  


