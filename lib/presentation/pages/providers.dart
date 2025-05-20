import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/data/data_source/feed_data_source.dart';
import 'package:mercenaryhub/data/data_source/feed_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/location_data_source.dart';
import 'package:mercenaryhub/data/data_source/location_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/feed_repository_impl.dart';
import 'package:mercenaryhub/data/repository/location_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';
import 'package:mercenaryhub/domain/repository/location_repository.dart';
import 'package:mercenaryhub/domain/usecase/fetch_feeds_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mercenaryhub/data/data_source/image_data_source.dart';
import 'package:mercenaryhub/data/data_source/image_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/image_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/image_repository.dart';
import 'package:mercenaryhub/domain/usecase/get_location_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_feed_usecase.dart';
import 'package:mercenaryhub/domain/usecase/upload_image_usecase.dart';

final _feedDataSourceProvider = Provider<FeedDataSource>((ref) {
  return FeedDataSourceImpl(FirebaseFirestore.instance);
});

final _feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final dataSource = ref.read(_feedDataSourceProvider);
  return FeedRepositoryImpl(dataSource);
});

final fetchFeedsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_feedRepositoryProvider);
  return FetchFeedsUsecase(repository);
});

final insertFeedUseCaseProvider = Provider((ref) {
  final repository = ref.read(_feedRepositoryProvider);
  return InsertFeedUsecase(repository);
});

final _imageDataSourceProvider = Provider<ImageDataSource>((ref) {
  return ImageDataSourceImpl(FirebaseStorage.instance);
});

final _imageRepositoryProvider = Provider<ImageRepository>((ref) {
  final dataSource = ref.read(_imageDataSourceProvider);
  return ImageRepositoryImpl(dataSource);
});

final uploadImageUsecaseProvider = Provider((ref) {
  final repository = ref.read(_imageRepositoryProvider);
  return UploadImageUsecase(repository);
});

final _locationDataSourceProvider = Provider<LocationDataSource>(
  (ref) {
    return LocationDataSourceImpl(Dio());
  },
);

final _locationRepository = Provider<LocationRepository>((ref) {
  final dataSource = ref.read(_locationDataSourceProvider);
  return LocationRepositoryImpl(dataSource);
});

final getLocationUsecaseProvider = Provider((ref) {
  final repository = ref.read(_locationRepository);
  return GetLocationUsecase(repository);
});
