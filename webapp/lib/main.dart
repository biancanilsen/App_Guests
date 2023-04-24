import 'package:flutter_guests/feature/guests/domain/cubits/guests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/guests/data/services/grpc_service.dart';
import 'feature/guests/presentation/pages/guest_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // O repositorio de dados é instanciado antes do app apresentar a lista de
  // notas, essa instancia é dependencia do GuestsCubit que é responsavel pelas
  // regras de negocio do aplicativo
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ServiceClient.instance,
      child: BlocProvider(
        create: (context) =>
            //GuestsCubit é o que vai lidar com a interação entre a tela e o backend, tendo as regas
            GuestsCubit(serviceClient: ServiceClient.instance),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const GuestListPage(),
        ),
      ),
    );
  }
}
