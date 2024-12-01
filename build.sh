#!/bin/bash
#
# build.sh
#
# Usage:
#     build.sh TAG_NAME ARCH

TAG_NAME=$1
ARCH=$2

cd ${ARCH}
nix-build --cores $(nproc)
mv result vim-${TAG_NAME}-${ARCH}
cd vim-${TAG_NAME}-${ARCH}
cat << "EOF" > ./AppRun
#!/bin/sh
CURRENT_DIR="$(dirname "$(realpath "$0")")"
export VIM="${CURRENT_DIR}/share/vim/"
exec "${CURRENT_DIR}/bin/vim" "$@"
EOF
chmod a+x ./AppRun
cd ..
tar zcfvh ./vim-${TAG_NAME}-${ARCH}.tar.gz ./vim-${TAG_NAME}-${ARCH}

