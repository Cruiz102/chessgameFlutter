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
    final chessCellData = Provider.of<DataArray>(context).getPiece(index, letter);
    final DragTarget piece;

    if(turn){
      if (chessCellData[2] == "white"){
        piece =  DragTarget<ChessPieceData>(
    builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
      data: ChessPieceData( image:chessCellData[0], index: index, letter: letter, name: chessCellData[1], color: chessCellData[2]),
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
    return checkPieces(data, index, letter, context);
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  );
    }
  else{
    piece =  DragTarget<ChessPieceData>(
    builder: (BuildContext context,
     List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(
      maxSimultaneousDrags: 0,
      data: ChessPieceData( image:chessCellData[0], index: index, letter: letter, name: chessCellData[1], color: chessCellData[2]),
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
    return checkPieces(data, index, letter, context);
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  );
    
  }

    }




    return 
    DragTarget<ChessPieceData>(
    builder: (BuildContext context
    , List<dynamic> candidateData, List<dynamic> rejectedData) {
      return
       Draggable<ChessPieceData>(

      data: ChessPieceData( image:chessCellData[0], index: index, letter: letter, name: chessCellData[1], color: chessCellData[2]),
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
    return checkPieces(data, index, letter, context);
  },
  onAccept: (data) {
    Provider.of<DataArray>(context, listen: false).setPiece(index, letter, [data.image, data.name, data.color]);
  },
  
  );
    
  }
}