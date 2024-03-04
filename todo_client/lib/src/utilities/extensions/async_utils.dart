extension AsyncUtils on int {
  Future get delay => Future.delayed(Duration(seconds: this));
}
