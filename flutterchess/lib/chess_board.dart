import 'package:flutter/material.dart';
import 'chess_cell.dart';


// ignore: use_key_in_widget_constructors
class ChessBoard extends StatelessWidget {
  final List <Widget>  chessRows = List<Widget>.generate( 8, (index) => ChessRows(index));

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: chessRows
      );
  }
}


class ChessRows extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChessRows(this.index);
  final int index;

  bool xor(bool a, bool b){
    if (a != b){
      return false;
    } 
    else{
      return true;
    }}
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (letter) => Container(
        color: xor(letter % 2 == 0 , index % 2 == 0 ) ?  const Color.fromARGB(255, 118, 150, 86) :const Color.fromARGB(255, 238, 238, 210),
        width: 50,
        height: 50,
        child: ChessCell(index, letter),
      )));
  }
}