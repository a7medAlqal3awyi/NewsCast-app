import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:your_project_name/core/helper/spacing.dart';
import 'package:your_project_name/cubit/news_cubit.dart';
import 'package:your_project_name/cubit/news_state.dart';

import '../widget/item_builder.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({super.key});

  @override
  State<TechScreen> createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
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
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).tech;

        return _isInternetAvailableStreamStatus == null
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        )
            : _isInternetAvailableStreamStatus!
            ? ListView.separated(
          itemBuilder: (context, index) =>
              ItemBuilder(category: "Technology", list: list[index]),
          separatorBuilder: (context, index) => verticalSpacing(10),
          itemCount: list.length,
        )
            : Center(
          child: Text(
            "🌐 Check your internet and try latter 🔄",
            style: const TextStyle(
              fontSize: 17.0,              color: Colors.teal,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}