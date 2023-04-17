import 'package:flutter_guests/feature/guests/domain/cubits/guest_validation_cubit.dart';
import 'package:flutter_guests/feature/guests/domain/cubits/guests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';

class GuestEditPage extends StatelessWidget {
  const GuestEditPage({Key? key, this.guest}) : super(key: key);
  final Guest? guest;
  // o NotesCubit que foi criado e providenciado para o MaterialApp eh recuperado
  // via construtor .value, lembrando que novas instancias nao usam o .value,
  // somente as novas instancias de um cubit/bloc
  // o NoteValidationCubit eh criado e providenciado para validacao dos campos
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<GuestsCubit>(context),
        ),
        BlocProvider(
          create: (context) => GuestValidationCubit(),
        ),
      ],
      child: GuestsEditView(guest: guest),
    );
  }
}

class GuestsEditView extends StatelessWidget {
  GuestsEditView({
    Key? key,
    this.guest,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final Guest? guest;

  @override
  Widget build(BuildContext context) {
    // se for edicao de uma nota existente, os campos do formulario
    // sao preenchidos com os atributos da nota
    if (guest == null) {
      _nameController.text = '';
      _phoneController.text = '';
      _emailController.text = '';
    } else {
      _nameController.text = guest!.Name;
      _phoneController.text = guest!.Phone;
      _emailController.text = guest!.Email;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guests'),
      ),
      body: BlocListener<GuestsCubit, GuestsState>(
        listener: (context, state) {
          // a descricao dos estados esta no arquivo notes_state e os estados
          // nao tratados aqui sao utilizados na tela de lista de notas
          // print(state.toString());
          if (state is GuestsInitial) {
            const SizedBox();
          } else if (state is GuestsLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          } else if (state is GuestsSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Operação realizada com sucesso'),
              ));
            // apos a nota ser salva, as notas sao recuperadas novamente e
            // o aplicativo apresenta novamenta a tela de lista de notas
            Navigator.pop(context);
            context.read<GuestsCubit>().getGuests();
          } else if (state is GuestsLoaded) {
            Navigator.pop(context);
          } else if (state is GuestsFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Erro ao atualizar nota'),
              ));
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<GuestValidationCubit, GuestValidationState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _phoneFocusNode.requestFocus,
                      onChanged: (text) {
                        // a validacao eh realizada em toda alteracao do campo
                        context.read<GuestValidationCubit>().validaForm(
                            _nameController.text, _phoneController.text);
                      },
                      onFieldSubmitted: (String value) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // o estado NotesValidating eh emitido quando ha erro de
                        // validacao em qualquer campo do formulario e
                        // a mensagem de erro tambem eh apresentada
                        if (state is GuestValidating) {
                          if (state.tituloMessage == '') {
                            return null;
                          } else {
                            return state.tituloMessage;
                          }
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<GuestValidationCubit, GuestValidationState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                      ),
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      textInputAction: TextInputAction.done,
                      onChanged: (text) {
                        // a validacao eh realizada em toda alteracao do campo
                        context.read<GuestValidationCubit>().validaForm(
                            _nameController.text, _phoneController.text);
                      },
                      onFieldSubmitted: (String value) {
                        if (_formKey.currentState!.validate()) {
                          //fechar teclado
                          FocusScope.of(context).unfocus();
                          context.read<GuestsCubit>().saveGuest(
                              guest?.GuestId,
                              _nameController.text,
                              _phoneController.text,
                              _emailController.text);
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // o estado NotesValidating eh emitido quando ha erro de
                        // validacao em qualquer campo do formulario e
                        // a mensagem de erro tambem eh apresentada
                        if (state is GuestValidating) {
                          if (state.conteudoMessage == '') {
                            return null;
                          } else {
                            return state.conteudoMessage;
                          }
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<GuestValidationCubit, GuestValidationState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _phoneFocusNode.requestFocus,
                      onChanged: (text) {
                        // a validacao eh realizada em toda alteracao do campo
                        context.read<GuestValidationCubit>().validaForm(
                            _emailController.text, _phoneController.text);
                      },
                      onFieldSubmitted: (String value) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // o estado NotesValidating eh emitido quando ha erro de
                        // validacao em qualquer campo do formulario e
                        // a mensagem de erro tambem eh apresentada
                        if (state is GuestValidating) {
                          if (state.tituloMessage == '') {
                            return null;
                          } else {
                            return state.tituloMessage;
                          }
                        }
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child:
                        BlocBuilder<GuestValidationCubit, GuestValidationState>(
                      builder: (context, state) {
                        // o botao de salvar eh habilitado somente quando
                        // o formulario eh completamente validado
                        return ElevatedButton(
                          onPressed: state is GuestValidated
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    //fechar teclado
                                    FocusScope.of(context).unfocus();
                                    context.read<GuestsCubit>().saveGuest(
                                        guest?.GuestId,
                                        _nameController.text,
                                        _phoneController.text,
                                        _emailController.text);
                                  }
                                }
                              : null,
                          child: const Text('Salvar'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
