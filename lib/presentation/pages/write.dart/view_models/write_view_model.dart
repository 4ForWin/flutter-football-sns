import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/providers/feed_providers.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/models/write_state.dart';

class WriteViewModel extends AutoDisposeNotifier<WriteState> {
  @override
  build() {
    return WriteState(
      isErrorVisible: false,
      isLocationFieldEnable: true,
      isDateFieldEnable: true,
      isStartTimeFieldEnable: true,
      isEndTimeFieldEnable: true,
      imageFile: null,
      imageUrl: null,
      location: null,
      level: null,
      // time: null,
    );
  }

  void changeIsErrorVisible(bool isErrorVisible) {
    state = state.copyWith(isErrorVisible: isErrorVisible);
  }

  void changeIsLocationFieldEnable(bool isLocationFieldEnable) {
    state = state.copyWith(isLocationFieldEnable: isLocationFieldEnable);
  }

  void changeIsDateFieldEnable(bool isDateFieldEnable) {
    state = state.copyWith(isDateFieldEnable: isDateFieldEnable);
  }

  void changeIsStartTimeFieldEnable(bool isStartTimeFieldEnable) {
    state = state.copyWith(isStartTimeFieldEnable: isStartTimeFieldEnable);
  }

  void changeIsEndTimeFieldEnable(bool isEndTimeFieldEnable) {
    state = state.copyWith(isEndTimeFieldEnable: isEndTimeFieldEnable);
  }

  void changeImageFile(XFile xfile) {
    state = state.copyWith(imageFile: xfile);
  }

  void changeLevel(String? value) {
    state = state.copyWith(level: value);
  }

  Future<String?> changeDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: state.date, // 현재 선택된 날짜(화면에 보여줄 날짜)
      firstDate: DateTime.now(), // 시작 날짜 범위
      lastDate: DateTime(DateTime.now().year, 12, 31), // 끝 날짜 범위
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // locale: const Locale('ko'),
    );

    if (selectedDate != null) {
      state = state.copyWith(date: selectedDate);
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }

    return null;
  }

  Future<String?> changeTime(BuildContext context, String type) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );

    if (selectedTime != null) {
      DateTime dateAndTime = DateTime(
        state.date.year,
        state.date.month,
        state.date.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (type == 'start') {
        if (state.time.end != null && context.mounted) {
          if (dateAndTime == state.time.end ||
              dateAndTime.isAfter(state.time.end!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '시작 시간이 끝 시간보다 빨라야 합니다.',
                  style: TextStyle(color: Color(0xffC82223)),
                ),
                duration: Duration(seconds: 5),
              ),
            );

            return ''; // 유효성 검사 할 수 있게 하기 위해
          }
        }

        state = state.copyWith(time: state.time.copyWith(start: dateAndTime));
        return DateFormat('HH:mm').format(dateAndTime);
      } else if (type == 'end') {
        if (state.time.start != null && context.mounted) {
          if (dateAndTime == state.time.start ||
              dateAndTime.isBefore(state.time.start!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '시작 시간이 끝 시간보다 빨라야 합니다.',
                  style: TextStyle(color: Color(0xffC82223)),
                ),
                duration: Duration(seconds: 5),
              ),
            );

            return ''; // 유효성 검사 할 수 있게 하기 위해
          }
        }

        state = state.copyWith(time: state.time.copyWith(end: dateAndTime));
        return DateFormat('HH:mm').format(dateAndTime);
      }
    }

    return null;
  }

  Future<String> getLocation() async {
    final getlocationUsecase = ref.read(getLocationUsecaseProvider);
    String location = await getlocationUsecase.execute();
    state = state.copyWith(location: location);
    return location;
  }

  Future<String> uploadImage() async {
    final uploadImageUsecase = ref.read(uploadImageUsecaseProvider);
    String imageUrl = await uploadImageUsecase.execute(state.imageFile!);
    state = state.copyWith(imageUrl: imageUrl);
    return imageUrl;
  }

  Future<bool> insertTeamFeed({
    required String teamName,
    required String cost,
    required String person,
    required String content,
  }) async {
    final insertTeamFeedUsecase = ref.read(insertTeamFeedUsecaseProvider);
    bool isComplete = await insertTeamFeedUsecase.execute(
      location: state.location!,
      teamName: teamName,
      cost: cost,
      person: person,
      level: state.level!,
      date: state.date,
      time: state.time,
      content: content,
      imageUrl: state.imageUrl!,
    );

    return isComplete;
  }

  Future<bool> insertMercenaryFeed({
    required String name,
    required String cost,
    required String content,
  }) async {
    final insertMercenaryFeedUsecase =
        ref.read(insertMercenaryFeedUsecaseProvider);
    bool isComplete = await insertMercenaryFeedUsecase.execute(
      location: state.location!,
      name: name,
      cost: cost,
      level: state.level!,
      date: state.date,
      time: state.time,
      content: content,
      imageUrl: state.imageUrl!,
    );

    return isComplete;
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose<WriteViewModel, WriteState>(() {
  return WriteViewModel();
});
