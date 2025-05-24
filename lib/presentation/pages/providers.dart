import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/data/data_source/team_feed_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_feed_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/location_data_source.dart';
import 'package:mercenaryhub/data/data_source/location_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_apply_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_apply_history_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/mercenary_apply_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/mercenary_apply_history_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/team_feed_log_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_feed_repository_impl.dart';
import 'package:mercenaryhub/data/repository/location_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_apply_history_repository_impl.dart';
import 'package:mercenaryhub/data/repository/mercenary_apply_history_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';
import 'package:mercenaryhub/domain/repository/location_repository.dart';
import 'package:mercenaryhub/domain/repository/team_apply_history_repository.dart';
import 'package:mercenaryhub/domain/repository/mercenary_apply_history_repository.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_feed_logs_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_feeds_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mercenaryhub/data/data_source/image_data_source.dart';
import 'package:mercenaryhub/data/data_source/image_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/image_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/image_repository.dart';
import 'package:mercenaryhub/domain/usecase/get_location_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_team_feed_log_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_team_feed_usecase.dart';
import 'package:mercenaryhub/domain/usecase/stream_fetch_team_feeds_usecase.dart';
import 'package:mercenaryhub/domain/usecase/upload_image_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_apply_histories_usecase.dart';
import 'package:mercenaryhub/domain/usecase/update_team_apply_status_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_mercenary_apply_histories_usecase.dart';
import 'package:mercenaryhub/domain/usecase/cancel_mercenary_apply_usecase.dart';

final _teamFeedDataSourceProvider = Provider<TeamFeedDataSource>((ref) {
  return TeamFeedDataSourceImpl(FirebaseFirestore.instance);
});

final _teamFeedRepositoryProvider = Provider<TeamFeedRepository>((ref) {
  final dataSource = ref.read(_teamFeedDataSourceProvider);
  return TeamFeedRepositoryImpl(dataSource);
});

final fetchTeamFeedsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamFeedRepositoryProvider);
  return FetchTeamFeedsUsecase(repository);
});

final insertTeamFeedUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamFeedRepositoryProvider);
  return InsertTeamFeedUsecase(repository);
});

final streamFetchTeamFeedsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamFeedRepositoryProvider);
  return StreamFetchTeamFeedsUsecase(repository);
});

final _teamFeedLogDataSourceProvider = Provider<TeamFeedLogDataSource>((ref) {
  return TeamFeedLogDataSourceImpl(FirebaseFirestore.instance);
});

final _teamFeedLogRepositoryProvider = Provider<TeamFeedLogRepository>((ref) {
  final dataSource = ref.read(_teamFeedLogDataSourceProvider);
  return TeamFeedLogRepositoryImpl(dataSource);
});

final fetchTeamFeedLogsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamFeedLogRepositoryProvider);
  return FetchTeamFeedLogsUsecase(repository);
});

final insertTeamFeedLogUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamFeedLogRepositoryProvider);
  return InsertTeamFeedLogUsecase(repository);
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

// Team Apply History Providers
final _teamApplyHistoryDataSourceProvider =
    Provider<TeamApplyHistoryDataSource>((ref) {
  return TeamApplyHistoryDataSourceImpl(FirebaseFirestore.instance);
});

final _teamApplyHistoryRepositoryProvider =
    Provider<TeamApplyHistoryRepository>((ref) {
  final dataSource = ref.read(_teamApplyHistoryDataSourceProvider);
  return TeamApplyHistoryRepositoryImpl(dataSource);
});

final fetchTeamApplyHistoriesUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamApplyHistoryRepositoryProvider);
  return FetchTeamApplyHistoriesUsecase(repository);
});

final updateTeamApplyStatusUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamApplyHistoryRepositoryProvider);
  return UpdateTeamApplyStatusUsecase(repository);
});

// Mercenary Apply History Providers
final _mercenaryApplyHistoryDataSourceProvider =
    Provider<MercenaryApplyHistoryDataSource>((ref) {
  return MercenaryApplyHistoryDataSourceImpl(FirebaseFirestore.instance);
});

final _mercenaryApplyHistoryRepositoryProvider =
    Provider<MercenaryApplyHistoryRepository>((ref) {
  final dataSource = ref.read(_mercenaryApplyHistoryDataSourceProvider);
  return MercenaryApplyHistoryRepositoryImpl(dataSource);
});

final fetchMercenaryApplyHistoriesUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryApplyHistoryRepositoryProvider);
  return FetchMercenaryApplyHistoriesUsecase(repository);
});

final cancelMercenaryApplyUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryApplyHistoryRepositoryProvider);
  return CancelMercenaryApplyUsecase(repository);
});
