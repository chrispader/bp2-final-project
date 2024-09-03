dir=$(echo "$PWD")
export JRE_DIR="$dir/jre"
export LIB_DIR="$dir/lib"

export HANSOLO_LIBS="$LIB_DIR/hansolo"
export HANSOLO_CHARTS="$HANSOLO_LIBS/charts.jar"
export HANSOLO_TOOLBOX="$HANSOLO_LIBS/toolbox.jar"
export HANSOLO_TOOLBOXFX="$HANSOLO_LIBS/toolboxfx.jar"

export BSF4Rexx_JavaStartupOptions="-cp $CLASSPATH:$HANSOLO_TOOLBOX:$HANSOLO_TOOLBOXFX:$HANSOLO_CHARTS"

export JAVA_HOME=$JRE_DIR
export PATH=$JRE_DIR/bin:$PATH

rexxj.sh MainApp.rex
