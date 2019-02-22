#!/bin/bash
#编译完毕之后，拷贝gonc文件到桌面


source "exportenv.sh"
OBJ_DIR="${OBJECT_FILE_DIR_normal}/${ARCHS}"

ME=$(whoami)
DESKTOP="/Users/${ME}/Desktop"
DEFAULT_OBJ_DIR="/Users/${ME}/Desktop/mmobjs"
rm -rf ${DEFAULT_OBJ_DIR}
mkdir ${DEFAULT_OBJ_DIR}

#cp -r ${OBJ_DIR} ${DEFAULT_OBJ_DIR}
find ${OBJ_DIR} -name "*.gcno" -exec cp {} ${DEFAULT_OBJ_DIR};

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "gcno files has been copied to your desktop"