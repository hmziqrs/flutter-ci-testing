import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'dart:convert' as jc;

class JsonEditorPage extends StatefulWidget {
  const JsonEditorPage({super.key});

  @override
  State<JsonEditorPage> createState() => _JsonEditorPageState();
}

class _JsonEditorPageState extends State<JsonEditorPage> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();

    // Initialize with some sample JSON
    const initialText = '''
{
  "name": "John Doe",
  "age": 30,
  "address": {
    "street": "123 Main St",
    "city": "New York",
    "country": "USA"
  },
  "contacts": [
    {
      "type": "email",
      "value": "john@example.com"
    },
    {
      "type": "phone",
      "value": "+1234567890"
    }
  ],
  "isActive": true
}''';

    _codeController = CodeController(
      text: initialText,
      language: json,
      patternMap: {
        // Optional: Add custom pattern matching
        // RegExp(r'"([^"]*)"'): const TextStyle(color: Colors.green),
        // RegExp(r'\b(?:true|false|null)\b'):
        //     const TextStyle(color: Colors.purple),
        // RegExp(r'\b\d+\.?\d*\b'): const TextStyle(color: Colors.blue),
      },
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Editor'),
        actions: [
          // Format JSON button
          IconButton(
            icon: const Icon(Icons.format_align_left),
            onPressed: _formatCode,
          ),
          // Copy button
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              // Get the full text including any folded sections
              final text = _codeController.fullText;
              // Copy to clipboard
              // You can use Flutter's Clipboard class here
            },
          ),
        ],
      ),
      body: CodeTheme(
        data: CodeThemeData(styles: monokaiSublimeTheme),
        child: SingleChildScrollView(
          child: CodeField(
            controller: _codeController,
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            // gutterStyle: GutterStyle(
            //   showLineNumbers: true,
            //   showFoldingHandles: true,
            //   textStyle: const TextStyle(color: Colors.white),
            // ),
            background: Colors.black,
          ),
        ),
      ),
    );
  }

  void _formatCode() {
    try {
      // Get the current text
      String currentText = _codeController.text;

      // Parse and format JSON
      final dynamic parsedJson = jc.json.decode(currentText);
      final String formattedJson =
          const jc.JsonEncoder.withIndent('  ').convert(parsedJson);

      // Update the controller with formatted text
      _codeController.text = formattedJson;
    } catch (e) {
      // Show error if JSON is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid JSON: ${e.toString()}')),
      );
    }
  }
}
