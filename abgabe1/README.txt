# README für FinanceInsight

FinanceInsight ist eine Finanzmanagement-Anwendung zur Verfolgung und Organisation persönlicher Finanzen.
Sie ermöglicht die Erstellung und Verwaltung von Budgets sowie die Generierung detaillierter Finanzberichte.
Die Anwendung nutzt die Java-Laufzeitumgebung und JavaFX für die Benutzeroberfläche und JFreeChart für die Erstellung von Diagrammen und Grafiken zur Visualisierung der Finanzdaten.

### Voraussetzungen

-ooRexx muss auf Ihrem System installiert sein.
-Java Development Kit (JDK) muss auf Ihrem System installiert sein.
-JavaFX-Bibliotheken müssen in Ihr Projekt integriert sein.
-JFreeChart-Bibliotheken müssen in Ihr Projekt integriert sein.

### Installation und Einrichtung

-> ooRexx

Installation:

Besuchen Sie die offizielle ooRexx-Website: https://www.oorexx.org/
Wählen Sie die passende Version für Ihr Betriebssystem und laden Sie sie herunter.
Installieren Sie ooRexx, indem Sie dem Installationsassistenten folgen.

-> Java

Installation:

Besuchen Sie Oracle JDK Downloads (https://www.oracle.com/java/technologies/downloads/?er=221886) und laden Sie die passende Version für Ihr Betriebssystem herunter.
Führen Sie den Installer aus und folgen Sie den Anweisungen.

-> JavaFX

Installation und Integration:

Laden Sie die JavaFX-SDK von der offiziellen Gluon-Website herunter (https://gluonhq.com/products/javafx/).
Fügen Sie die JavaFX-Bibliotheken zu Ihrem Projekt hinzu. Detaillierte Anweisungen zur Integration finden Sie in der JavaFX-Dokumentation.

-> JFreeChart

Installation und Integration:

Besuchen Sie die offizielle JFreeChart-Website (https://github.com/jfree/jfreechart/releases/tag/v1.5.2) und laden Sie die Bibliotheken herunter.
Fügen Sie die JFreeChart-Bibliotheken zu Ihrem Projekt hinzu. Weitere Informationen finden Sie in der JFreeChart-Dokumentation.

### Weitere Informationen

Für detaillierte Anleitungen und Beispiele zur Nutzung von ooRexx, JavaFX und JFreeChart, besuchen Sie bitte die entsprechenden offiziellen Dokumentationen:

ooRexx Dokumentation: https://www.oorexx.org/docs/
JavaFX Dokumentation: https://docs.oracle.com/en/java/javase/22/
JFreeChart Dokumentation: https://www.jfree.org/jfreechart/api/javadoc/index.html

# Implementierung und Lessons Learned

Bei der Implementierung der Anwendung haben sich leider Fehler aufgetan, die wir schlussendlich nicht beheben konnten. Genauer gesagt geht es dabei um Java(FX)-interne Exceptions, die beim Launchen der App (invoke "launch") aufgrund eines Teils des Codes in ooRexx passieren.

Wir konnten zwar die verursachende Stelle ausfindig machen, haben allerdings in der Zeit bis zur finalen Einheit keinen Lösungsweg gefunden, um das Problem zu beheben.

Es lässt sich daher zwar das grundlegende UI anzeigen und die Finanzdaten für FinanceInsight aus einem JSON-File auslesen und parsen, jedoch können wir den JavaFX Graph nicht mit den Daten befüllen.
