import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ustawienia',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Text(
                'liczba powtórzeń elementu',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: const Icon(Icons.remove),
                    onTap: () {
                      setState(() {
                        if (context.read<Settings>().elementRepetitions > 0) {
                          context.read<Settings>().elementRepetitions--;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '${context.read<Settings>().elementRepetitions}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    child: const Icon(Icons.add),
                    onTap: () {
                      setState(() {
                        if (context.read<Settings>().elementRepetitions < 10) {
                          context.read<Settings>().elementRepetitions++;
                        }
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'liczba dodatkowych powtórzeń elementu po błędzie',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: const Icon(Icons.remove),
                    onTap: () {
                      setState(() {
                        if (context
                                .read<Settings>()
                                .elementRepetitionsAfterError >
                            0) {
                          context
                              .read<Settings>()
                              .elementRepetitionsAfterError--;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '${context.read<Settings>().elementRepetitionsAfterError}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    child: const Icon(Icons.add),
                    onTap: () {
                      setState(() {
                        if (context
                                .read<Settings>()
                                .elementRepetitionsAfterError <
                            5) {
                          context
                              .read<Settings>()
                              .elementRepetitionsAfterError++;
                        }
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
