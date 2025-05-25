import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_data_source.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_log_data_source.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_log_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_feed_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_feed_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/location_data_source.dart';
import 'package:mercenaryhub/data/data_source/location_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_apply_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_apply_history_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source_impl.dart';
import 'package:mercenaryhub/data/data_source/team_invitation_received_data_source.dart';
import 'package:mercenaryhub/data/data_source/team_invitation_received_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/mercenary_feed_log_repository_impl.dart';
import 'package:mercenaryhub/data/repository/mercenary_feed_repository_impl.dart';
import 'package:mercenaryhub/data/repository/my_mercenary_invitation_history_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_feed_log_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_feed_repository_impl.dart';
import 'package:mercenaryhub/data/repository/location_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_apply_history_repository_impl.dart';
import 'package:mercenaryhub/data/repository/my_team_application_history_repository_impl.dart';
import 'package:mercenaryhub/data/repository/team_invitation_received_repository.dart';
import 'package:mercenaryhub/data/repository/team_invitation_received_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_log_repository.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_repository.dart';
import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';
import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';
import 'package:mercenaryhub/domain/repository/location_repository.dart';
import 'package:mercenaryhub/domain/repository/team_apply_history_repository.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';
import 'package:mercenaryhub/domain/usecase/apply_to_team_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_invitation_histories_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_mercenary_feed_logs_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_mercenary_feeds_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_feed_logs_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_feeds_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_invitations_usecase.dart';
import 'package:mercenaryhub/domain/usecase/respond_to_team_invitation_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mercenaryhub/data/data_source/image_data_source.dart';
import 'package:mercenaryhub/data/data_source/image_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/image_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/image_repository.dart';
import 'package:mercenaryhub/domain/usecase/get_location_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_mercenary_feed_log_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_mercenary_feed_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_team_feed_log_usecase.dart';
import 'package:mercenaryhub/domain/usecase/insert_team_feed_usecase.dart';
import 'package:mercenaryhub/domain/usecase/invite_to_mercenary_usecase.dart';
import 'package:mercenaryhub/domain/usecase/stream_fetch_mercenary_feeds_usecase.dart';
import 'package:mercenaryhub/domain/usecase/stream_fetch_team_feeds_usecase.dart';
import 'package:mercenaryhub/domain/usecase/upload_image_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_team_apply_histories_usecase.dart';
import 'package:mercenaryhub/domain/usecase/update_team_apply_status_usecase.dart';
import 'package:mercenaryhub/domain/usecase/fetch_application_histories_usecase.dart';
import 'package:mercenaryhub/domain/usecase/cancel_mercenary_apply_usecase.dart';
import 'package:mercenaryhub/data/data_source/mercenary_applicants_data_source.dart';
import 'package:mercenaryhub/data/data_source/mercenary_applicants_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/mercenary_applicants_repository_impl.dart';
import 'package:mercenaryhub/domain/repository/mercenary_applicants_repository.dart';
import 'package:mercenaryhub/domain/usecase/fetch_mercenary_applicants_usecase.dart';
import 'package:mercenaryhub/domain/usecase/respond_to_mercenary_application_usecase.dart';

// teamFeed 관련
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

// mercenaryFeed 관련
final _mercenaryFeedDataSourceProvider =
    Provider<MercenaryFeedDataSource>((ref) {
  return MercenaryFeedDataSourceImpl(FirebaseFirestore.instance);
});

final _mercenaryFeedRepositoryProvider =
    Provider<MercenaryFeedRepository>((ref) {
  final dataSource = ref.read(_mercenaryFeedDataSourceProvider);
  return MercenaryFeedRepositoryImpl(dataSource);
});

final fetchMercenaryFeedsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryFeedRepositoryProvider);
  return FetchMercenaryFeedsUsecase(repository);
});

final insertMercenaryFeedUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryFeedRepositoryProvider);
  return InsertMercenaryFeedUsecase(repository);
});

final streamFetchMercenaryFeedsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryFeedRepositoryProvider);
  return StreamFetchMercenaryFeedsUsecase(repository);
});

final _mercenaryFeedLogDataSourceProvider =
    Provider<MercenaryFeedLogDataSource>((ref) {
  return MercenaryFeedLogDataSourceImpl(FirebaseFirestore.instance);
});

final _mercenaryFeedLogRepositoryProvider =
    Provider<MercenaryFeedLogRepository>((ref) {
  final dataSource = ref.read(_mercenaryFeedLogDataSourceProvider);
  return MercenaryFeedLogRepositoryImpl(dataSource);
});

final fetchMercenaryFeedLogsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryFeedLogRepositoryProvider);
  return FetchMercenaryFeedLogsUsecase(repository);
});

final insertMercenaryFeedLogUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryFeedLogRepositoryProvider);
  return InsertMercenaryFeedLogUsecase(repository);
});

// 이미지 업로드 관련
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

// 위치 찾기 관련
final _locationDataSourceProvider = Provider<LocationDataSource>((ref) {
  return LocationDataSourceImpl(Dio());
});

final _locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final dataSource = ref.read(_locationDataSourceProvider);
  return LocationRepositoryImpl(dataSource);
});

final getLocationUsecaseProvider = Provider((ref) {
  final repository = ref.read(_locationRepositoryProvider);
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

// 내가 초대한 용병 내역 관련 providers
final _myMercenaryInvitationHistoryDataSourceProvider =
    Provider<MyMercenaryInvitationHistoryDataSource>((ref) {
  return MyMercenaryInvitationHistoryDataSourceImpl(FirebaseFirestore.instance);
});

final _myMercenaryInvitationHistoryRepositoryProvider =
    Provider<MyMercenaryInvitationHistoryRepository>((ref) {
  final dataSource = ref.read(_myMercenaryInvitationHistoryDataSourceProvider);
  return MyMercenaryInvitationHistoryRepositoryImpl(dataSource);
});

final inviteToMercenaryUsecaseProvider = Provider((ref) {
  final repository = ref.read(_myMercenaryInvitationHistoryRepositoryProvider);
  return InviteToMercenaryUsecase(repository);
});

final fetchInvitationHistoriesUsecaseProvider = Provider((ref) {
  final repository = ref.read(_myMercenaryInvitationHistoryRepositoryProvider);
  return FetchInvitationHistoriesUsecase(repository);
});

// 내가 신청한 팀 내역 관련 Providers
final _myTeamApplicationHistoryDataSourceProvider =
    Provider<MyTeamApplicationHistoryDataSource>((ref) {
  return MyTeamApplicationHistoryDataSourceImpl(FirebaseFirestore.instance);
});

final _myTeamApplicationHistoryRepositoryProvider =
    Provider<MyTeamApplicationHistoryRepository>((ref) {
  final dataSource = ref.read(_myTeamApplicationHistoryDataSourceProvider);
  return MyTeamApplicationHistoryRepositoryImpl(dataSource);
});

final applyToTeamUsecaseProvider = Provider((ref) {
  final repository = ref.read(_myTeamApplicationHistoryRepositoryProvider);
  return ApplyToTeamUsecase(repository);
});

final fetchApplicationHistoriesUsecaseProvider = Provider((ref) {
  final repository = ref.read(_myTeamApplicationHistoryRepositoryProvider);
  return FetchApplicationHistoriesUsecase(repository);
});

// 나를 초대한 팀 관련 providers
final _teamInvitationReceivedDataSourceProvider =
    Provider<TeamInvitationReceivedDataSource>((ref) {
  return TeamInvitationReceivedDataSourceImpl(FirebaseFirestore.instance);
});

final _teamInvitationReceivedRepositoryProvider =
    Provider<TeamInvitationReceivedRepository>((ref) {
  final dataSource = ref.read(_teamInvitationReceivedDataSourceProvider);
  return TeamInvitationReceivedRepositoryImpl(dataSource);
});

final fetchTeamInvitationsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamInvitationReceivedRepositoryProvider);
  return FetchTeamInvitationsUsecase(repository);
});

final respondToTeamInvitationUsecaseProvider = Provider((ref) {
  final repository = ref.read(_teamInvitationReceivedRepositoryProvider);
  return RespondToTeamInvitationUsecase(repository);
});

final _mercenaryApplicantsDataSourceProvider =
    Provider<MercenaryApplicantsDataSource>((ref) {
  return MercenaryApplicantsDataSourceImpl(FirebaseFirestore.instance);
});

final _mercenaryApplicantsRepositoryProvider =
    Provider<MercenaryApplicantsRepository>((ref) {
  final dataSource = ref.read(_mercenaryApplicantsDataSourceProvider);
  return MercenaryApplicantsRepositoryImpl(dataSource);
});

final fetchMercenaryApplicantsUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryApplicantsRepositoryProvider);
  return FetchMercenaryApplicantsUsecase(repository);
});

final respondToMercenaryApplicationUsecaseProvider = Provider((ref) {
  final repository = ref.read(_mercenaryApplicantsRepositoryProvider);
  return RespondToMercenaryApplicationUsecase(repository);
});
