import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_state.dart';
import 'package:app_edu/common/theme/theme_color.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;

  const LoadingContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          child ?? SizedBox(),
          BlocBuilder<LoadingBloc, LoadingState>(
            bloc: injector<LoadingBloc>(),
            builder: (context, state) {
              return Visibility(
                visible: state.loading ?? true,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: AppColors.greenText,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
