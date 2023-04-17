// import 'package:flutter_guests/feature/guests/data/models/guest_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseProvider {
//   static final DatabaseProvider instance = DatabaseProvider._init();
//   static Database? _db;

//   DatabaseProvider._init();

//   // Retorna uma instancia do banco de dados
//   Future<Database> get db async {
//     if (_db != null) return _db!;
//     _db = await _useDatabase('guests.db');
//     return _db!;
//   }

//   Future<Database> _useDatabase(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     // Descomentar as duas linhas abaixo para apagar a base de dados toda vez
//     // que o app iniciar

//     // String path = join(dbPath, 'guests.db');
//     // await deleteDatabase(path);

//     // Retorna o banco de dados aberto
//     return await openDatabase(
//       join(dbPath, 'guests.db'),
//       onCreate: (db, version) {
//         return db.execute(
//             'CREATE TABLE guests (id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
//       },
//       version: 1,
//     );
//   }

//   // Buscar notas
//   Future<List<Guest>> searchGuests() async {
//     final db = await instance.db;
//     final result = await db.rawQuery('SELECT * FROM guests ORDER BY id');
//     // print(result);
//     return result.map((json) => Guest.fromJson(json)).toList();
//   }

//   //Criar nova nota
//   Future<Guest> save(Guest guest) async {
//     final db = await instance.db;
//     final id = await db.rawInsert(
//         'INSERT INTO guests (title, content) VALUES (?,?)',
//         [guest.title, guest.content]);

//     // print('Nota de id $id criada com sucesso.');
//     return guest.copy(id: id);
//   }

//   //Atualizar nota
//   Future<Guest> update(Guest guest) async {
//     final db = await instance.db;
//     await db.rawUpdate('UPDATE guests SET title = ?, content = ? WHERE id = ?',
//         [guest.title, guest.content, guest.id]);

//     // print('Nota de id ${guest.id} atualizada com sucesso.');
//     return guest;
//   }

//   //Excluir notas
//   Future<int> deleteAll() async {
//     final db = await instance.db;
//     final result = await db.rawDelete('DELETE FROM guests');
//     // o result é a quantidade de linhas excluídas
//     // print('${result} notas excluídas com sucesso.');
//     return result;
//   }

//   //Excluir nota
//   Future<int> delete(int guestId) async {
//     final db = await instance.db;
//     final result =
//         await db.rawDelete('DELETE FROM guests WHERE id = ?', [guestId]);
//     // print('Nota de id ${guestId} excluída com sucesso.');
//     // o result é a quantidade de linhas excluídas
//     return result;
//   }

//   //Fechar conexao com o banco de dados, funcao nao usada nesse app
//   Future close() async {
//     final db = await instance.db;
//     db.close();
//   }
// }
