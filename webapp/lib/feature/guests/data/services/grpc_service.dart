// import 'package:grpc/grpc.dart';
// import 'package:flutter_guests/generated/guest.pb.dart';
// import 'package:flutter_guests/generated/guest.pbgrpc.dart';
// import 'package:flutter_guests/generated/guest.pbenum.dart';

// class ServiceClient {
//   final channel = ClientChannel('localhost',
//       port: 3000,
//       options:
//           const ChannelOptions(credentials: ChannelCredentials.insecure()));
//   late GuestServiceClient stub;

//   // Adicione o getter instance
//   static final instance = ServiceClient._init();

//   ServiceClient._init();

//   Init() {
//     stub = GuestServiceClient(channel);
//   }

//   Future<GuestsResponse> getGuests() async {
//     try {
//       final request = Empty();
//       final response = await stub.index(request);
//       return response;
//     } catch (e) {
//       print('Caught error: $e');
//       throw Exception('Error getting guests: $e');
//     }
//   }

//   Future<void> dispose() async {
//     await channel.shutdown();
//   }
// }

// class MyRequest {
//   // Define os campos que você precisa para sua requisição.
// }

// class MyResponse {
//   // Define os campos que você precisa para sua resposta.
// }

import 'package:grpc/grpc.dart';
import 'package:flutter_guests/generated/guest.pb.dart';
import 'package:flutter_guests/generated/guest.pbgrpc.dart';
import 'package:flutter_guests/generated/guest.pbenum.dart';

class ServiceClient {
  final channel = ClientChannel('172.16.8.73',
      port: 3001,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));
  GuestServiceClient? stub;

  // Adicione o getter instance
  static final instance = ServiceClient._init();

  ServiceClient._init() {
    Init();
  }

  Init() {
    stub = GuestServiceClient(channel);
  }

  Future<GuestsResponse> getGuests() async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request = Empty();
      final response = await stub!.index(request);
      return response;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }

  Future<void> dispose() async {
    await channel.shutdown();
  }
}

class MyRequest {
  // Define os campos que você precisa para sua requisição.
}

class MyResponse {
  // Define os campos que você precisa para sua resposta.
}
