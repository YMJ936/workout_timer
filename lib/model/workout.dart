class Workout { // 운동의 이름과 세트 정보를 담은 클래스
  String workoutName; //운동 이름
  List<SetInfo> sets; //세트 리스트

  Workout({required this.workoutName, required this.sets});

  factory Workout.fromJson(Map<String, dynamic> json) {//Exercise.fromJson 팩토리 메서드: JSON 형식의 데이터를 매개변수로 받아 Exercise 객체를 생성
    var sets = (json['sets'] as List)//주어진 JSON 데이터에서 'sets'라는 키에 해당하는 값을 가져옵니다. 이 값은 리스트 형태로 되어 있어야 합니다.
        .map((set) => SetInfo.fromJson(set)) //map 함수를 사용하여 리스트의 각 요소에 대해 SetInfo.fromJson 함수를 호출합니다./ SetInfo.fromJson 함수는 해당 요소를 SetInfo 객체로 변환합니다.
        .toList();//toList 함수를 사용하여 변환된 SetInfo 객체들로 이루어진 리스트를 생성합니다.

    return Workout( //exerciseName과 생성된 리스트를 사용하여 Exercise 객체를 생성하고 반환합니다.
      workoutName: json['workout_name'],
      sets: sets,
    );
  }

  @override
  String toString() {
    return 'Workout{workoutName: $workoutName, sets: $sets}';
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> setsJson =
    sets.map((set) => set.toJson()).toList();

    return {
      'workout_name': workoutName,
      'sets': setsJson,
    };
  }
}

class SetInfo {
  int setCount; //세트수
  int restTime; //휴식시간
  bool isActive;


  SetInfo({required this.setCount, required this.restTime, required this.isActive});

  factory SetInfo.fromJson(Map<String, dynamic> json) { //fromJson() 메서드로 JSON데이터를 SetInfo객체로 변환
    return SetInfo(
      setCount: json['set_count'],
      restTime: json['rest_time'],
      isActive: json['is_active'],
    );
  }

  @override
  String toString() {
    return 'SetInfo{setCount: $setCount, restTime: $restTime, isActive: $isActive}';
  }

  Map<String, dynamic> toJson() {
    return {
      'set_count': setCount,
      'rest_time': restTime,
      'is_active': isActive,
    };
  }

}