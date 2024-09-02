export JRE_DIR="./jre"
export LIB_DIR="./lib"
export FX_DIR="$LIB_DIR/javafx-jmods-22.0.2"

./clean_jre.sh

jlink --module-path $JAVA_HOME/jmods:$FX_DIR --add-modules java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml --output $JRE_DIR
