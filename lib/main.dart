import 'package:flutter/material.dart';
import 'presentation/app_routing.dart';

void main() {

  runApp(BraekingBadApp(appRouter: AppRouting(),));
}

class BraekingBadApp extends StatelessWidget {
  final AppRouting appRouter;

  const BraekingBadApp({super.key, required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );

  }
}
