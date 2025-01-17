#!/bin/sh -l

# Construct the exclude commands
for excludedPath in $INPUT_EXCLUDE
do
  EXCLUDE="$EXCLUDE --exclude $excludedPath"
done

lftp $INPUT_FTP_HOST -u $INPUT_FTP_USERNAME,$INPUT_FTP_PASSWORD -e "$([ "$INPUT_DISABLE_SSL_CERTIFICATE_VERIFICATION" == true ] && echo "set ssl:verify-certificate no;") $INPUT_OTHER_FLAGS mirror -n --verbose --reverse $([ "$INPUT_DELETE" == true ] && echo "--delete") $([ "$INPUT_ONLY_NEWER" == true ] && echo "--only-newer") $([ "$INPUT_IGNORE_TIME" == true ] && echo "--ignore-time") $EXCLUDE $INPUT_LOCAL_SOURCE_DIR $INPUT_DIST_TARGET_DIR; exit"
