#!/bin/bash
#
# build.sh
#
# Usage:
#     build.sh TAG_NAME ARCH
#
# 途中で `default.nix` の内容を書き換えるため、
# 必ず git reset --hard HEAD してから実行すること。

TAG_NAME=$1
ARCH=$2

# ハッシュの計算
HASH=$(nix-prefetch-git --rev ${TAG_NAME} https://github.com/vim/vim | jq -r .hash)

# バージョンの更新
sed -i -e "s/v9.1.0899/${TAG_NAME}/g" ./${ARCH}/default.nix

# ハッシュの更新
sed -i -e "s/sha256-pZ1zB+c9ZQ3e1H8m5jJ4WeqWmeaHMUENpzd5DNaKtjo=/${HASH}/g" ./${ARCH}/default.nix

# ビルド
cd ${ARCH}
nix-build --cores $(nproc)

# エントリーポイント作成
mv result vim-${TAG_NAME}-${ARCH}
cd vim-${TAG_NAME}-${ARCH}
cat << "EOF" | sudo tee ./AppRun > /dev/null
#!/bin/sh
CURRENT_DIR="$(dirname "$(realpath "$0")")"
export VIM="${CURRENT_DIR}/share/vim/"
exec "${CURRENT_DIR}/bin/vim" "$@"
EOF
sudo chmod a+x ./AppRun

# ライセンス添付
cd ..
sudo cp ../LICENSE ./vim-${TAG_NAME}-${ARCH}

# tar.gz に固める
tar zcfvh ./vim-${TAG_NAME}-${ARCH}.tar.gz ./vim-${TAG_NAME}-${ARCH}

