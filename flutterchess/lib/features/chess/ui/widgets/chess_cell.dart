import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterchess/features/chess/data/data_array_provider.dart';
import 'color_draggable.dart';

class ChessCell extends StatelessWidget {
   // ignore: use_key_in_widget_constructors
   const ChessCell(this.index, this.letter);
  final int index;
  final int letter;

  @override
  Widget build(BuildContext context) {
    //isMock in here is false
    var chessCellData = Provider.of<DataArray>(context, listen:false).getPiece(index, letter,false);
    var draggable = ColorDraggable(chessCellData : chessCellData,index : index, letter: letter);
    return draggable;
    
  }
}