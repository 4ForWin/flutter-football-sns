import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class WriteState {
  bool isErrorVisible;
  bool isLocationFieldEnable;
  XFile? imageFile;
  String? imageUrl;
  String? location;

  WriteState({
    required this.isErrorVisible,
    required this.isLocationFieldEnable,
    required this.imageFile,
    required this.imageUrl,
    required this.location,
  });

  WriteState copyWith({
    bool? isErrorVisible,
    bool? isLocationFieldEnable,
    XFile? imageFile,
    String? imageUrl,
    String? location,
  }) {
    return WriteState(
      isErrorVisible: isErrorVisible ?? this.isErrorVisible,
      isLocationFieldEnable:
          isLocationFieldEnable ?? this.isLocationFieldEnable,
      imageFile: imageFile ?? this.imageFile,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
    );
  }
}

class WriteViewModel extends AutoDisposeNotifier<WriteState> {
  @override
  build() {
    return WriteState(
      isErrorVisible: false,
      isLocationFieldEnable: true,
      imageFile: null,
      imageUrl: null,
      location: null,
    );
  }

  void changeIsErrorVisible(bool isErrorVisible) {
    state = state.copyWith(isErrorVisible: isErrorVisible);
  }

  void changeIsLocationFieldEnable(bool isLocationFieldEnable) {
    state = state.copyWith(isLocationFieldEnable: isLocationFieldEnable);
  }

  void changeImageFile(XFile xfile) {
    state = state.copyWith(imageFile: xfile);
  }

  String setLocation() {
    state = state.copyWith(location: '서울 강남구');
    return '서울 강남구';
  }

  Future<String> uploadImage() async {
    final uploadImageUsecase = ref.read(uploadImageUsecaseProvider);
    String imageUrl = await uploadImageUsecase.execute(state.imageFile!);
    state = state.copyWith(imageUrl: imageUrl);
    return imageUrl;
  }

  Future<bool> insertFeed({
    required String title,
    required String content,
    required String teamName,
  }) async {
    final insertFeedUsecase = ref.read(insertFeedUseCaseProvider);
    bool isComplete = await insertFeedUsecase.execute(
      title: title,
      content: content,
      teamName: teamName,
      imageUrl: state.imageUrl!,
      location: state.location!,
    );

    return isComplete;
  }
}

final writeViewModelProvider =
    NotifierProvider.autoDispose<WriteViewModel, WriteState>(
  () {
    return WriteViewModel();
  },
);
