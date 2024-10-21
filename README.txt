<!-- This file is best viewed as Markdown -->

Anmerkung: Vor dem Verwenden und Ausführen dieses Projekts müssen einige Dateien umbenannt werden, da dieses Projekt sonst nicht über Email verschickt werden kann. Dazu muss jeweils einfach nur die Endung ".txt" entfernt werden.

- Alle Scripts im "scripts" Ordner
- "gradlew.txt"
- "gradlew.bat.txt"
- "gradle/wrapper/gradle-wrapper.jar.txt"

# FinanceInsight - BP2 Abschlussprojekt der Gruppe 9

FinanceInsight ist eine Finanzmanagement-Anwendung zur Verfolgung und Organisation persönlicher Finanzen.

Sie ermöglicht die Einsicht und den Vergleich von Einkommens- vs. Ausgabendaten.
Die Anwendung nutzt die Java-Laufzeitumgebung und JavaFX für die Benutzeroberfläche und ChartFX für die Erstellung von Diagrammen und Grafiken zur Visualisierung der Finanzdaten.

## Voraussetzungen

- ooRexx muss auf Ihrem System installiert sein.
- Java Development Kit (JDK) muss auf Ihrem System installiert sein. (am Besten JDK 21 oder höher)

### ooRexx

Besuchen Sie die offizielle ooRexx-Website: https://www.oorexx.org/
Wählen Sie die passende Version für Ihr Betriebssystem und laden Sie sie herunter.
Installieren Sie ooRexx, indem Sie dem Installationsassistenten folgen.

Tun sie das gleiche für BSF4ooRexx.

### Java

Besuchen Sie Eclipse Temurin JDK Downloads (https://adoptium.net/de/temurin/releases/) oder die JDK eines anderen Publishers und laden Sie die passende Version für Ihr Betriebssystem herunter.
Führen Sie den Installer aus und folgen Sie den Anweisungen.

## Vorgehensweise

Bitte führen Sie die folgenden Schritte und Kommandos in der Reihenfolge ihrer Auflistung aus.

Zuerst muss die Anwendungsumgebung vorbereitet werden, erst dann kann die Anwendung gestartet werden.

## Vorbereiten der Anwendungs-Umgebung

### JavaFX

Wir verwenden JavaFX um das GUI anzuzeigen. Sollte ihre JDK schon JavaFX mitliefern, können Sie diesen Schritt überspringen.

Sollte JavaFX in ihrer JRE/JDK noch nicht "gebundelt" sein, dann muss eine Custom JRE generiert werden.

Sie müssen zuerst die JavaFX mod herunterladen und unter “lib/javafx-jmods-22.0.2” speichern:

- https://gluonhq.com/products/javafx/
(hier das jeweilige Betriebssystem/CPU-Architektur und Type “jmods” auswählen; Version 22.0.2)

Um die Custom JRE zu erstellen und alle notwendigen Libraries als ".jar" Files zu laden, führen wir folgendes Kommando aus:

Unix/Linux:
```sh
./scripts/build-fx-jre.sh
```

Windows:
```bat
./scripts/build-fx-jre.ps1
```

### ChartFX

Für das Zeichnen des Diagrams verwenden wir "ChartFX". Diese (JAR-)Library muss beim Ausführen der Anwendung gelinked werden. Dafür müssen vorab die notwendigen Dependencies mit Gradle installiert werden:

> Gradle wird ausschließlich für das Laden der .jar-Dateien verwendet, nicht für das "Builden" und Ausführen der Anwendung.

> Die .jar-Dateien werden bewusst in den lokalen "lib"-Ordner installiert, um nicht das globale BSF4ooRexx-Directory zu befüllen, da dieses nur schwer wieder von den Libraries zu reinigen wäre.

Unix/Linux:
```sh
./gradlew download
```

Windows:
```bat
./gradlew.ps1 download
```

## Ausführen der Anwendung

Anschließend kann die Anwendung folgendermaßen ausgeführt werden:

Unix/Linux:
```sh
./scripts/run.sh
```

Windows:
```bat
./scripts/run.ps1
```

Dabei sollte sich ein JavaFX Fenster mit einer Überschrift und einem Diagram erscheinen. Das Chart zeigt die Einnahmen und Ausgaben (einer Person) pro Monat dar, die aus dem JSON File "income_expense.json" ausgelesen wurden.

## Reinigen der Umgebung

Um die Custom JRE und alle Libraries zu löschen können wir folgendes Script ausführen:

Unix/Linux:
```sh
./scripts/run.sh
```

Windows:
```bat
./scripts/run.ps1
```

## Weitere Informationen

Für detaillierte Anleitungen und Beispiele zur Nutzung von ooRexx, JavaFX und ChartFX, besuchen Sie bitte die entsprechenden offiziellen Dokumentationen und Repositories:

- ooRexx Dokumentation: https://www.oorexx.org/docs/
- JavaFX Dokumentation: https://docs.oracle.com/en/java/javase/22/
- ChartFX Repository: https://github.com/fair-acc/chart-fx/tree/main
