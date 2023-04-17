import 'package:flutter_guests/feature/guests/domain/cubits/guests_cubit.dart';
import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';
import 'package:flutter_guests/feature/guests/presentation/pages/guest_list.dart';
import 'package:flutter_guests/feature/guests/presentation/pages/guest_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestListPage extends StatelessWidget {
  const GuestListPage({Key? key}) : super(key: key);

  // o GuestsCubit que foi criado e providenciado para o MaterialApp eh recuperado
  // via construtor .value e executa a funcao de buscar os contatos,
  // ou seja, novas instancias nao usam o .value, instancias existentes sim
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GuestsCubit>(context)..getGuests(),
      child: const DocumentosView(),
    );
  }
}

class DocumentosView extends StatelessWidget {
  const DocumentosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guests'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.clear_all),
        //     onPressed: () {
        //       // excluir todas as notas
        //       showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) => AlertDialog(
        //           title: const Text('Excluir Todas as Notas'),
        //           content: const Text('Confirmar operação?'),
        //           actions: <Widget>[
        //             TextButton(
        //               onPressed: () => Navigator.pop(context),
        //               child: const Text('Cancelar'),
        //             ),
        //             TextButton(
        //               onPressed: () {
        //                 context.read<GuestsCubit>().deleteAllGuests();
        //                 Navigator.pop(context);
        //                 ScaffoldMessenger.of(context)
        //                   ..hideCurrentSnackBar()
        //                   ..showSnackBar(const SnackBar(
        //                     content: Text('Notas excluídas com sucesso'),
        //                   ));
        //               },
        //               child: const Text('OK'),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: const _Content(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // como o FAB cria uma nota nova, a nota nao eh parametro recebido
          // na tela de edicao
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const GuestEditPage(guest: null)),
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GuestsCubit>().state;
    // a descricao dos estados esta no arquivo guests_state
    // os estados nao tratados aqui sao utilizados na tela de edicao da nota
    // print('guestlist ' + state.toString());
    if (state is GuestsInitial) {
      return const SizedBox();
    } else if (state is GuestsLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is GuestsLoaded) {
      //a mensagem abaixo aparece se a lista de notas estiver vazia
      if (state.guests?.isEmpty ?? true) {
        return const Center(
          child:
              Text('Não há convidados. Clique no botão abaixo para cadastrar.'),
        );
      } else {
        return _GuestsList(state.guests);
      }
    } else {
      return const Center(
        child: Text('Erro ao recuperar notas.'),
      );
    }
  }
}

class _GuestsList extends StatelessWidget {
  const _GuestsList(this.guests, {Key? key}) : super(key: key);
  final List<Guest>? guests;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final guest in guests!) ...[
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(guest.Name),
              subtitle: Text(
                guest.Phone,
              ),
              trailing: Wrap(children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          // a nota existente eh enviada como parametro para a
                          // tela de edicao preencher os campos automaticamente
                          builder: (context) => GuestEditPage(guest: guest)),
                    );
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // excluir nota atraves do id
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Excluir Nota'),
                          content: const Text('Confirmar operação?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<GuestsCubit>()
                                    .deleteGuest(guest.GuestId);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                    content: Text('Nota excluída com sucesso'),
                                  ));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }),
              ]),
            ),
          ),
          // const Divider(
          //   height: 2,
          // ),
        ],
      ],
    );
  }
}
