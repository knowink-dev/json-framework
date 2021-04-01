echo "** This script is not finalized. It will generate the simulator framework successfully but has issues with generating the macOS and iOS versions**"

FRAMEWORK_NAME="SBJson5"
FRAMEWORK_FOLDER_NAME="${FRAMEWORK_NAME}_XCFramework"
FRAMEWORK_PATH="${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}/${FRAMEWORK_NAME}.xcframework"
TEMP_FRAMEWORK_PATH="${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}_temp"

# Set Output Destinations
SIMULATOR_ARCHIVE_PATH="${TEMP_FRAMEWORK_PATH}/simulator.xcarchive"
IOS_DEVICE_ARCHIVE_PATH="${TEMP_FRAMEWORK_PATH}/iOS.xcarchive"
MACOS_ARCIVE_PATH="${TEMP_FRAMEWORK_PATH}/macOS.xcarchive"

# Clean up existing products
rm -rf "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"
echo "Deleted existing ${FRAMEWORK_FOLDER_NAME}"

# Prepare file system
mkdir "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"
mkdir "${PROJECT_DIR}/${FRAMEWORK_FOLDER_NAME}"

# Build archives
echo "Archiving ${FRAMEWORK_NAME} for the simulator"
xcodebuild archive -scheme "SBJson5_iOS" -destination="iOS Simulator" -archivePath "${SIMULATOR_ARCHIVE_PATH}" -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
echo "Archiving ${FRAMEWORK_NAME} for iOS"
xcodebuild archive -scheme "SBJson5_iOS" -destination="iOS" -archivePath "${IOS_DEVICE_ARCHIVE_PATH}" -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
echo "Archiving ${FRAMEWORK_NAME} for macOS"
xcodebuild archive -scheme "SBJson5_macOS" -destination="macOS" -archivePath "${MACOS_ARCHIVE_PATH}" -sdk macosx SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

open "${TEMP_FRAMEWORK_PATH}"

# Create XCFramework
echo "Generating XCFramework"
xcodebuild -create-xcframework -framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/SBJson5_iOS.framework -framework ${IOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/SBJson_iOS.framework -framework ${MACOS_ARCHIVE_PATH}/Products/Library/Frameworks/SBJson_macOS.framework -output "${FRAMEWORK_PATH}"

#echo "Cleaning up temporary files"
#rm -rf "${SIMULATOR_ARCHIVE_PATH}"
#rm -rf "${IOS_DEVICE_ARCHIVE_PATH}"
#rm -rf "${MACOS_ARCHIVE_PATH}"

#open "${HOME}/Desktop/${FRAMEWORK_FOLDER_NAME}"

