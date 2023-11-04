import 'package:clean_architecture/2_application/core/services/theme_service.dart';
import 'package:clean_architecture/2_application/pages/advice/bloc/adviser_bloc.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';
import 'widgets/advice_field.dart';
import 'widgets/custom_widget.dart';
import 'widgets/error_message.dart';

class AdviserPageWrapperProvider extends StatelessWidget {
  const AdviserPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdviserCubit>(
      create: (context) => serviceLocator<AdviserCubit>(),
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
                child: BlocBuilder<AdviserCubit, AdviserCubitState>(
                  builder: (context, state) {
                    if (state is AdviserInitial) {
                      return Text(
                        "Your Advice is waiting",
                        style: themeData.textTheme.headlineSmall,
                      );
                    } else if (state is AdviserCubitStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviserCubitStateLoaded) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdviserCubitStateError) {
                      return ErrorMessage(message: state.errorMessage);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onTap: () {
                    BlocProvider.of<AdviserCubit>(context).adviceRequested();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
