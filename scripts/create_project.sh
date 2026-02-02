#!/bin/bash
echo "🚀 Flutter Project Generator with Mason Integration"

# System Requirements
echo "⚠️  System Requirements:"
echo "✅ Flutter & Dart SDK must be installed (Compatible with Flutter 3.38.9+)."
echo "✅ Java must be installed (Compatible version: Java 17)."
echo ""

# 1️⃣ Ensure Mason is Installed & Activated Globally
echo "🧱 Checking Mason CLI installation..."

if ! command -v mason &> /dev/null
then
    echo "⚠️ Mason CLI not found. Activating Mason globally..."
    dart pub global activate mason_cli
    export PATH="$HOME/.pub-cache/bin:$PATH"
    echo "✅ Mason activated successfully!"
else
    echo "✅ Mason CLI is already installed."
fi

# 2️⃣ Prompt for Project Name
read -p "Enter Flutter project name (use _ instead of space): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME// /_}  # Replace spaces with underscores

# Validate project name (only allow letters, numbers, and underscores)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "❌ Invalid project name! Use only letters, numbers, and underscores (_)."
    exit 1
fi

echo "✅ Project Name: $PROJECT_NAME"

# 3️⃣ Prompt for Project Location (Default: Current Directory)
read -p "Enter project location (default: current directory): " PROJECT_LOCATION
PROJECT_LOCATION=${PROJECT_LOCATION:-$(pwd)}

# 4️⃣ Prompt for Project Description
read -p "Enter project description: " PROJECT_DESCRIPTION

# 5️⃣ Prompt for Project Type
echo "Select project type:"
echo "1) Application (default)"
echo "2) Plugin"
echo "3) Package"
read -p "Enter choice (1-3): " PROJECT_TYPE
case $PROJECT_TYPE in
    2) PROJECT_TYPE="plugin";;
    3) PROJECT_TYPE="package";;
    *) PROJECT_TYPE="app";;
esac

# 6️⃣ Prompt for Package Name (Organization)
read -p "Enter Organization name (e.g., com.example): " ORGANIZATION_NAME
PACKAGE_NAME="${ORGANIZATION_NAME}.${PROJECT_NAME}"
echo "📦 Package Name: $PACKAGE_NAME"

# 7️⃣ Select Android Language
read -p "Select Android language (java/kotlin) [Default: kotlin]: " ANDROID_LANG
ANDROID_LANG=${ANDROID_LANG:-kotlin}

# 8️⃣ Select iOS Language
read -p "Select iOS language (objc/swift) [Default: swift]: " IOS_LANG
IOS_LANG=${IOS_LANG:-swift}

# 9️⃣ Select Platforms
PLATFORMS=("android" "ios" "linux" "macos" "web" "windows")
SELECTED_PLATFORMS=()

echo "Select platforms (Press Enter to select all, or type choices separated by space):"
echo "Options: android ios linux macos web windows"
read -a USER_PLATFORMS

if [ ${#USER_PLATFORMS[@]} -eq 0 ]; then
    SELECTED_PLATFORMS=("${PLATFORMS[@]}")
else
    SELECTED_PLATFORMS=("${USER_PLATFORMS[@]}")
fi

# Convert platform array to comma-separated string
PLATFORM_STRING=$(IFS=,; echo "${SELECTED_PLATFORMS[*]}")

# 🔟 Create the Flutter Project
echo "🛠️ Creating Flutter project..."
flutter create --project-name "$PROJECT_NAME" \
    --org "$ORGANIZATION_NAME" \
    --description "$PROJECT_DESCRIPTION" \
    --template "$PROJECT_TYPE" \
    --android-language "$ANDROID_LANG" \
    --ios-language "$IOS_LANG" \
    --platforms "$PLATFORM_STRING" \
    "$PROJECT_LOCATION/$PROJECT_NAME"

# Change to the project directory
cd "$PROJECT_LOCATION/$PROJECT_NAME" || exit

# 1️⃣1️⃣ Ensure Mason is Initialized
echo "🧱 Initializing Mason..."
mason init

# 1️⃣2️⃣ Add Mason Brick from GitHub Repo with Fallback
MASON_GITHUB_URL="https://github.com/dethariyanikunj/flutter_core.git"
MASON_BRICK_NAME="flutter_core"

# Resolve script directory to check for local brick
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BRICK_PATH="$(dirname "$SCRIPT_DIR")"

echo "🔗 Resolving Mason brick source..."

if [ -f "$LOCAL_BRICK_PATH/brick.yaml" ]; then
    echo "📍 Detected local brick at '$LOCAL_BRICK_PATH'. Using local source."
    mason add "$MASON_BRICK_NAME" --path "$LOCAL_BRICK_PATH"
else
    echo "🌐 Local brick not found in parent directory. Falling back to GitHub: $MASON_GITHUB_URL"
    if mason add "$MASON_BRICK_NAME" --git-url "$MASON_GITHUB_URL" --git-ref main; then
        echo "✅ Mason brick added from GitHub successfully!"
    else
        echo "❌ ERROR: Failed to add Mason brick from GitHub."
        exit 1
    fi
fi

# 1️⃣3️⃣ Ensure Mason Bricks Are Installed
echo "📦 Installing Mason Bricks..."
mason get

# 1️⃣4️⃣ Run Mason Brick (Ensures Variables Are Asked)
echo "🔧 Generating files from Mason..."
mason make "$MASON_BRICK_NAME" --on-conflict overwrite

# 1️⃣5️⃣ Setup FVM (Flutter Version Management)
echo "💎 Checking FVM configuration..."

REQUIRED_FLUTTER_VERSION="3.38.9"

setup_fvm() {
    if ! command -v fvm &> /dev/null; then
        echo "⚠️  FVM is not installed."
        read -p "Do you want to install FVM globally? (y/N): " install_fvm
        if [[ "$install_fvm" =~ ^[Yy]$ ]]; then
            echo "📥 Installing FVM..."
            dart pub global activate fvm
            export PATH="$HOME/.pub-cache/bin:$PATH"
            echo "✅ FVM installed successfully."
        else
            echo "⚠️  Skipping FVM setup. You can setup it manually later."
            return
        fi
    fi

    echo "🔍 Checking for Flutter $REQUIRED_FLUTTER_VERSION..."
    if fvm list | grep -q "$REQUIRED_FLUTTER_VERSION"; then
        echo "✅ Flutter $REQUIRED_FLUTTER_VERSION is already installed via FVM."
        fvm use "$REQUIRED_FLUTTER_VERSION" --force
    else
        echo "⚠️  Flutter $REQUIRED_FLUTTER_VERSION is missing."
        read -p "Do you want to install Flutter $REQUIRED_FLUTTER_VERSION via FVM? (Y/n): " install_flutter
        install_flutter=${install_flutter:-Y} # Default to Yes
        
        if [[ "$install_flutter" =~ ^[Yy]$ ]]; then
            echo "⬇️  Installing Flutter $REQUIRED_FLUTTER_VERSION..."
            fvm install "$REQUIRED_FLUTTER_VERSION"
            fvm use "$REQUIRED_FLUTTER_VERSION" --force
            echo "✅ Flutter $REQUIRED_FLUTTER_VERSION configured."
        else
            echo "⚠️  Skipping Flutter installation."
        fi
    fi
}

setup_fvm

echo "✅ Flutter project '$PROJECT_NAME' created successfully at '$PROJECT_LOCATION/$PROJECT_NAME'!"
echo "🚀 Ready to start coding! Open in your IDE (Android studio): cd $PROJECT_LOCATION/$PROJECT_NAME && flutter pub get"
