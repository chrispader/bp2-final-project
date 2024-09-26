# README für FinanceInsight

FinanceInsight ist eine Finanzmanagement-Anwendung zur Verfolgung und Organisation persönlicher Finanzen.
Sie ermöglicht die Einsicht und den Vergleich von Einkommens- vs. Ausgabendaten.
Die Anwendung nutzt die Java-Laufzeitumgebung und JavaFX für die Benutzeroberfläche und ChartFX für die Erstellung von Diagrammen und Grafiken zur Visualisierung der Finanzdaten.

## Voraussetzungen

- ooRexx muss auf Ihrem System installiert sein.
- Java Development Kit (JDK) muss auf Ihrem System installiert sein. (am Besten JDK 21 oder höher)

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

## Vorbereiten der Anwendungsumgebung

-> JavaFX & ChartFX

Wir verwenden JavaFX um das GUI anzuzeigen. Um ein Diagram zu zeichnen, verwenden wir "ChartFX". Sowohl JavaFX als auch ChartFX müssen vor dem Ausführen der Anwendung geladen bzw. in die Custom JRE geladen werden.

## Vorbereiten der Java Umgebung

Sie müssen zuerst die JavaFX mod herunterladen und unter “lib/javafx-jmods-22.0.2” speichern:

https://gluonhq.com/products/javafx/
(hier das jeweilige Betriebssystem/CPU-Architektur und Type “jmods” auswählen; Version 22.0.2)

Um die Custom JRE zu erstellen und alle notwendigen Libraries als ".jar" Files zu laden, führen wir folgendes Script aus:

./scripts/prepare.sh

## Ausführen der Anwendung

Anschließend kann die Anwendung folgendermaßen ausgeführt werden:

./scripts/run.sh

Dabei sollte sich ein JavaFX Fenster mit einer Überschrift, einem Button zum Refreshen und einem Chart (aktuell nicht möglich) erscheinen. Das Chart zeigt die Einnahmen und Ausgaben (einer Person) pro Monat dar, die aus dem JSON File "income_expense.json" ausgelesen wurden.

## Reinigen der Umgebung

Um die Custom JRE und alle Libraries zu löschen können wir folgendes Script ausführen:

./scripts/clean.sh

## Weitere Informationen

Für detaillierte Anleitungen und Beispiele zur Nutzung von ooRexx, JavaFX und JFreeChart, besuchen Sie bitte die entsprechenden offiziellen Dokumentationen:

ooRexx Dokumentation: https://www.oorexx.org/docs/
JavaFX Dokumentation: https://docs.oracle.com/en/java/javase/22/
ChartFX Repository: https://github.com/fair-acc/chart-fx/tree/main
