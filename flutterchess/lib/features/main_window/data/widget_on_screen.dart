import 'package:flutter/material.dart';
import 'package:flutterchess/features/chess/ui/screens/chess_board.dart';
import '/features/chess/ui/widgets/floating_promotion_menu.dart';



class WidgetOnScreen extends ChangeNotifier{
  // ignore: prefer_final_fields
  List<Widget> _onScreen = [ChessBoard()];
  List<Widget> get onScreen => _onScreen;
  void addWidget(Widget widget){
    _onScreen.add(widget);
    notifyListeners();
  }

  void setFloatingPromotionMenu({ required List<int> position, required bool whitePromotion,required BuildContext context}) {
    _onScreen.add(Positioned(
      top: (position[0].toDouble()+1) ,
      left:  (MediaQuery.of(context).size.width/ 2) + (position[1].toDouble() * 50) - 200,
      child: FloatingPromotionMenu(whitePromotion: whitePromotion, position: position),
    ));
    print(_onScreen);
    notifyListeners();

  }
  void deleteLast(){
    _onScreen.removeAt(1);
    notifyListeners();
  }
}
