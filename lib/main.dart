import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/ModelProvider.dart';

import 'amplify_outputs.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureAmplify();
    runApp(const ToDoApp());
  } on AmplifyException catch (e) {
    runApp(Text("Error configuring Amplify: ${e.message}"));
  }
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins(
      
      [AmplifyAuthCognito(),

      AmplifyAPI(
        options: APIPluginOptions(
          modelProvider: ModelProvider.instance
        )
      )
      
      ]
      
      
      );
    await Amplify.configure(amplifyConfig);

    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignOutButton(),
                Text('TODO Application'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}