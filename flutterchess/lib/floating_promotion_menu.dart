import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:provider/provider.dart';
import 'data.dart';

/// This is the Floating Promotion menu when a pawn promotes.
/// This take a boolean whitePromotions
class FloatingPromotionMenu extends StatelessWidget {
  final List<int> position;
  final bool whitePromotion;
  const FloatingPromotionMenu({Key? key, required this.whitePromotion, required this.position}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  List<dynamic> value ;
  Function deleteFloatingPromotion = context.watch<WidgetOnScreen>().deleteLast;
  final List  whitePieceCollection = [kW,bW, rW, qW];
  final List blackPieceCollection = [kB,bB,rB,qB];
  List<Widget> whiteFloatingButtons = List<Widget>.generate(4, (index) =>
  InkWell(child:SizedBox(
    height:50,
    width:50,
    child:  whitePieceCollection[index][0],),
    onTap: () =>  {value = whitePieceCollection[index],
                    deleteFloatingPromotion(),
                    Provider.of<GameController>(context, listen:false).changeWhiteMove(),
                    Provider.of<GameController>(context, listen:false).changeTurns(),
                    Provider.of<DataArray>(context, listen:false).setPiece(position[0], position[1],value )
                    }
  ));
    List<Widget> blackFloatingButtons = List<Widget>.generate(4, (index) =>
  InkWell(child:SizedBox(
    height:50,
    width:50,
    child:  blackPieceCollection[index][0],),
    onTap: () =>  {value = blackPieceCollection[index],
                    // Delete the Floating Promotion menu
                    deleteFloatingPromotion(),
                    Provider.of<GameController>(context, listen:false).changeBlackMove(),
                    Provider.of<GameController>(context, listen:false).changeTurns(),

                    Provider.of<DataArray>(context, listen:false).setPiece(position[0], position[1],value )
                   
    }
  ));


    return 
    Container(
      margin: const EdgeInsets.only(top:60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 82, 215, 142),
        boxShadow:const [ BoxShadow(
          color: Color.fromARGB(131, 0, 0, 0),
          blurRadius: 10,
          offset: Offset(0, 10),
        )],
      ),
      child: Column( children: whitePromotion? whiteFloatingButtons: blackFloatingButtons,

    ));
    
  }
}