import 'package:clean_architecture/2_application/core/services/theme_service.dart';
import 'package:clean_architecture/2_application/pages/advice/bloc/adviser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'widgets/advice_field.dart';
import 'widgets/custom_widget.dart';
import 'widgets/error_message.dart';

class AdviserPageWrapperProvider extends StatelessWidget {
  const AdviserPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdviserBloc>(
      create: (context) => AdviserBloc(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primary,
      appBar: AppBar(
        title: Text("Adviser", style: themeData.textTheme.headlineLarge),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviserBloc, AdviserState>(
                  builder: (context, state) {
                    if (state is AdviserInitial) {
                      return Text(
                        "Your Advice is waiting",
                        style: themeData.textTheme.headlineSmall,
                      );
                    } else if (state is AdviserStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviserStateLoaded) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdviserStateError) {
                      return ErrorMessage(message: state.errorMessage);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 200, child: Center(child: CustomButton())),
          ],
        ),
      ),
    );
  }
}
