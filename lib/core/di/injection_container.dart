import 'package:get_it/get_it.dart';
import 'package:graduationproject/features/login/presentation/manager/login_cubit.dart';
import 'package:graduationproject/features/register/presentation/manager/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// Bloc
  sl.registerFactory<LoginCubit>(() => LoginCubit());
  sl.registerFactory<RegisterCubit>(() => RegisterCubit());
}

