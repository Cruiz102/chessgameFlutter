import 'package:flutter/material.dart';
import 'package:flutterchess/chess_piece_data.dart';
import 'package:flutterchess/game_logic.dart';
import 'package:provider/provider.dart';
import 'package:flutterchess/data_array.dart';
import 'constant.dart';

class ChessCell extends StatelessWidget {
   // ignore: use_key_in_widget_constructors
   const ChessCell(this.index, this.letter);
  final int index;
  final int letter;

  @override
  Widget build(BuildContext context) {
    final current = Provider.of<DataArray>(context).getPiece(index, letter);
    return 
    DragTarget<ChessPieceData>(
    builder: (BuildContext context
    , List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
      data: ChessPieceData( image:current[0], index: index, letter: letter, name: current[1], color: current[2]),
      childWhenDragging: Container(
        color: const Color.fromARGB(255, 245, 230, 100),
        width: 50,
        height: 50,
      ),
      onDragCompleted: () {
        Provider.of<DataArray>(context, listen: false).setPiece(index, letter, N);
      },
      feedback: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      child: Provider.of<DataArray>(context).getPiece(index, letter)[0],
      );
  },
  onWillAccept: (data) {
    if ( data!.index == index && data.letter == letter) {
      return false;
    }
    if (checkforRook( data,  index,  letter,  context, false)){
      return true;
    }
    if (checkforKing( data,  index,  letter,  context)){
      return true;
    }
    if (checkforBishop( data,  index,  letter,  context, false)){
      return true;
    }
    if(checkforQueen(data, index, letter, context)){
      return true;
    }
    if(checkforPawn(data, index, letter, context)){
      return true;
    }
    if(checkforKnight(data, index, letter, context)){
      return true;
    }

    else{
      return false;
    }
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  
  );
    
  }
}