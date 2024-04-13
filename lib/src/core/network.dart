import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:music_player/src/commons/providers/common_providers.dart';
import 'package:music_player/src/core/type_def.dart';
import 'package:music_player/src/utils/config.dart';

import 'failure.dart';
import 'res/lables.dart';
import 'res/messages.dart';

/// Watch NetworkRepoProvider to make sure to have the latest authToken passed.

final networkRepoProvider = StateProvider((ref){
  final authToken = ref.watch(authTokenProvider);
  return NetworkRepo(authToken: authToken);
});

/// Contains common methods required for client side NetworkRepos [GET, POST, PUT, DELETE].
/// Pass the [url] from endpoints using [Endpoints] class.
/// Every method has an optional parameter [requireAuth] default [true].
/// Set [requireAuth] to [false] if [authToken] is Empty.
class NetworkRepo{
  final String? _authToken;

  NetworkRepo({ required String? authToken}) : _authToken = authToken;

  FutureEither<Response> getRequest({required String url, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "x-auth-token": "$_authToken"
    };
    if(requireAuth){
      if((_authToken ?? '').isEmpty) {
        return Left(Failure(message: CoreFailureMessage.authTokenEmpty));
      }
    }
    if(AppConfig.logHttp){
      log('REQUEST TO : $url', name: CoreLabels.httpGet);
      log('requireAuth : $requireAuth', name: CoreLabels.httpGet);
    }
    try{
      final response = await get(Uri.parse(url), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: CoreLabels.httpGet);
      return Right(response);
    }catch(e, stktrc){
      return Left(Failure(message: CoreFailureMessage.getRequestMessage, stackTrace:stktrc));
    }
  }

  FutureEither<Response> postRequest({required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "Cookie": "token=$_authToken"
    };
    if(requireAuth){
      if((_authToken ?? '').isEmpty) {
        return Left(Failure(message: CoreFailureMessage.authTokenEmpty));
      }
    }
    if(AppConfig.logHttp){
      log('REQUEST TO : $url', name: CoreLabels.httpPost);
      log('requireAuth : $requireAuth', name: CoreLabels.httpPost);
      log('BODY : $body', name: CoreLabels.httpPost);
      if(requireAuth){
        log('AUTH TOKEN : $_authToken', name: CoreLabels.httpPost);
      }
    }
    try{
      final response = await post(Uri.parse(url), body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: CoreLabels.httpPost);
      return Right(response);
    }catch(e, stktrc){
      return Left(Failure(message: CoreFailureMessage.postRequestMessage, stackTrace:stktrc));
    }
  }

  FutureEither<Response> putRequest({required String url, dynamic body, bool requireAuth = true}) async {
     final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "x-auth-token": "$_authToken"
    };
    if(requireAuth){
      if((_authToken ?? '').isEmpty) {
        return Left(Failure(message: CoreFailureMessage.authTokenEmpty));
      }
    }
    if(AppConfig.logHttp){
      log('REQUEST TO : $url', name: CoreLabels.httpPut,);
      log('requireAuth : $requireAuth', name: CoreLabels.httpPut,);
      log('BODY : $body', name: CoreLabels.httpPut);
      if(requireAuth){
        log('AUTH TOKEN : $_authToken', name: CoreLabels.httpPut);
      }
    }
    try{
      final response = await put(Uri.parse(url), body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: CoreLabels.httpPut);
      return Right(response);
    }catch(e, stktrc){
      return Left(Failure(message: CoreFailureMessage.putRequestMessage, stackTrace:stktrc));
    }
  }

  FutureEither<Response> deleteRequest({required String url, dynamic body, bool requireAuth = true}) async {
     final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "Cookie": "token=$_authToken"
    };
    if(requireAuth){
      if((_authToken ?? '').isEmpty) {
        return Left(Failure(message: CoreFailureMessage.authTokenEmpty));
      }
    }
    if(AppConfig.logHttp){
      log('REQUEST TO : $url', name: CoreLabels.httpDelete);
      log('requireAuth : $requireAuth', name: CoreLabels.httpDelete);
      log('BODY : $body', name: CoreLabels.httpDelete);
    }
    try{
      final response = await delete(Uri.parse(url), body: body!=null ? jsonEncode(body):null, headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: CoreLabels.httpDelete);
      return Right(response);
    }catch(e, stktrc){
      return Left(Failure(message: CoreFailureMessage.deleteRequestMessage, stackTrace:stktrc));
    }
  }
}