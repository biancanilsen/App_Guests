import 'package:grpc/grpc.dart';
import 'package:flutter_guests/generated/guest.pb.dart';
import 'package:flutter_guests/generated/guest.pbgrpc.dart';
import 'package:flutter_guests/generated/guest.pbenum.dart';

import '../models/guest_model.dart';

class ServiceClient {
  late ClientChannel client;
  static final ServiceClient _singleton = new ServiceClient._internal();
  factory ServiceClient() => _singleton;
  ServiceClient._internal();

  // Adicione o getter instance
  static final instance = ServiceClient._init();

  ServiceClient._init() {
    Init();
  }

  Init() {
    client = ClientChannel(
      '172.16.8.73',
      port: 3001,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    stub = GuestServiceClient(client);
  }

  GuestServiceClient? stub;

  Future<GuestsResponse> getGuests() async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request = Empty();
      final response = await stub?.index(request);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }

  Future<void> dispose() async {
    await client.shutdown();
  }

  Future<GuestResponse> updateGuests(GuestResponse model) async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request;

      if (model.id == '') {
        request = GuestRequest(
          name: model.name,
          phone: model.phone,
          email: model.email,
        );
      } else {
        request = GuestRequest(
          id: model.id,
          name: model.name,
          phone: model.phone,
          email: model.email,
        );
      }

      final response = await stub?.create(request);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }

  Future<Empty> deleteGuests(String id) async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request = idRequest(
        id: id,
      );
      final response = await stub?.delete(request);
      return Empty();
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }
}

class MyRequest {
  // Define os campos que você precisa para sua requisição.
}

class MyResponse {
  // Define os campos que você precisa para sua resposta.
}
