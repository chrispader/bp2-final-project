dir=$(echo "$PWD")
export JRE_DIR="$dir/jre"
export LIB_DIR="$dir/lib"

export BSF4Rexx_JavaStartupOptions="-cp $CLASSPATH:$LIB_DIR/*"

export JAVA_HOME=$JRE_DIR
export PATH=$JRE_DIR/bin:$PATH

rexxj.sh MainApp.rex
