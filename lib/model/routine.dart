class Routine {
  String user;
  String routineName;
  List<Workout> workouts;

  Routine({required this.user, required this.routineName, required this.workouts});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> exercisesJson = workouts.map((exercise) => exercise.toJson()).toList();
    return {
      'user': user,
      'routineName': routineName,
      'exercises': exercisesJson,
    };
  }
}

class Workout {
  String workoutName;
  int order;
  int sets;
  int restTime;

  Workout({required this.workoutName, required this.order, required this.sets, required this.restTime});

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': workoutName,
      'order' : order,
      'sets': sets,
      'restTime': restTime,
    };
  }
}