import 'package:flutter/material.dart';
import 'package:localdb/src/modules/common/domain/interfaces/warehouse_repository.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';
import 'package:localdb/src/modules/common/domain/warehouse_fromto.dart';

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
    const fromTo = WareHouseFromToLinkEntity(1, 1);
    const fromTo1 = WareHouseFromToLinkEntity(1, 2);
    const fromTo2 = WareHouseFromToLinkEntity(1, 3);
    const fromTo3 = WareHouseFromToLinkEntity(1, 4);
    const fromTo4 = WareHouseFromToLinkEntity(3, 5);
    await repo.addFromTo(fromTo);
    await repo.addFromTo(fromTo1);
    await repo.addFromTo(fromTo2);
    await repo.addFromTo(fromTo3);
    await repo.addFromTo(fromTo4);

    final data = await repo.getFromTo();
    for (final d in data) {
      print('from ======> found ${d.name}');
      final tos = await repo.getToByFromId(d.id);
      final toNames = tos.map((e) => e.name);
      print(toNames.join('|'));
    }
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
