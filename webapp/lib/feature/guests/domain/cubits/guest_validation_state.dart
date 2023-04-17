part of 'guest_validation_cubit.dart';

abstract class GuestValidationState extends Equatable {
  const GuestValidationState();
}

// Campos do formulario aguardando validacao com sucesso
class GuestValidating extends GuestValidationState {
  const GuestValidating({
    this.tituloMessage,
    this.conteudoMessage,
  });

  final String? tituloMessage;
  final String? conteudoMessage;

  GuestValidating copyWith({
    String? tituloMessage,
    String? conteudoMessage,
  }) {
    return GuestValidating(
      tituloMessage: tituloMessage ?? this.tituloMessage,
      conteudoMessage: conteudoMessage ?? this.conteudoMessage,
    );
  }

  @override
  List<Object?> get props => [tituloMessage, conteudoMessage];
}

// Campos do formulario validados com sucesso
class GuestValidated extends GuestValidationState {
  const GuestValidated();

  @override
  List<Object> get props => [];
}
