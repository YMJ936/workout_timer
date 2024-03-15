class Routine {
  String user;
  int order;
  String routineName;
  List<Workout> workouts;

  Routine({
    required this.user,
    required this.order,
    required this.routineName,
    required this.workouts,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    var workouts = json['workouts'] as List;
    List<Workout> workoutsList = workouts.map((i) => Workout.fromJson(i)).toList();
    return Routine(
      user: json['user'],
      order: json['order'],
      routineName: json['routineName'],
      workouts: workoutsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> workoutsJson = workouts.map((workout) => workout.toJson()).toList();
    return {
      'user': user,
      'order': order,
      'routineName': routineName,
      'workouts': workoutsJson,
    };
  }

  @override
  String toString() {
    return 'Routine(routineName: $routineName, workouts: $workouts)';
  }
}

class Workout {
  String workoutName;
  int sets;
  int restTime;
  bool isActive;

  Workout({
    required this.workoutName, required this.sets, required this.restTime, required this.isActive});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      workoutName: json['workoutName'],
      sets: json['sets'],
      restTime: json['restTime'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workoutName': workoutName,
      'sets': sets,
      'restTime': restTime,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'Workout(workoutName: $workoutName, sets: $sets, restTime: $restTime, isActive: $isActive)';
  }
}