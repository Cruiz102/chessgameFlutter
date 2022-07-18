import 'package:flutter/material.dart';
import 'constant.dart';

/// This is the Floating Promotion menu when a pawn promotes.
/// This take a boolean whitePromotions
class FloatingPromotionMenu extends StatelessWidget {
  final bool whitePromotion;
  const FloatingPromotionMenu({Key? key, required this.whitePromotion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  String value = "";
  final List  whitePieceCollection = [kW,bW, rW, qW];
  final List blackPieceCollection = [kB,bB,rB,qB];
  List<Widget> whiteFloatingButtons = List<Widget>.generate(4, (index) =>
  InkWell(child:SizedBox(
    height:50,
    width:50,
    child:  whitePieceCollection[index][1],),
    onTap: () =>  value = whitePieceCollection[index][1]
  ));
    List<Widget> blackFloatingButtons = List<Widget>.generate(4, (index) =>
  InkWell(child:SizedBox(
    height:50,
    width:50,
    child:  blackPieceCollection[index][1],),
    onTap: () =>  {value = blackPieceCollection[index][1]
                    deleteFloatingButtons();
    }
  ));
  
  





    return 
    Column( children: whitePromotion? whiteFloatingButtons: blackFloatingButtons,

    );
    
  }
}