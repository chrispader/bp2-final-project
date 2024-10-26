2024-10-19, rgf

Voraussetzung für das erfolgreiche Ausführen dieses Projekts ist:

- ooRexx 5.1 installiert [1]
- Java mit JavaFX, ab Version 21 installiert [2]

Anmerkung: Vor dem Verwenden und Ausführen dieses Projekts müssen einige Dateien umbenannt werden, da dieses Projekt sonst nicht über Email verschickt werden kann. Dazu muss jeweils einfach nur die Endung ".txt" entfernt werden.

- "gradlew.txt"
- "gradlew.bat.txt"
- "gradle/wrapper/gradle-wrapper.jar.txt"
- "run.rex.txt"

Das Projekt ausführen:

        - zip-Archiv auspacken und in das Verzeichnis wechseln

        - den Befehl "rexx run.rex" eingeben

          - dieses Skript wird beim ersten Aufruf automatisch alle benötigten Dateien
            aus dem Internet laden, im Verzeichnis von "run.rex" speichern und
            anschließend MainApp.rex mit den korrekten Settings ausführen

        Hinweise: - um alle Optionen kennenzulernen "rexx run ?" eingeben

Viel Erfolg!


[1] ooRexx 5.1 Downloadseite: <https://sourceforge.net/projects/oorexx/files/oorexx/5.1.0beta/>

[2] Java mit JavaFX 21, z.B.
      Azul:  <https://www.azul.com/downloads/?version=java-21-lts&package=jdk-fx#zulu>

      BellSouth: <https://bell-sw.com/pages/downloads/#jdk-21-lts>
      ATTENTION: pick "Full JDK" from the dropdown for your operating system on the left hand side
