# README für FinanceInsight

FinanceInsight ist eine Finanzmanagement-Anwendung zur Verfolgung und Organisation persönlicher Finanzen.
Sie ermöglicht die Erstellung und Verwaltung von Budgets sowie die Generierung detaillierter Finanzberichte.
Die Anwendung nutzt die Java-Laufzeitumgebung und JavaFX für die Benutzeroberfläche und JFreeChart für die Erstellung von Diagrammen und Grafiken zur Visualisierung der Finanzdaten.

## Voraussetzungen

-ooRexx muss auf Ihrem System installiert sein.
-Java Development Kit (JDK) muss auf Ihrem System installiert sein. (am Besten JDK 21 oder höher)

## Installation und Einrichtung

-> ooRexx

Installation:

Besuchen Sie die offizielle ooRexx-Website: https://www.oorexx.org/
Wählen Sie die passende Version für Ihr Betriebssystem und laden Sie sie herunter.
Installieren Sie ooRexx, indem Sie dem Installationsassistenten folgen.

-> Java

Installation:

Besuchen Sie Eclipse Temurin JDK Downloads (https://adoptium.net/de/temurin/releases/) oder die JDK eines anderen Publishers und laden Sie die passende Version für Ihr Betriebssystem herunter.
Führen Sie den Installer aus und folgen Sie den Anweisungen.

-> JavaFX & Han Solo Chart

Die benötigten Java-Bibliotheken für JavaFX und die Chart-Library "Han Solo Chart" sind im "lib" Ordner mitgeliefert und werden automatisch beim Ausführen App mit der Custom-JRE integriert.

## Ausführen der Anwendung

Um die Anwendung zu starten, müssen wir zuerst eine "Custom JRE" mit JavaFX generieren. Dazu führen wir folgendes Script aus:

./build_jre.sh

Anschließend kann die Anwendung folgendermaßen ausgeführt werden:

./run.sh

Dabei sollte sich ein JavaFX Fenster mit einer Überschrift, einem Button zum Refreshen und einem Chart (aktuell nicht möglich) erscheinen. Das Chart zeigt die Einnahmen und Ausgaben (einer Person) pro Monat dar, die aus dem JSON File "income_expense.json" ausgelesen wurden.

## Weitere Informationen

Für detaillierte Anleitungen und Beispiele zur Nutzung von ooRexx, JavaFX und JFreeChart, besuchen Sie bitte die entsprechenden offiziellen Dokumentationen:

ooRexx Dokumentation: https://www.oorexx.org/docs/
JavaFX Dokumentation: https://docs.oracle.com/en/java/javase/22/
JFreeChart Dokumentation: https://www.jfree.org/jfreechart/api/javadoc/index.html
