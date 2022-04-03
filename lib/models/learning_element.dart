class LearningElement {
  dynamic element;
  int repetitions;

  LearningElement({required this.element, required this.repetitions});

  decreaseRepetitions(int n) {
    repetitions -= n;
  }

  increaseRepetitions(int n) {
    repetitions += n;
  }
}
