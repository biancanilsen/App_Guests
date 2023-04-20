import 'package:flutter_guests/feature/guests/domain/cubits/guests_cubit.dart';
import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';
import 'package:flutter_guests/feature/guests/presentation/pages/guest_list.dart';
import 'package:flutter_guests/feature/guests/presentation/pages/guest_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class GuestListPage extends StatelessWidget {
  const GuestListPage({Key? key}) : super(key: key);

  // O GuestsCubit que foi criado e providenciado para o MaterialApp e recuperado
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Guests'),
        backgroundColor: const Color(0xFF256070),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              "images/guestsContainer.png",
            ),
          ),
          const Expanded(child: _Content()),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GuestEditPage(guest: null)),
              );
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment(0.7, -0.5),
                  end: Alignment(0.6, 0.5),
                  colors: [
                    Color(0xFF256070),
                    Color.fromARGB(255, 117, 164, 177),
                  ],
                ),
              ),
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF256070),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
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
        child: Text('Erro ao recuperar convidados.'),
      );
    }
  }
}

class _GuestsList extends StatelessWidget {
  const _GuestsList(this.guests, {Key? key}) : super(key: key);
  final List<Guest>? guests;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: ListView(
        children: [
          for (final guest in guests!) ...[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.5, left: 10.5, right: 10.5),
              child: ListTile(
                // hoverColor: Colors.red,
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey, width: 1),
                ),
                title: Text(guest.name),
                subtitle: Text(
                  guest.phone,
                ),
                trailing: Wrap(children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {
                      openWhatsApp() async {
                        var whatsappUrl =
                            "whatsapp://send?phone=+5586994324465&text=Olá,tudo bem ?";

                        if (await canLaunch(whatsappUrl)) {
                          await launch(whatsappUrl);
                        } else {
                          throw 'Could not launch $whatsappUrl';
                        }
                      }
                    },
                  ),
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
                            title: const Text('Excluir convidado'),
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
                                      .deleteGuest(guest.id);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(const SnackBar(
                                      content: Text(
                                          'Convidado excluído com sucesso'),
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
      ),
    );
  }
}
