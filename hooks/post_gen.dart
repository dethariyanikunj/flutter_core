import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  _buildAssets(context);
  _includeEnvAtPubspec(context);
  _buildInAppUpdateFeature(context);
  _buildFirebaseFeature(context);
  _buildNotificationFeature(context);
  _buildDependencies(context);
}

void _buildAssets(HookContext context) {
  _createAssetsDirectory(context);
  _includeAssetsAtPubspec(context);
}

void _createAssetsDirectory(HookContext context) {
  final rootDir = Directory.current;
  // Create 'assets' directory at the root level (same level as 'lib').
  final assetsDir = Directory('${rootDir.path}/assets');
  if (!assetsDir.existsSync()) {
    assetsDir.createSync();
    context.logger.info('Created directory: ${assetsDir.path}');
  } else {
    context.logger.info('Directory already exists: ${assetsDir.path}');
  }

  // Create 'images' directory inside 'assets'.
  final imagesDir = Directory('${assetsDir.path}/images');
  if (!imagesDir.existsSync()) {
    imagesDir.createSync();
    context.logger.info('Created directory: ${imagesDir.path}');
  } else {
    context.logger.info('Directory already exists: ${imagesDir.path}');
  }
}

// Modify pubspec.yaml to include the assets entry.
void _includeAssetsAtPubspec(HookContext context) {
  final rootDir = Directory.current;
  final pubspecFile = File('${rootDir.path}/pubspec.yaml');

  if (pubspecFile.existsSync()) {
    final lines = pubspecFile.readAsLinesSync();

    // Define the assets entry.
    const flutterHeader = 'flutter:';
    const assetsHeader = '  assets:';
    const imagesEntry = '    - assets/images/';

    // Flags to track existing entries.
    bool hasFlutterHeader = false;
    bool hasAssetsHeader = false;
    bool hasImagesEntry = false;

    for (var line in lines) {
      if (line.startsWith(flutterHeader)) {
        hasFlutterHeader = true;
      }
      if (line.startsWith(assetsHeader)) {
        hasAssetsHeader = true;
      }
      if (line.trim() == imagesEntry.trim()) {
        hasImagesEntry = true;
        break;
      }
    }

    if (!hasImagesEntry) {
      if (!hasFlutterHeader) {
        // Add 'flutter' section if missing.
        lines.add('');
        lines.add(flutterHeader);
        lines.add(assetsHeader);
        lines.add(imagesEntry);
      } else if (!hasAssetsHeader) {
        // Add 'assets' section under 'flutter' if missing.
        final flutterIndex =
        lines.indexWhere((line) => line.startsWith(flutterHeader));
        lines.insert(flutterIndex + 1, assetsHeader);
        lines.insert(flutterIndex + 2, imagesEntry);
      } else {
        // Add the images entry under the existing 'assets' section.
        final assetsIndex =
        lines.indexWhere((line) => line.startsWith(assetsHeader));
        lines.insert(assetsIndex + 1, imagesEntry);
      }

      // Write the updated content back to pubspec.yaml.
      pubspecFile.writeAsStringSync(lines.join('\n'));
      context.logger.info(
        'Updated pubspec.yaml to include assets/images entry.',
      );
    } else {
      context.logger.info(
        'pubspec.yaml already includes the assets/images entry.',
      );
    }
  } else {
    context.logger.err('pubspec.yaml file not found.');
  }
}

/// Let this commented as this logics might use in future
/// to add specific content in specific files
/*void _includeEnvConfigurationAtMain(HookContext context) {
  const mainFilePath = 'lib/main.dart';
  const dotenvImport = "import 'package:flutter_dotenv/flutter_dotenv.dart';";
  const dotenvCode = "  await dotenv.load(fileName: '.env');\n"
      "  debugPrint(dotenv.get('API_BASE_URL'));";

  final mainFile = File(mainFilePath);

  // Check if main.dart exists
  if (!mainFile.existsSync()) {
    context.logger.info('Error: $mainFilePath does not exist.');
    return;
  }

  String content = mainFile.readAsStringSync();

  // Add import statement if not already present
  if (!content.contains(dotenvImport)) {
    content = '$dotenvImport\n$content';
  }

  // Check if dotenv code already exists in main.dart to avoid duplication
  if (!content.contains(dotenvCode)) {
    // Modify the main function
    final mainFunctionRegex = RegExp(r'void main\(\) {([\s\S]*?)}');
    final asyncMainFunctionRegex = RegExp(r'void main\(\) async {([\s\S]*?)}');

    if (asyncMainFunctionRegex.hasMatch(content)) {
      // If main() already has async, add dotenv initialization
      content = content.replaceFirstMapped(
        asyncMainFunctionRegex,
            (match) => "void main() async {\n$dotenvCode\n${match.group(1) ?? ''}}",
      );
    } else if (mainFunctionRegex.hasMatch(content)) {
      // If main() doesn't have async, add async and dotenv initialization
      content = content.replaceFirstMapped(
        mainFunctionRegex,
            (match) => "void main() async {\n$dotenvCode\n${match.group(1) ?? ''}}",
      );
    } else {
      context.logger
          .info('Error: Could not find main() function in $mainFilePath');
      return;
    }
  } else {
    context.logger.info('dotenv configuration already exists in $mainFilePath');
  }

  // Write the updated content back to main.dart
  mainFile.writeAsStringSync(content);

  context.logger.info('Updated $mainFilePath with dotenv configuration.');
}*/

// Modify pubspec.yaml to include the env entry.
void _includeEnvAtPubspec(HookContext context) {
  final rootDir = Directory.current;
  final pubspecFile = File('${rootDir.path}/pubspec.yaml');

  if (pubspecFile.existsSync()) {
    final lines = pubspecFile.readAsLinesSync();

    // Define the assets entry.
    const String flutterHeader = 'flutter:';
    const String assetsHeader = '  assets:';
    const String envEntry = '    - .env';

    // Flags to track existing entries.
    bool hasFlutterHeader = false;
    bool hasAssetsHeader = false;
    bool hasEnvEntry = false;

    for (var line in lines) {
      if (line.startsWith(flutterHeader)) {
        hasFlutterHeader = true;
      }
      if (line.startsWith(assetsHeader)) {
        hasAssetsHeader = true;
      }
      if (line.trim() == envEntry.trim()) {
        hasEnvEntry = true;
        break;
      }
    }

    if (!hasEnvEntry) {
      if (!hasFlutterHeader) {
        // Add 'flutter' section if missing.
        lines.add('');
        lines.add(flutterHeader);
        lines.add(assetsHeader);
        lines.add(envEntry);
      } else if (!hasAssetsHeader) {
        // Add 'assets' section under 'flutter' if missing.
        final flutterIndex =
        lines.indexWhere((line) => line.startsWith(flutterHeader));
        lines.insert(flutterIndex + 1, assetsHeader);
        lines.insert(flutterIndex + 2, envEntry);
      } else {
        // Add the images entry under the existing 'assets' section.
        final assetsIndex =
        lines.indexWhere((line) => line.startsWith(assetsHeader));
        lines.insert(assetsIndex + 1, envEntry);
      }

      // Write the updated content back to pubspec.yaml.
      pubspecFile.writeAsStringSync(lines.join('\n'));
      context.logger.info(
        'Updated pubspec.yaml to include assets/env entry.',
      );
    } else {
      context.logger.info(
        'pubspec.yaml already includes the assets/env entry.',
      );
    }
  } else {
    context.logger.err('pubspec.yaml file not found.');
  }
}

void _buildInAppUpdateFeature(HookContext context) {
  final projectPath = Directory.current.path;
  final useInAppUpdate = context.vars['uses_in_app_update_feature'] as bool? ??
      true;
  if (!useInAppUpdate) {
    final inAppUpdateFolder = Directory('$projectPath/lib/in_app_update');
    if (inAppUpdateFolder.existsSync()) {
      inAppUpdateFolder.deleteSync(recursive: true);
      context.logger.info(
        '🗑️ Removed in_app_update/ folder since Firebase is disabled.',
      );
    }
  }
}

void _buildFirebaseFeature(HookContext context) {
  final projectPath = Directory.current.path;
  final useFirebase = context.vars['uses_firebase_features'] as bool? ?? true;

  if (!useFirebase) {
    final firebaseFile = File('$projectPath/lib/firebase_options.dart');
    if (firebaseFile.existsSync()) {
      firebaseFile.deleteSync();
      context.logger.info(
          '🗑️ Removed firebase_options.dart since Firebase is disabled.',
      );
    }
  }
}

void _buildNotificationFeature(HookContext context) {
  final projectPath = Directory.current.path;
  final useNotifications =
      context.vars['uses_notifications_features'] as bool? ?? true;

  if (!useNotifications) {
    final notificationFolder = Directory('$projectPath/lib/notification');
    if (notificationFolder.existsSync()) {
      notificationFolder.deleteSync(recursive: true);
      context.logger.info(
          '🗑️ Removed notification/ folder since notifications are disabled.',
      );
    }
  }
}

Future<void> _buildDependencies(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  // Install below dependencies
  await Process.run('flutter', ['pub', 'add', 'get']);
  await Process.run('flutter', ['pub', 'add', 'flutter_screenutil']);
  await Process.run('flutter', ['pub', 'add', 'dio']);
  await Process.run('flutter', ['pub', 'add', 'package_info_plus']);
  await Process.run('flutter', ['pub', 'add', 'url_launcher']);
  await Process.run('flutter', ['pub', 'add', 'connectivity_plus']);
  await Process.run('flutter', ['pub', 'add', 'skeletonizer']);
  await Process.run('flutter', ['pub', 'add', 'flutter_svg']);
  await Process.run('flutter', ['pub', 'add', 'permission_handler']);
  await Process.run('flutter', ['pub', 'add', 'image_picker']);
  await Process.run('flutter', ['pub', 'add', 'intl']);
  await Process.run('flutter', ['pub', 'add', 'path_provider']);
  await Process.run('flutter', ['pub', 'add', 'device_info_plus']);
  await Process.run('flutter', ['pub', 'add', 'share_plus']);
  await Process.run('flutter', ['pub', 'add', 'shared_preferences']);
  await Process.run('flutter', ['pub', 'add', 'google_fonts']);
  await Process.run('flutter', ['pub', 'add', 'cached_network_image']);
  await Process.run('flutter', ['pub', 'add', 'flutter_dotenv']);
  await Process.run('flutter', ['pub', 'add', 'toastification']);
  await Process.run('flutter', ['pub', 'add', 'pinput']);

  if (context.vars['uses_in_app_update_feature']) {
    await Process.run('flutter', ['pub', 'add', 'in_app_update']);
  }

  if (context.vars['uses_firebase_features'] ||
      context.vars['uses_notifications_features']) {
    await Process.run('flutter', ['pub', 'add', 'firebase_core']);
  }

  if (context.vars['uses_firebase_features']) {
    await Process.run('flutter', ['pub', 'add', 'firebase_crashlytics']);
  }

  if (context.vars['uses_notifications_features']) {
    await Process.run('flutter', ['pub', 'add', 'firebase_messaging']);
    await Process.run('flutter', ['pub', 'add', 'flutter_local_notifications']);
  }
  progress.complete();
}
