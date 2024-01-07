import 'package:flutter/material.dart';
import 'package:localdb/src/modules/common/domain/interfaces/warehouse_repository.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';
import 'package:localdb/src/modules/common/domain/warehouse_fromto.dart';
import 'package:localdb/src/modules/core/local/dao/wh_dao.dart';

import 'src/modules/core/di/di_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future initDatabase() async {
    final repo = getIt<IWarehouseRepository>();
    final list = [
      Warehouse.create(id: 1, name: 'wh 1'),
      Warehouse.create(id: 2, name: 'wh 2'),
      Warehouse.create(id: 3, name: 'wh 3'),
      Warehouse.create(id: 4, name: 'wh 4'),
      Warehouse.create(id: 5, name: 'wh 5'),
      Warehouse.create(id: 6, name: 'wh 6'),
      Warehouse.create(id: 7, name: 'wh 7'),
      Warehouse.create(id: 8, name: 'wh 8'),
      Warehouse.create(id: 9, name: 'wh 9'),
      Warehouse.create(id: 10, name: 'wh 10'),
      Warehouse.create(id: 11, name: 'wh 11'),
    ];
    await repo.addAll(list);
    const fromTo = WareHouseFromToContractEntity(1, [2, 3, 4, 5, 6]);
    const fromTo2 = WareHouseFromToContractEntity(1, [8, 3, 4, 5, 14]);
    await repo.addFromTo(fromTo);
    await repo.addFromTo(fromTo2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}

extension ListX<T> on List<T?> {
  List<T> filterNotNull() {
    return whereType<T>().toList();
  }
}
