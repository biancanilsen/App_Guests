part of 'guests_cubit.dart';

abstract class GuestsState extends Equatable {
  const GuestsState();
}

// Estado da tela inicial
class GuestsInitial extends GuestsState {
  const GuestsInitial();

  @override
  List<Object?> get props => [];
}

// Aguardando operacãoo ser realizada
class GuestsLoading extends GuestsState {
  const GuestsLoading();

  @override
  List<Object?> get props => [];
}

// Lista de convidados carregada
class GuestsLoaded extends GuestsState {
  const GuestsLoaded({
    this.guests,
  });

  final List<Guest>? guests;

  GuestsLoaded copyWith({
    List<Guest>? guests,
  }) {
    return GuestsLoaded(
      guests: guests ?? this.guests,
    );
  }

  @override
  List<Object?> get props => [guests];
}

// Falha ao realizar operacãoo com convidados
class GuestsFailure extends GuestsState {
  const GuestsFailure();

  @override
  List<Object?> get props => [];
}

// Operacão realizada com sucesso
class GuestsSuccess extends GuestsState {
  const GuestsSuccess();

  @override
  List<Object?> get props => [];
}
