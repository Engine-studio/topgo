class WorkShift {
  int movement;
  List<int> begin;
  List<int> end;
  bool terminal;

  WorkShift({
    required this.movement,
    required this.begin,
    required this.end,
    this.terminal = false,
  });

  WorkShift.none()
      : this.movement = -1,
        this.begin = [],
        this.end = [],
        this.terminal = false;
}
