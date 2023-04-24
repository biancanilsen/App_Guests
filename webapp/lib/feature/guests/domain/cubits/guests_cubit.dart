import 'package:bloc/bloc.dart';
import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/guest.pb.dart';
import 'package:flutter/foundation.dart';

import '../../data/services/grpc_service.dart';
part 'guests_state.dart';

class GuestsCubit extends Cubit<GuestsState> {
  Init() {
    late ClientChannel client;
  }

  GuestsCubit({required ServiceClient serviceClient})
      : _serviceClient = serviceClient,
        super(const GuestsInitial());

  //Instancia do service
  final ServiceClient _serviceClient;

  //buscar todos os convidados
  Future<void> getGuests() async {
    emit(const GuestsLoading());
    try {
      final guestsResponse = await _serviceClient.getGuests();
      final guests = guestsResponse.guests
          .map((guest) => Guest(
                // Mapeie os campos do objeto Guest aqui
                id: guest.id,
                name: guest.name,
                phone: guest.phone,
                email: guest.email,
                // E assim por diante...
              ))
          .toList();
      print(guests);
      emit(GuestsLoaded(
        guests: guests,
      ));
    } on Exception {
      emit(const GuestsFailure());
    }
  }

  // Excluir convidado atraves um id
  Future<void> deleteGuest(id) async {
    emit(const GuestsLoading());

    // A linha abaixo nesse cubit simula tempo de processamento no servidor
    // serve para testar o circular indicator
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _serviceClient.deleteGuests(id);
      getGuests();
    } on Exception {
      emit(const GuestsFailure());
    }
  }

  // Salvar convidado
  Future<void> saveGuest(
      String? id, String name, String phone, String email) async {
    GuestResponse editGuest =
        GuestResponse(id: id, name: name, phone: phone, email: email);
    emit(const GuestsLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      //Se o metodo nao recebeu um id o convidado será incluida, caso contrario
      //o convidado existente sera atualizada pelo id
      debugPrint('id: $id');
      if (id == null) {
        editGuest = await _serviceClient.updateGuests(editGuest);
      } else {
        editGuest = await _serviceClient.updateGuests(editGuest);
      }
      emit(const GuestsSuccess());
      // buscarNotas();
    } on Exception {
      emit(const GuestsFailure());
    }
  }
}
