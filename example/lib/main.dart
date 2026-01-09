import 'package:flutter/material.dart';
import 'package:best_form_validator/best_form_validator.dart';

/// Comprehensive example demonstrating all validators in best_form_validator package
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // IMPORTANT: Load phone regex patterns before using phone validation
  await Validators.loadPhoneRegex();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Form Validator Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Form Validator Examples'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose an Example',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildExampleCard(
            context,
            title: 'Registration Form',
            description: 'Complete registration form with all validators',
            icon: Icons.person_add,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const RegistrationFormExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Login Form',
            description: 'Simple login form with email and password',
            icon: Icons.login,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginFormExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Individual Validators',
            description: 'Test each validator separately',
            icon: Icons.checklist,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const IndividualValidatorsExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Programmatic Validation',
            description: 'Use validators in code without forms',
            icon: Icons.code,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ProgrammaticValidationExample()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

/// Example 1: Complete Registration Form
class RegistrationFormExample extends StatefulWidget {
  const RegistrationFormExample({super.key});

  @override
  State<RegistrationFormExample> createState() =>
      _RegistrationFormExampleState();
}

class _RegistrationFormExampleState extends State<RegistrationFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();

  String _selectedCountry = 'US';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<Map<String, String>> _countries = [
    {'code': 'US', 'name': 'United States'},
    {'code': 'UK', 'name': 'United Kingdom'},
    {'code': 'PK', 'name': 'Pakistan'},
    {'code': 'IN', 'name': 'India'},
    {'code': 'CA', 'name': 'Canada'},
    {'code': 'AU', 'name': 'Australia'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Registration Successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in the details below to register',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'John Doe',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateName(
                value,
                requiredError: 'Please enter your name',
                invalidError: 'Name can only contain letters and spaces',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'john.doe@example.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateEmail(
                value,
                requiredError: 'Please enter your email',
                invalidError: 'Please enter a valid email address',
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Country Selector
            DropdownButtonFormField<String>(
              initialValue: _selectedCountry,
              decoration: const InputDecoration(
                labelText: 'Country',
                prefixIcon: Icon(Icons.flag),
                border: OutlineInputBorder(),
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country['code'],
                  child: Text('${country['name']} (${country['code']})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Phone Field
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: _selectedCountry == 'US' ? '+12025551234' : '+44...',
                prefixIcon: const Icon(Icons.phone),
                border: const OutlineInputBorder(),
                helperText: 'Include country code (e.g., +1 for US)',
              ),
              validator: (value) =>
                  Validators.validatePhone(value, _selectedCountry),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                helperText:
                    'Min 8 chars: uppercase, lowercase, number, special char',
                helperMaxLines: 2,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              obscureText: _obscurePassword,
              validator: (value) => Validators.validatePassword(
                value,
                checkLength: true,
                minLength: 8,
                checkNumberAndLetter: true,
                checkSpecialCharacter: true,
                checkLowerCase: true,
                checkUpperCase: true,
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              obscureText: _obscureConfirmPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Birth Date Field
            TextFormField(
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: 'Birth Date',
                hintText: 'yyyy-MM-dd (e.g., 1990-01-15)',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateAge(
                value,
                18,
                requiredError: 'Please enter your birth date',
                invalidError: 'You must be at least 18 years old to register',
              ),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Register', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example 2: Simple Login Form
class LoginFormExample extends StatefulWidget {
  const LoginFormExample({super.key});

  @override
  State<LoginFormExample> createState() => _LoginFormExampleState();
}

class _LoginFormExampleState extends State<LoginFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_person, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Login to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) => Validators.validatePassword(value),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Example 3: Individual Validators Testing
class IndividualValidatorsExample extends StatefulWidget {
  const IndividualValidatorsExample({super.key});

  @override
  State<IndividualValidatorsExample> createState() =>
      _IndividualValidatorsExampleState();
}

class _IndividualValidatorsExampleState
    extends State<IndividualValidatorsExample> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Individual Validators')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildValidatorSection(
            'Email Validator',
            Icons.email,
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Test Email',
                hintText: 'user@example.com',
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateEmail(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          _buildValidatorSection(
            'Phone Validator',
            Icons.phone,
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Test Phone (US)',
                hintText: '+12025551234',
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validatePhone(value, 'US'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          _buildValidatorSection(
            'Password Validator',
            Icons.lock,
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Test Password',
                border: OutlineInputBorder(),
                helperText: 'Try: MyP@ssw0rd',
              ),
              validator: (value) => Validators.validatePassword(
                value,
                checkLength: true,
                minLength: 8,
                checkNumberAndLetter: true,
                checkSpecialCharacter: true,
                checkLowerCase: true,
                checkUpperCase: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          _buildValidatorSection(
            'Name Validator',
            Icons.person,
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Test Name',
                hintText: 'John Doe',
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateName(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          _buildValidatorSection(
            'Age Validator (18+)',
            Icons.calendar_today,
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Test Birth Date',
                hintText: '2000-01-15',
                border: OutlineInputBorder(),
              ),
              validator: (value) => Validators.validateAge(value, 18),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidatorSection(String title, IconData icon, Widget field) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            field,
          ],
        ),
      ),
    );
  }
}

/// Example 4: Programmatic Validation
class ProgrammaticValidationExample extends StatefulWidget {
  const ProgrammaticValidationExample({super.key});

  @override
  State<ProgrammaticValidationExample> createState() =>
      _ProgrammaticValidationExampleState();
}

class _ProgrammaticValidationExampleState
    extends State<ProgrammaticValidationExample> {
  final List<Map<String, dynamic>> _testCases = [];

  @override
  void initState() {
    super.initState();
    _runTests();
  }

  void _runTests() {
    _testCases.clear();

    // Email tests
    _testCases.add(_test('Email', 'user@example.com',
        Validators.validateEmail('user@example.com')));
    _testCases.add(_test(
        'Email', 'invalid-email', Validators.validateEmail('invalid-email')));

    // Phone tests
    _testCases.add(_test('Phone (US)', '+12025551234',
        Validators.validatePhone('+12025551234', 'US')));
    _testCases
        .add(_test('Phone (US)', '123', Validators.validatePhone('123', 'US')));

    // Password tests
    _testCases.add(_test(
        'Password',
        'MyP@ssw0rd',
        Validators.validatePassword('MyP@ssw0rd',
            checkLength: true,
            minLength: 8,
            checkNumberAndLetter: true,
            checkSpecialCharacter: true,
            checkLowerCase: true,
            checkUpperCase: true)));
    _testCases.add(_test('Password', 'weak',
        Validators.validatePassword('weak', checkLength: true, minLength: 8)));

    // Name tests
    _testCases
        .add(_test('Name', 'John Doe', Validators.validateName('John Doe')));
    _testCases
        .add(_test('Name', 'John123', Validators.validateName('John123')));

    // Age tests
    _testCases.add(_test(
        'Age (18+)', '1990-01-15', Validators.validateAge('1990-01-15', 18)));
    _testCases.add(_test(
        'Age (18+)', '2010-01-15', Validators.validateAge('2010-01-15', 18)));

    setState(() {});
  }

  Map<String, dynamic> _test(String validator, String input, String? result) {
    return {
      'validator': validator,
      'input': input,
      'result': result,
      'isValid': result == null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programmatic Validation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Validation Test Results',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Testing validators programmatically without forms',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ..._testCases.map((test) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    test['isValid'] ? Icons.check_circle : Icons.error,
                    color: test['isValid'] ? Colors.green : Colors.red,
                    size: 32,
                  ),
                  title: Text('${test['validator']}: "${test['input']}"'),
                  subtitle: Text(
                    test['isValid'] ? '✅ Valid' : '❌ ${test['result']}',
                    style: TextStyle(
                      color: test['isValid'] ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _runTests,
            icon: const Icon(Icons.refresh),
            label: const Text('Run Tests Again'),
          ),
        ],
      ),
    );
  }
}
