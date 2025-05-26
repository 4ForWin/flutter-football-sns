import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mercenaryhub/core/geolocator_helper.dart';
import 'package:mercenaryhub/data/data_source/location_data_source.dart';

class LocationDataSourceImpl implements LocationDataSource {
  late Dio _dio;

  LocationDataSourceImpl(Dio dio) {
    _dio = dio;
    _dio.options = BaseOptions(
      validateStatus: (status) => true,
    );
  }

  @override
  Future<String> getLocation() async {
    try {
      // 1. 위치 권한 및 GPS 위치 가져오기
      final pos = await GeolocatorHelper.getPosition();

      if (pos == null) {
        return '위치 권한이 필요합니다';
      }

      // 2. API 키 확인
      final apiKey = dotenv.env['VWORLD_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        return '위치 서비스 설정 오류';
      }

      // 3. API 호출
      final response = await _dio.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': apiKey,
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT(${pos.longitude} ${pos.latitude})',
          'geometry': false,
          'size': 100,
        },
      );

      // 4. 응답 검증
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['response']?['status'] == 'OK') {
          final features = responseData['response']?['result']
              ?['featureCollection']?['features'];

          if (features != null && features.isNotEmpty) {
            final fullName = features[0]?['properties']?['full_nm'];
            if (fullName != null && fullName.isNotEmpty) {
              return fullName;
            }
          }
        }
      }

      // 5. API 응답은 왔지만 데이터가 없는 경우
      return '위치 정보를 찾을 수 없습니다';
    } catch (e) {
      // 6. 네트워크 오류 등
      return '위치 서비스 오류';
    }
  }
}
