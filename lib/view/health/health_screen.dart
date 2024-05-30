import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:your_project_name/cubit/news_cubit.dart';
import 'package:your_project_name/cubit/news_state.dart';
import 'package:your_project_name/view/widget/item_builder.dart';

import '../../core/helper/spacing.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final FlutterNetworkConnectivity _flutterNetworkConnectivity =
  FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 3),
  );

  bool? _isInternetAvailableOnCall;

  bool? _isInternetAvailableStreamStatus;

  StreamSubscription<bool>? _networkConnectionStream;

  @override
  void initState() {
    super.initState();

    _flutterNetworkConnectivity.getInternetAvailabilityStream().listen((event) {
      _isInternetAvailableStreamStatus = event;
      setState(() {});
    });

    init();
  }

  @override
  void dispose() async {
    _networkConnectionStream?.cancel();
    _flutterNetworkConnectivity.unregisterAvailabilityListener();

    super.dispose();
  }

  void init() async {
    await _flutterNetworkConnectivity.registerAvailabilityListener();
  }

  Future<void> _checkInternetAvailability() async {
    try {
      _isInternetAvailableOnCall =
      await _flutterNetworkConnectivity.isInternetConnectionAvailable();
    } on PlatformException {
      _isInternetAvailableOnCall = null;
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List list = NewsCubit.get(context).health;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HealthLoadingNews) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HealthErrorNews) {
          return Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 32,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.08,
                        ),
                      ])));
        }
        return _isInternetAvailableStreamStatus == null
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        )
            : _isInternetAvailableStreamStatus!
            ? ListView.separated(
          itemBuilder: (context, index) =>
              ItemBuilder(category: "Health", list: list[index]),
          separatorBuilder: (context, index) => verticalSpacing(10),
          itemCount: list.length,
        )
            : Center(
          child: Text(
            "🌐 Check your internet and try latter 🔄",
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.teal,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
