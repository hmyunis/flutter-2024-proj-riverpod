
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/main.dart' as app;



void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Signup Page Integration Tests", () {
    testWidgets("Successful Signup", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "username");
      await tester.enterText(email_field, 'we@gmail.com');
      await tester.enterText(password_field, 'password');
      await tester.enterText(confirm_password_field, 'password');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Browse"), findsOneWidget);

      final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();

    });

    testWidgets("Invalid Email", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "testuear");
      await tester.enterText(email_field, 'testInvalidEmail');
      await tester.enterText(password_field, 'TestPassword123');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Email address is not in the correct format."), findsOneWidget);

      final login_button = find.byKey(const Key("login_field"));

      await tester.pumpAndSettle();
      await tester.tap(login_button);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));

    });

    testWidgets("Password lessthan 8 characters ", (tester) async {
      
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "testuear");
      await tester.enterText(email_field, 'testemail@gmail.com');
      await tester.enterText(password_field, 'short');
      await tester.enterText(confirm_password_field, 'short');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Password must be at least 8 characters."), findsOneWidget);

      final login_button = find.byKey(const Key("login_field"));

      await tester.pumpAndSettle();
      await tester.tap(login_button);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    });


   });

   group("Login page Integration Tests", () { 
      testWidgets("Successful Login", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        expect(find.text("Browse"), findsOneWidget);

        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });
      testWidgets("Invalid Login credentials", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password123");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        expect(find.text("Exception: Invalid credentials: Login failed"), findsOneWidget);

        final log_out_button = find.byKey(const Key("logout"));
      await tester.pumpAndSettle();
      });
      testWidgets("Empty fields", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        expect(find.text("Please fill in all of the fields."), findsOneWidget);
      });
   });
   group("Profile related tests", () { 
      testWidgets("profile name displayed correctly", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        final profile_button = find.byKey(const Key("profile_icon"));

        await tester.tap(profile_button);
        await tester.pumpAndSettle();

        expect(find.text("username"), findsAtLeast(2));

        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });

      testWidgets("Incorrect profile update partial update!", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        final profile_button = find.byKey(const Key("profile_icon"));
        final update_button = find.byKey(const Key("update"));
        final confirm_button = find.byKey(const Key("confirm"));

        final update_username = find.byKey(const Key("username_field"));

        await tester.tap(profile_button);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        await tester.enterText(update_username, "newUserName");
        await tester.pumpAndSettle();
        //print("I have reached here");
        await tester.tap(update_button);
        await tester.pumpAndSettle();

        await tester.tap(confirm_button);
        await tester.pumpAndSettle();



        expect(find.text("Please fill in all three fields."), findsOneWidget);

        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });

      testWidgets("Incorrect Profile update wrong email format.", (tester) async {
        
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        final profile_button = find.byKey(const Key("profile_icon"));
        final update_button = find.byKey(const Key("update"));
        final confirm_button = find.byKey(const Key("confirm"));

        final update_username = find.byKey(const Key("username_field"));
        final update_email = find.byKey(const Key("email"));
        final update_password = find.byKey(const Key("newPassword"));

        await tester.tap(profile_button);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        await tester.enterText(update_username, "new_username");
        await tester.pumpAndSettle();
        await tester.enterText(update_email, "new_email");
        await tester.pumpAndSettle();
        await tester.enterText(update_password, "new_password");
        await tester.pumpAndSettle();
        //print("I have reached here");
        await tester.tap(update_button);
        await tester.pumpAndSettle();

        await tester.tap(confirm_button);
        await tester.pumpAndSettle();



        expect(find.text("Email address is not in the correct format."), findsOneWidget);


        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });

      testWidgets("Profile updated successfully.", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        final profile_button = find.byKey(const Key("profile_icon"));
        final update_button = find.byKey(const Key("update"));
        final confirm_button = find.byKey(const Key("confirm"));

        final update_username = find.byKey(const Key("username_field"));
        final update_email = find.byKey(const Key("email"));
        final update_password = find.byKey(const Key("newPassword"));

        await tester.tap(profile_button);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        await tester.enterText(update_username, "new_username");
        await tester.pumpAndSettle();
        await tester.enterText(update_email, "new_email@gmail.com");
        await tester.pumpAndSettle();
        await tester.enterText(update_password, "new_password");
        await tester.pumpAndSettle();
        //print("I have reached here");
        await tester.tap(update_button);
        await tester.pumpAndSettle();

        await tester.tap(confirm_button);
        await tester.pumpAndSettle();



        expect(find.text("Account updated successfully."), findsOneWidget);

        await tester.enterText(update_username, "username");
        await tester.pumpAndSettle();
        await tester.enterText(update_email, "we@gmail.com");
        await tester.pumpAndSettle();
        await tester.enterText(update_password, "password");
        await tester.pumpAndSettle();
        //print("I have reached here");
        await tester.tap(update_button);
        await tester.pumpAndSettle();

        await tester.tap(confirm_button);
        await tester.pumpAndSettle();


        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });
   
   });
   
  testWidgets("profile Termination", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        final profile_button = find.byKey(const Key("profile_icon"));

        await tester.tap(profile_button);
        await tester.pumpAndSettle();
        final terminate_confirm = find.byKey(const Key("terminated"));
        final terminate_button = find.byKey(const Key("terminate"));

        await tester.tap(terminate_button);
        await tester.pumpAndSettle();

        await tester.tap(terminate_confirm);
        await tester.pumpAndSettle();

        expect(find.text("Login"), findsOneWidget);
        await tester.pumpAndSettle();
      });  
}