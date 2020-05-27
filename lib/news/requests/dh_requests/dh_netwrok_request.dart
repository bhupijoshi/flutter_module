import 'package:crypto/crypto.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DHNetworkRequest {
  final String _partnerCode = 'snapdeal1';
  final String _apiKeyValue = 'grBY9UjGjFgpXpFyOnuwNPMPXmxp+y5/HjxMrgFixu8=';
  final String _secretkey = 'xurDYa6wyY+zw3NzBh/YfQ==';
  final String _httpMethodGet = 'GET';
  final String _baseUrl = 'http://feed.dailyhunt.in';
  String serviceName = '';
  String queryParams = '';
  DHNetworkRequest({
    @required this.serviceName,
    this.queryParams,
  });
  Future<http.Response> preformRequest() async {
    
    //add default query params. In query parameter always add the "ts" query parameter
    queryParams = queryParams +
        "langCode=en&partner=$_partnerCode&puid=test123&ts=" +
        DateTime.now().millisecondsSinceEpoch.toString();

    // Generate the signature base string
    String signatureBase = _generateSignatureBase(_httpMethodGet, queryParams);

    // Generate the signature i.e. Message Authentication Code using HMAC
    final signature = _calculateRFC2104HMAC(signatureBase);

    // Form the url & pass the API_KEY and the Signature generated in the header
    String httpUrl = _baseUrl + serviceName + queryParams;
    Map<String, String> headers = Map();
    headers['Authorization'] = 'key=' + _apiKeyValue;
    headers['Signature'] = signature;
    final response = await http.get(httpUrl, headers: headers);
    return response;
  }

//Generate signature
  String _generateSignatureBase(String httpMethod, String queryString) {
    String signatureBaseBuffer = '';

    //check if the query parameters available
    if (queryString.isNotEmpty) {
      final queryParams = _convertQueryParamsToMap(queryString);

      // Sort all the request query parameters lexicographically, sorted on encoded key
      SplayTreeMap mapTree = SplayTreeMap();
      queryParams.forEach((key, value){
        mapTree[Uri.encodeFull(key)] = Uri.encodeFull(value);
      });
      // final sortedParams = SplayTreeMap.from(queryParams);
      // Append all the key=value with “&” as separator if more than one key=value is present
      signatureBaseBuffer = signatureBaseBuffer + _formatAsUrl(mapTree);
    }
    // Append the UPPERCASE(http method)
    signatureBaseBuffer = signatureBaseBuffer + _httpMethodGet.toUpperCase();
    return signatureBaseBuffer;
  }

// Convert Query params to map
  Map<Object, Object> _convertQueryParamsToMap(String queryString) {
    if (queryString.isEmpty) {
      return Map();
    }
    Map<String, Object> paramsMap = Map();
    final List<Object> params = queryString.split('&');
    for (var param in params) {
      final List<Object> keyValue = param.toString().split('=');
      final key = keyValue[0];
      final value = keyValue.length == 2
          ? keyValue[1]
          : '';
      paramsMap[key] = value;
    }
    return paramsMap;
  }

// convert map to url string
  String _formatAsUrl(SplayTreeMap<dynamic, dynamic> aMap) {
    if (aMap == null) {
      return '';
    }
    String urlString = '';
    aMap.forEach((key, value) {
      if (urlString.length != 0) {
        urlString = urlString + '&';
      }
      urlString = urlString + key + '=' + value;
    });
    return urlString;
  }

// calculate calculateRFC2104HMAC
  String _calculateRFC2104HMAC(String baseSign) {
    var key = utf8.encode(_secretkey);
    var data = utf8.encode(baseSign);
    var hmacSha1 = new Hmac(sha1, key);
    Digest sha1Result = hmacSha1.convert(data);
    String base64Mac = base64Encode(sha1Result.bytes);
    return base64Mac; 
  }
}
