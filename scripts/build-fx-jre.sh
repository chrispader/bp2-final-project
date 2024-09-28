# Builds a custom JRE with JavaFX modules included

cd "$(dirname "${BASH_SOURCE[0]}")"

source ./env.sh
./clean.sh

jlink --module-path $JAVA_HOME/jmods:$JAVAFX_DIR --add-modules java.base,java.logging,javafx.base,javafx.swing,javafx.controls,javafx.graphics,javafx.fxml --output $JRE_DIR
