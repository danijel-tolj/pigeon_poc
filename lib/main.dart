import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:pigeon_poc/cubit/heart_rate/heart_rate_cubit.dart';
import 'package:pigeon_poc/cubit/heart_rate_broadcast/heart_rate_broadcast_cubit.dart';
import 'package:pigeon_poc/generated/pigeons.g.dart';
import 'package:pigeon_poc/handler/health_data_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pigeon Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pigeon Demo Home Page'),
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
  late HealthDataHandler _handler;
  @override
  void initState() {
    _handler = HealthDataHandler(hostApi: HealthDataHostApi());
    super.initState();
  }

  Either<PlatformException, List<TimeSeriesData>>? result;

  Future fetchHeartRate() async {
    final response = await _handler.getHeartRate();

    setState(() {
      result = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HealthDataHandler>(
      create: (context) => HealthDataHandler(hostApi: HealthDataHostApi()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HeartRateCubit(
              context.read<HealthDataHandler>(),
            ),
          ),
          BlocProvider(
            create: (context) => HeartRateBroadcastCubit(
              context.read<HealthDataHandler>(),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FirmwareBroadcast(),
                  _HeartRateBroadcast(),
                  Expanded(child: _HeartRateData()),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<HeartRateCubit>().fetch(),
              tooltip: 'Fetch',
              child: const Icon(Icons.refresh),
            ),
          );
        }),
      ),
    );
  }
}

class _FirmwareBroadcast extends StatelessWidget {
  const _FirmwareBroadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<HealthDataHandler>().firmwareStatusStream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const SizedBox();
          } else {
            return Text(
              '${data.status.name} - ${data.value}',
              textAlign: TextAlign.center,
            );
          }
        });
  }
}

class _HeartRateData extends StatelessWidget {
  const _HeartRateData();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeartRateCubit, HeartRateState>(builder: (context, state) {
      return switch (state) {
        HeartRateInitial() => const SizedBox(),
        HeartRateLoading() => const CircularProgressIndicator(),
        HeartRateData() => ListView.builder(
            itemBuilder: (context, index) {
              return Text(
                state.records[index].value.toString(),
                textAlign: TextAlign.center,
              );
            },
            itemCount: state.records.length,
          ),
        HeartRateError() => Text(state.error)
      };
    });
  }
}

class _HeartRateBroadcast extends StatelessWidget {
  const _HeartRateBroadcast();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeartRateBroadcastCubit, HeartRateBroadcastState>(
      builder: (context, state) {
        if (state is! HeartRateBroadcastData) {
          return const SizedBox();
        } else {
          return Text(
            state.record.value.toString(),
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
