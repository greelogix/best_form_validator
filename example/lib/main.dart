import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:best_form_validator/best_form_validator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validation Tester',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('ar'),
        Locale('ur'),
        Locale('hi'),
        Locale('zh'),
        Locale('pt'),
        Locale('ru'),
        Locale('it'),
        Locale('tr'),
        Locale('ja'),
        Locale('ko'),
        Locale('id'),
        Locale('ms'),
        Locale('th'),
        Locale('vi'),
        Locale('nl'),
        Locale('sv'),
        Locale('no'),
        Locale('fi'),
        Locale('da'),
        Locale('el'),
        Locale('fa'),
      ],
      builder: (context, child) {
        // Update the static validator locale whenever the app locale changes
        final locale = Localizations.localeOf(context);
        Validators.setLocale(locale);
        return child!;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: const ValidationShowcasePage(),
    );
  }
}

class ValidationShowcasePage extends StatefulWidget {
  const ValidationShowcasePage({super.key});

  @override
  State<ValidationShowcasePage> createState() => _ValidationShowcasePageState();
}

class _ValidationShowcasePageState extends State<ValidationShowcasePage> {
  // Current selection
  String _selectedCase = 'Email Validation';

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Input Controllers
  final _textController = TextEditingController();

  // Specific State Variables
  String _selectedCountry = 'US';
  bool _obscureText = true;

  // Validation Result State
  String? _successMessage;

  // Available Cases
  final List<String> _cases = [
    'Email Validation',
    'Phone Validation',
    'Password Validation',
    'Name Validation',
    'Age Validation',
    'Date Validation',
    'Time Validation',
  ];

  final List<Map<String, String>> _countries = [
    {'code': 'US', 'name': 'USA (+1)'},
    {'code': 'UK', 'name': 'UK (+44)'},
    {'code': 'PK', 'name': 'Pakistan (+92)'},
    {'code': 'IN', 'name': 'India (+91)'},
    {'code': 'CA', 'name': 'Canada (+1)'},
    {'code': 'AU', 'name': 'Australia (+61)'},
    {'code': 'AE', 'name': 'UAE (+971)'},
  ];

  final Map<String, String> _languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'ar': 'Arabic',
    'ur': 'Urdu',
    'hi': 'Hindi',
    'ru': 'Russian',
  };

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Reset state when case changes
  void _onCaseChanged(String? newValue) {
    if (newValue != null && newValue != _selectedCase) {
      setState(() {
        _selectedCase = newValue;
        _textController.clear();
        _successMessage = null;
        _selectedCountry = 'US';
        _obscureText = true;
        _formKey.currentState?.reset();
      });
    }
  }

  // Run validation
  void _validate() {
    setState(() {
      _successMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        _successMessage = 'Valid! The input passed all checks.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Best Form Validator'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (langCode) {
              MyApp.of(context)?.setLocale(Locale(langCode));
            },
            itemBuilder: (context) => _languages.entries.map((e) {
              return PopupMenuItem(value: e.key, child: Text(e.value));
            }).toList(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Language: ${_languages[currentLocale.languageCode] ?? currentLocale.languageCode}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              const Icon(
                Icons.verified_user_outlined,
                size: 64,
                color: Colors.teal,
              ),
              const SizedBox(height: 24),

              // 1. Selection Dropdown
              Text(
                'Select Validator to Test:',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCase,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.teal,
                    ),
                    items: _cases.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    onChanged: _onCaseChanged,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 2. Dynamic Test Area
              Card(
                elevation: 4,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _selectedCase,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getDescription(_selectedCase),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Render Input Fields based on selection
                        _buildDynamicFields(),

                        const SizedBox(height: 24),

                        // Submit Button
                        ElevatedButton(
                          onPressed: _validate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'VALIDATE CASE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.check_circle_outline),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 3. Result Display
              AnimatedOpacity(
                opacity: _successMessage != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: _successMessage != null
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 12),
                            Text(
                              _successMessage!,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to get description text
  String _getDescription(String caseName) {
    switch (caseName) {
      case 'Email Validation':
        return 'Checks for standard email format requirements.';
      case 'Phone Validation':
        return 'Validates phone numbers against specific country patterns.';
      case 'Password Validation':
        return 'Checks length, special chars, numbers, and letter casing.';
      case 'Name Validation':
        return 'Ensures name contains only letters and appropriate spacing.';
      case 'Age Validation':
        return 'Validates that the age meets a minimum requirement (e.g., 18+).';
      case 'Date Validation':
        return 'Checks if the string is a valid date format.';
      case 'Time Validation':
        return 'Checks if the string is a valid time format.';
      default:
        return '';
    }
  }

  // Builder for dynamic inputs
  Widget _buildDynamicFields() {
    switch (_selectedCase) {
      case 'Email Validation':
        return TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'example@domain.com',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validators.validateEmail(value),
        );

      case 'Phone Validation':
        return Column(
          children: [
            DropdownButtonFormField<String>(
              key: ValueKey(_selectedCountry),
              initialValue: _selectedCountry,
              decoration: const InputDecoration(
                labelText: 'Select Country',
                prefixIcon: Icon(Icons.flag_outlined),
              ),
              items: _countries
                  .map(
                    (c) => DropdownMenuItem(
                      value: c['code'],
                      child: Text(c['name']!),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedCountry = val!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1234567890',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  Validators.validatePhone(value, _selectedCountry),
            ),
          ],
        );

      case 'Password Validation':
        return TextFormField(
          controller: _textController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
            helperText:
                'Requirements: Min 8 chars, Uppercase, Lowercase, Number, Special Char',
            helperMaxLines: 2,
          ),
          validator: (value) => Validators.validatePassword(
            value,
            minLength: 8,
            checkUpperCase: true,
            checkLowerCase: true,
            checkNumberAndLetter: true,
            checkSpecialCharacter: true,
          ),
        );

      case 'Name Validation':
        return TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'John Doe',
            prefixIcon: Icon(Icons.person_outline),
          ),
          keyboardType: TextInputType.name,
          validator: (value) => Validators.validateName(value),
        );

      case 'Age Validation':
        return TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Birth Date',
            hintText: 'yyyy-MM-dd',
            prefixIcon: Icon(Icons.cake_outlined),
            helperText: 'Must be at least 18 years old',
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) => Validators.validateAge(value, 18),
        );

      case 'Date Validation':
        return TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Date',
            hintText: 'yyyy-MM-dd',
            prefixIcon: Icon(Icons.calendar_today_outlined),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) => Validators.validateDate(value),
        );

      case 'Time Validation':
        return TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Time',
            hintText: 'HH:mm:ss',
            prefixIcon: Icon(Icons.access_time_outlined),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) => Validators.validateTime(value),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
