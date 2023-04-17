import 'package:bloc/bloc.dart';
import 'package:flutter_guests/feature/guests/data/database/database_provider.dart';
import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';
import 'package:equatable/equatable.dart';
import '../../data/services/api_service.dart';
import 'package:flutter/foundation.dart';
part 'guests_state.dart';

class GuestsCubit extends Cubit<GuestsState> {
  GuestsCubit({required APIService apiService})
      : _apiService = apiService,
        super(const GuestsInitial());

  //Instancia do banco de dados sqlite
  final APIService _apiService;

  //buscar todos os convidados
  Future<void> getGuests() async {
    emit(const GuestsLoading());
    try {
      final guests = await _apiService.getGuests();
      emit(GuestsLoaded(
        guests: guests,
      ));
    } on Exception {
      emit(const GuestsFailure());
    }
  }

  //Excluir convidado atraves um id
  Future<void> deleteGuest(guestId) async {
    emit(const GuestsLoading());

    // A linha abaixo nesse cubit simula tempo de processamento no servidor
    // serve para testar o circular indicator
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _apiService.deleteGuest(guestId);
      getGuests();
    } on Exception {
      emit(const GuestsFailure());
    }
  }

  //excluir todos os convidados
  // Future<void> deleteAllGuests() async {
  //   emit(const GuestsLoading());

  //   await Future.delayed(const Duration(seconds: 2));
  //   try {
  //     await _apiService.deleteAll();
  //     emit(const GuestsLoaded(
  //       guests: [],
  //     ));
  //   } on Exception {
  //     emit(const GuestsFailure());
  //   }
  // }

  //Salvar convidado
  Future<void> saveGuest(
      int? id, String name, String phone, String email) async {
    Guest editGuest =
        Guest(GuestId: id, Name: name, Phone: phone, Email: email);
    emit(const GuestsLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      //Se o metodo nao recebeu um id a nota será incluida, caso contrario
      //a nota existente sera atualizada pelo id
      debugPrint('id: $id');
      if (id == null) {
        editGuest = await _apiService.saveGuest(editGuest);
      } else {
        editGuest = await _apiService.updateGuests(editGuest);
      }
      emit(const GuestsSuccess());
      // buscarNotas();
    } on Exception {
      emit(const GuestsFailure());
    }
  }
}
