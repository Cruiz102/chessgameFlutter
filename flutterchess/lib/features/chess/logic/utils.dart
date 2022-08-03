/// Clamp the values so that they do not hit an overflow for the index's
/// in the board.
int clampBorder(int value){
  return value.clamp(0, 7);
}
