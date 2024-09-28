cd "$(dirname "${BASH_SOURCE[0]}")"

ROOT_DIR="$(echo "$PWD")/.."

export JRE_DIR="$ROOT_DIR/jre"
export LIB_DIR="$ROOT_DIR/lib"
export JAVAFX_DIR="$LIB_DIR/javafx-jmods"
