import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'guest_validation_state.dart';

class GuestValidationCubit extends Cubit<GuestValidationState> {
  GuestValidationCubit() : super(const GuestValidating());

  //validar formulario de edicao do convidado
  void validaForm(String titulo, String conteudo) {
    String cubitTituloMessage = '';
    String cubitConteudoMessage = '';
    bool formInvalid;

    formInvalid = false;
    if (titulo == '') {
      formInvalid = true;
      cubitTituloMessage = 'Preencha o título';
    } else {
      cubitTituloMessage = '';
    }
    if (conteudo == '') {
      formInvalid = true;
      cubitConteudoMessage = 'Preencha o conteúdo';
    } else {
      cubitConteudoMessage = '';
    }

    if (formInvalid == true) {
      emit(GuestValidating(
        tituloMessage: cubitTituloMessage,
        conteudoMessage: cubitConteudoMessage,
      ));
    } else {
      emit(const GuestValidated());
    }
  }
}
