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
      final pos = await GeolocatorHelper.getPosition();

      final response = await _dio.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': dotenv.env['VWORLD_API_KEY'],
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT(${pos?.longitude} ${pos?.latitude})',
          'geometry': false,
          'size': 100,
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        // response > result > featureCollection > features[0] > properties > full_nm
        return response.data['response']['result']['featureCollection']
            ['features'][0]['properties']['full_nm'];
      }
    } catch (e, s) {
      print('❌getLocation e : $e');
      print('❌getLocation s : $s');
      return '';
    }

    return '1';
  }
}
