import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/content_text_form_field.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/image_bottom_sheet.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/image_viewer.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/location_icon.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/location_text_form_field.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/post_button.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/team_text_form_field.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/widgets/title_text_form_field.dart';

class WritePage extends ConsumerStatefulWidget {
  final BuildContext homeContext;
  const WritePage({
    super.key,
    required this.homeContext,
  });

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final formKey = GlobalKey<FormState>();
  final locationTextController = TextEditingController(text: '');
  final titleTextController = TextEditingController(text: '');
  final teamTextController = TextEditingController(text: '');
  final contentTextController = TextEditingController(text: '');
  final imagePathTextController = TextEditingController();
  final LoadingOverlay loadingOverlay = LoadingOverlay();

  @override
  void dispose() {
    super.dispose();
    locationTextController.dispose();
    titleTextController.dispose();
    teamTextController.dispose();
    contentTextController.dispose();
    imagePathTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              actions: [
                PostButton(
                  formKey: formKey,
                  titleTextController: titleTextController,
                  contentTextController: contentTextController,
                  teamTextController: teamTextController,
                  loadingOverlay: loadingOverlay,
                  homeContext: widget.homeContext,
                ),
              ],
              actionsPadding: EdgeInsets.only(right: 20)),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Row(
                  children: [
                    LocationTextFormField(controller: locationTextController),
                    LocationIcon(
                      controller: locationTextController,
                      loadingOverlay: loadingOverlay,
                    ),
                  ],
                ),
                TeamTextFormField(controller: teamTextController),
                TitleTextFormField(controller: titleTextController),
                ContentTextFormField(controller: contentTextController),
                SizedBox(
                  height: 20,
                ),
                ImageViewer(),
              ],
            ),
          ),
          bottomSheet: ImageBottomSheet(
            controller: imagePathTextController,
            loadingOverlay: loadingOverlay,
          ),
        ),
      ),
    );
  }
}
