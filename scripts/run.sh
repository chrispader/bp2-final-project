#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

source ./env.sh

if [ -d "$JRE_DIR" ]; then
  echo "Custom JRE found, setting JAVA_HOME to $JRE_DIR"
  export JAVA_HOME=$JRE_DIR
else
  echo "No custom JRE found, using default JAVA_HOME"
fi

export BSF4Rexx_JavaStartupOptions="-cp $CLASSPATH:$LIB_DIR/*"
export PATH=$JAVA_HOME/bin:$PATH

rexxj.sh ../MainApp.rex
