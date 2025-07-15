import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

class WriteState {
  bool isErrorVisible;
  bool isLocationFieldEnable;
  bool isDateFieldEnable;
  bool isStartTimeFieldEnable;
  bool isEndTimeFieldEnable;
  XFile? imageFile;
  String? imageUrl;
  String? location;
  String? level;
  DateTime date;
  TimeState time;

  WriteState({
    required this.isErrorVisible,
    required this.isLocationFieldEnable,
    required this.isDateFieldEnable,
    required this.isStartTimeFieldEnable,
    required this.isEndTimeFieldEnable,
    required this.imageFile,
    required this.imageUrl,
    required this.location,
    required this.level,
    DateTime? date,
    TimeState? time,
  })  : date = date ?? DateTime.now(),
        time = time ?? TimeState();

  WriteState copyWith({
    bool? isErrorVisible,
    bool? isLocationFieldEnable,
    bool? isDateFieldEnable,
    bool? isStartTimeFieldEnable,
    bool? isEndTimeFieldEnable,
    XFile? imageFile,
    String? imageUrl,
    String? location,
    String? level,
    DateTime? date,
    TimeState? time,
  }) {
    return WriteState(
      isErrorVisible: isErrorVisible ?? this.isErrorVisible,
      isLocationFieldEnable:
          isLocationFieldEnable ?? this.isLocationFieldEnable,
      isDateFieldEnable: isDateFieldEnable ?? this.isDateFieldEnable,
      isStartTimeFieldEnable:
          isStartTimeFieldEnable ?? this.isStartTimeFieldEnable,
      isEndTimeFieldEnable: isEndTimeFieldEnable ?? this.isEndTimeFieldEnable,
      imageFile: imageFile ?? this.imageFile,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      level: level ?? this.level,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
