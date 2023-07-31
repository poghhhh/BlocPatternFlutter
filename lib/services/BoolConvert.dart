bool intToBool(int value) {
  return value == 1 ? true : false;
}

int boolToInt(bool value) {
  if (value == false) {
    return 0;
  } else {
    return 1;
  }
}
