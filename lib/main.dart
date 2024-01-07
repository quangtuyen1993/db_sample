import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdb/src/modules/common/application/wh_cubit.dart';
import 'package:localdb/src/modules/common/application/wh_worker_delegate.dart';
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
    final whs = <Warehouse>[];
    for (var i = 0; i <= 100; i++) {
      final object = Warehouse.create(id: i, name: 'wh $i');
      whs.add(object);
    }

    await repo.addAll(whs);

    for (var i = 0; i <= 100; i++) {
      final object = WareHouseFromToLinkEntity(1, i + 1);
      await repo.addFromTo(object);
    }

    final data = await repo.getFromSource();
    for (final d in data) {
      print('from ======> found ${d.name}');
      final tos = await repo.getToSourceByFromId(d.id);
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
        body: BlocProvider<WareHouseCubit>(
          create: (_) => getIt<WareHouseCubit>(
              param1: getIt<WareHouseFromToDelegateImpl>()),
          child: BlocBuilder<WareHouseCubit, WareHouseState>(
              builder: (context, state) {
            return Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonExample(
                      source: state.sourceFrom,
                      value: state.from,
                      valueChanged: (t) =>
                          context.read<WareHouseCubit>().selectedWhFrom(t),
                      itemBuilder: (context, v) {
                        return Text(v.name);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonExample(
                      source: state.sourceTo,
                      value: state.to,
                      valueChanged: (t) =>
                          context.read<WareHouseCubit>().selectedWhTo(t),
                      itemBuilder: (context, v) {
                        return Text(
                          v.name,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}

typedef ItemBuilder<T> = Widget Function(BuildContext context, T t);

class DropdownButtonExample<T> extends StatelessWidget {
  const DropdownButtonExample({
    super.key,
    required this.source,
    required this.valueChanged,
    required this.itemBuilder,
    this.value,
  });

  final List<T> source;
  final T? value;
  final ValueChanged<T?> valueChanged;
  final ItemBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      alignment: Alignment.bottomLeft,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: source.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: itemBuilder.call(context, value),
        );
      }).toList(),
      onChanged: source.isEmpty ? null : valueChanged.call,
    );
  }
}

extension ListX<T> on List<T?> {
  List<T> filterNotNull() {
    return whereType<T>().toList();
  }
}
