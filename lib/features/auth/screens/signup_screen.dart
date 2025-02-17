import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import '../domain/models/user_type.dart';

class SignupScreen extends ConsumerWidget {
  final String userType;

  const SignupScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create ${userType == UserType.professional.name ? 'Professional' : 'Homeowner'} Account',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                // In development, just sign in
                await ref.read(authProvider.notifier).signIn();
              },
              child: const Text('Create Account'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
