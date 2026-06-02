import 'package:open_cargo/bindings/auth/login_binding.dart';
import 'package:open_cargo/bindings/auth/register_binding.dart';
import 'package:open_cargo/bindings/auth/reset_password_binding.dart';
import 'package:open_cargo/bindings/public/home/home_binding.dart';
import 'package:open_cargo/bindings/public/users/agencia/agencia_binding.dart';
import 'package:open_cargo/bindings/public/users/transporte/transporte_binding.dart';
import 'package:open_cargo/bindings/utils/tab_binding.dart';
import 'package:open_cargo/middleware/auth_middleware.dart';
import 'package:open_cargo/middleware/role_middleware.dart';
import 'package:open_cargo/utils/tabs/tab_bar.dart';
import 'package:open_cargo/views/auth/login/login_view.dart';
import 'package:open_cargo/views/auth/register/register_view.dart';
import 'package:open_cargo/views/auth/reset_password/reset_password.dart';
import 'package:open_cargo/views/auth/user/agencia/tabs_view.dart';
import 'package:open_cargo/views/auth/user/transporte/transporte_view.dart';
import 'package:open_cargo/views/public/home/home_view.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      middlewares: [AuthMiddleware()], // Verifica si hay sesión activa
    ),
    GetPage(
        name: AppRoutes.register,
        page: () => RegisterView(),
        binding: RegisterBinding()),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [RoleMiddleware()], // Verifica el rol antes de entrar
    ),
    GetPage(
      name: AppRoutes.tabs,
      page: () => const TabBarViewX(),
      binding: TabBinding(),
      middlewares: [RoleMiddleware()],
    ),
    GetPage(
      name: AppRoutes.agencia,
      page: () => TabAgenciaView(),
      binding: AgenciaBinding(),
      middlewares: [RoleMiddleware()],
    ),
    GetPage(
      name: AppRoutes.transporte,
      page: () => TransporteView(),
      binding: TransporteBinding(),
      middlewares: [RoleMiddleware()],
    ),
    GetPage(
      name: AppRoutes.publico,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [RoleMiddleware()],
    ),
  ];
}
