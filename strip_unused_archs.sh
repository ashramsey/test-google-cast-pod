#!/bin/bash

# This script strips unused architectures from any frameworks embedded in an
# app bundle. It should be called from an Xcode project as a post-build step.
# It then re-signs the dynamic libs and in the case of release, the entitlements.

if [ -z "${TARGET_BUILD_DIR}" ]; then
  echo "This script should be invoked from an Xcode project."
  exit 1
fi

CODESIGN_ALLOCATE="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/codesign_allocate"

app_dir="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"
echo "${TARGET_BUILD_DIR}"

find "${app_dir}" -type d -name '*.framework' -print0 | while IFS= read -r -d '' framework_dir; do
  framework_name=$(defaults read "${framework_dir}/Info.plist" CFBundleExecutable)
  framework_path="${framework_dir}/${framework_name}"

  echo "Removing unused architectures from framework: ${framework_name}"

  slice_paths=()
  for arch in ${ARCHS}; do
    slice_path="${framework_path}_${arch}"
    lipo "${framework_path}" -extract "${arch}" -output "${slice_path}"
    slice_paths+=("${slice_path}")
  done

  lipo "${slice_paths[@]}" -create -output "${framework_path}_thinned"
  rm -f "${slice_paths[@]}"

  rm -f "${framework_path}"
  mv "${framework_path}_thinned" "${framework_path}"
  chmod -R 777 "${framework_dir}"

  /usr/bin/codesign -f -s "${CERTIFICATE}" --preserve-metadata="identifier,entitlements,flags" "${framework_path}"
done

if [ -z "${DEVELOPMENT}" ]; then
  echo "Codesigning entitlements"
  /usr/bin/codesign -f -s "${CERTIFICATE}" --entitlements "${TARGET_BUILD_DIR}/Entitlements.plist" "${TARGET_BUILD_DIR}/${APP}.app"
fi


ipa_root="./build/ipa_root"
/bin/rm -rf "${ipa_root}"
/bin/mkdir -p "${ipa_root}"/Payload
/bin/cp -r "${TARGET_BUILD_DIR}/${APP}.app" ./build/ipa_root/Payload
/bin/chmod -R 755 "${ipa_root}"/Payload
cd "${ipa_root}"
/usr/bin/zip -q -r archive.zip Payload
cd ../../
/bin/mv "${ipa_root}"/archive.zip "${TARGET_BUILD_DIR}/${APP}.ipa"
/bin/rm -rf "${ipa_root}"
