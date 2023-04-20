///
//  Generated code. Do not modify.
//  source: guest.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'guest.pb.dart' as $0;
export 'guest.pb.dart';

class GuestServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.GuestRequest, $0.GuestResponse>(
      '/guest.GuestService/Create',
      ($0.GuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GuestResponse.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.GuestRequest, $0.GuestResponse>(
      '/guest.GuestService/Update',
      ($0.GuestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GuestResponse.fromBuffer(value));
  static final _$index = $grpc.ClientMethod<$0.Empty, $0.GuestsResponse>(
      '/guest.GuestService/Index',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GuestsResponse.fromBuffer(value));
  static final _$show = $grpc.ClientMethod<$0.idRequest, $0.GuestResponse>(
      '/guest.GuestService/Show',
      ($0.idRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GuestResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$0.idRequest, $0.Empty>(
      '/guest.GuestService/Delete',
      ($0.idRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  GuestServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GuestResponse> create($0.GuestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.GuestResponse> update($0.GuestRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$0.GuestsResponse> index($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$0.GuestResponse> show($0.idRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$show, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> delete($0.idRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class GuestServiceBase extends $grpc.Service {
  $core.String get $name => 'guest.GuestService';

  GuestServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GuestRequest, $0.GuestResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GuestRequest.fromBuffer(value),
        ($0.GuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GuestRequest, $0.GuestResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GuestRequest.fromBuffer(value),
        ($0.GuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.GuestsResponse>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.GuestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.idRequest, $0.GuestResponse>(
        'Show',
        show_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.idRequest.fromBuffer(value),
        ($0.GuestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.idRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.idRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.GuestResponse> create_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GuestRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$0.GuestResponse> update_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GuestRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$0.GuestsResponse> index_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return index(call, await request);
  }

  $async.Future<$0.GuestResponse> show_Pre(
      $grpc.ServiceCall call, $async.Future<$0.idRequest> request) async {
    return show(call, await request);
  }

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$0.idRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$0.GuestResponse> create(
      $grpc.ServiceCall call, $0.GuestRequest request);
  $async.Future<$0.GuestResponse> update(
      $grpc.ServiceCall call, $0.GuestRequest request);
  $async.Future<$0.GuestsResponse> index(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.GuestResponse> show(
      $grpc.ServiceCall call, $0.idRequest request);
  $async.Future<$0.Empty> delete($grpc.ServiceCall call, $0.idRequest request);
}
