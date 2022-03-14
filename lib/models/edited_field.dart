class EditedField {
  int _wordIndex = -1;
  int _verbIndex = -1;
  int _phraseIndex = -1;

  int get wordIndex => _wordIndex;
  int get verbIndex => _verbIndex;
  int get phraseIndex => _phraseIndex;

  set wordIndex(index) {
    _wordIndex = index;
  }

  set verbIndex(index) {
    _verbIndex = index;
  }

  set phraseIndex(index) {
    _phraseIndex = index;
  }
}
