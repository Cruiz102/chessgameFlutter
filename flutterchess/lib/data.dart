import 'package:flutter/material.dart';
import 'package:flutterchess/chess_board.dart';
import 'constant.dart';
import 'floating_promotion_menu.dart';



class DataArray extends ChangeNotifier {
  List<dynamic> _data = [
    [rB,kB,bB,qB,kingB,bB,kB,rB],
    [pB,pB,pB,pB,pB,pB,pB,pB],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,pW,pW,pW,pW,pW,pW,pW],
    [rW,kW,bW,qW,kingW,bW,kW,rW],
  ];
   
  List get data => _data;

  List getData(){
    return _data;
  }
  void setData() {
    final List<List<List>> starting = [
    [rB,kB,bB,qB,kingB,bB,kB,rB],
    [pB,pB,pB,pB,pB,pB,pB,pB],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [pW,pW,pW,pW,pW,pW,pW,pW],
    [rW,kW,bW,qW,kingW,bW,kW,rW],
  ];
    _data = starting;
    notifyListeners();
  }
  List getPiece(int index, int letter) {

    return _data[index][letter];
  }
  void setPiece(int index, int letter, dynamic value) {
    _data[index][letter] = value;
    notifyListeners();
  }
}

class WidgetOnScreen extends ChangeNotifier{
  // ignore: prefer_final_fields
  List<Widget> _onScreen = [ChessBoard()];
  List<Widget> onScreen(){
    return _onScreen;
  }
  void addWidget(Widget widget){
    _onScreen.add(widget);
    notifyListeners();
  }

  void setFloatingPromotionMenu({ required List<int> position, required bool whitePromotion}) {
    _onScreen.add(Positioned(
      top: (position[0].toDouble()+1) * 50,
      left: (position[1].toDouble()+ 1) * 50,
      child: FloatingPromotionMenu(whitePromotion: whitePromotion, position: position),
    ));
    notifyListeners();

  }
  void deleteLast(){
    _onScreen.removeAt(1);
    notifyListeners();
  }
}

class GameController extends ChangeNotifier{
  // _blackMove and _whiteMoves are gloabl variables.
  // with the purpose of controlling if the player can move or not.
  // These Variables were create to solve the problem when doing the promotion,
  // the player can't move any piece while the promotion menu is open.
   int _blackMove = 0;
   int _whiteMove = 1;

  int get blackMove => _blackMove;
  int get whiteMove => _whiteMove;

  void changeBlackMove(){
    _blackMove = _blackMove == 1 ? 0 : 1;
    notifyListeners();
  }
  void changeWhiteMove(){
    _whiteMove = _whiteMove == 1 ? 0 : 1;
    notifyListeners();
  }
  void changeTurns(){
    _blackMove = _blackMove == 1 ? 0 : 1;
    _whiteMove = _whiteMove == 1 ? 0 : 1;
    notifyListeners();
  }
}