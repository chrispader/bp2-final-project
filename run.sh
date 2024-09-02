export JRE_DIR="./jre"
export LIB_DIR="./lib"

export HANSOLO_CHART_LIB="$LIB_DIR/hansolocharts"
export HANSOLO_CHART_JAR="$HANSOLO_CHART_LIB/charts-21.0.12.jar"

export CLASSPATH="$CLASSPATH:$FX_DIR:$LIB_DIR:$HANSOLO_CHART_JAR"
export BSF4Rexx_JavaStartupOptions="-cp $CLASSPATH"

export JAVA_HOME=$JRE_DIR
export PATH=$JRE_DIR/bin:$PATH

rexxj.sh MainApp.rex
