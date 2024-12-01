#!/bin/bash
#
# build.sh
#
# Usage:
#     build.sh TAG_NAME ARCH

TAG_NAME=$1
ARCH=$2

# ビルド
cd ${ARCH}
nix-build --cores $(nproc)

# エントリーポイント作成
mv result vim-${TAG_NAME}-${ARCH}
cd vim-${TAG_NAME}-${ARCH}
cat << "EOF" > ./AppRun
#!/bin/sh
CURRENT_DIR="$(dirname "$(realpath "$0")")"
export VIM="${CURRENT_DIR}/share/vim/"
exec "${CURRENT_DIR}/bin/vim" "$@"
EOF
chmod a+x ./AppRun

# ライセンス添付
cd ..
cp ../LICENSE ./vim-${TAG_NAME}-${ARCH}

# tar.gz に固める
tar zcfvh ./vim-${TAG_NAME}-${ARCH}.tar.gz ./vim-${TAG_NAME}-${ARCH}

