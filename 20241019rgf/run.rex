#!/usr/bin/env rexx
-- rgf, 20241019
parse upper arg switch .   -- get switch in uppercase, if any
switchLetter=switch[1]     -- get first letter
bKnownSwitch=wordpos(switch, "-H /H /? ?")>0 | pos(switchLetter,"SC")>0
if switch<>"" & (wordpos(switch, "-H /H /? ?")>0 | pos(switchLetter,"SC")=0) then
do
   say .resources~usage    -- show usage
   if \bKnownSwitch then
   do
      say
      say "line #" .line":" "--> unknown switch:" arg(1)
      exit -1
   end
   exit
end
   -- get operating system and source path
parse source op_sys +1 . . sourcePath
location=filespec("Location",sourcePath)  -- get location of this Rexx script
oldDir=directory(location) -- change current directory to source path

bIsUnix=op_sys<>"W"  -- determine operating system

currClassPath=value("CLASSPATH",,"environment") -- get current value
cmdDispatch="org.rexxla.bsf.RexxDispatcher MainApp.rex" -- use BSF4ooRexx dispatcher class

if bIsUnix then   -- Unix
do
   cmdClean         ="rm -rf"
   cmdGetGradle     ="./gradlew"
   cmdDownloadLibs  ="./gradlew download"
   libPath          =location"lib/*"
   gradleJarLocation="gradle/wrapper/"
      -- set environment variable
   adjustedClassPath=quote(currClassPath":"libPath)
end
else  -- Windows
do
   cmdClean       ="rd /s /q"
   cmdGetGradle   ="gradlew"
   cmdDownloadLibs="gradlew download"
   libPath        =location"lib\*"
   gradleJarLocation="gradle\wrapper\"
      -- set environment variable
   adjustedClassPath=quote(currClassPath";"libPath)
end

-- use java command directly (and BSF4ooRexx RexxDispatcher class) 
cmdRunApp ="java -cp" adjustedClassPath "org.rexxla.bsf.RexxDispatcher" "MainApp.rex" 

if switchLetter="C" then   -- clean
do
   tmpClean=cmdClean
   if sysFileExists(".gradle") then tmpClean = tmpClean ".gradle"
   if sysFileExists("lib")     then tmpClean = tmpClean "lib"
   if tmpClean=cmdClean then  -- no directory to remove
      exit 0

   address system tmpClean
   if rc<>0 then  -- indicate problem
   do
      say "line #" .line":" "return code" pp(rc) "running" pp(tmpClean)
      exit -2
   end
   exit 0
end
else  -- make sure that ".gradle" and "lib" exist
do
   if \SysFileExists(".gradle") then call setup
   else if \SysFileExists("lib") then call setup   -- ".gradle" may exist, but not yet "lib"

   if switch="" then	-- run the program
   do
      cmdRunApp
      if rc<>0 then  -- indicate problem
      do
         say "line #" .line":" "return code" pp(rc) "running" pp(cmdRunApp)
         exit -3
      end
   end
end
exit

setup:      -- if no ".gradle" try to create it, if no "lib" try to create it
  if \sysFileExists(".gradle") then
  do
      -- need to rename before using it?
      gradleWrapperName   ="gradle-wrapper.jar"
      if \SysFileExists(gradleJarLocation || gradleWrapperName) then
      do
         gradleWrapperNameTxt=gradleWrapperName".txt"
         tmpGradleJarTxt=gradleJarLocation || gradleWrapperNameTxt
         if sysFileExists(tmpGradleJarTxt) then    -- not yet renamed, remove ".txt"
         do
            oldDir=directory()               -- get current directory
            call directory gradleJarLocation -- change current directory
            res=SysFileMove(gradleWrapperName".txt", gradleWrapperName)
            if res<>0 then
            do
               say "line #" .line":" "SysFileMove() returned:" pp(0)", cannot find" pp(gradleWrapperName) "nor rename" pp(gradleWrapperName".txt") "in directory" pp(qualify(gradleJarLocation))
               exit -4
            end

            call directory oldDir      -- change to previous directory
         end
         else  -- "gradle-wrapper.jar" nor "gradle-wrapper.jar.txt" available! :(
         do
            say "line #" .line":" "directory" pp(qualify(gradleJarLocation)) "does not have" pp(gradleWrapperName) "nor" pp(gradleWrapperNameTxt)
            exit -5
         end
      end

      address system cmdGetGradle
      if rc<>0 then  -- indicate problem
      do
         say "line #" .line":" "return code" pp(rc) "running" pp(cmdGetGradle)
         exit -6
      end
  end

  if \sysFileExists("lib") then
  do
      address system cmdDownloadLibs
      if rc<>0 then  -- indicate problem
      do
         say "line #" .line":" "return code" pp(rc) "running" pp(cmdDownloadLibs)
         exit -7
      end
  end
  return


::routine pp
  return "["arg(1)"]"

::routine quote
  return '"'arg(1)'"'

::resource usage
"run.rex" usage (only first letter necessary):

         ... no argument: run MainApp.rex (does the setup, if necessary)

   setup ... makes sure that gradle gets downloaded to the directory ".gradle"
             and that the "lib" directory exists, if not employs
             "gradlew download" to download the necessary libraries to "lib"

   clean ... removes the ".gradle" and "lib" directories

   ?     ... show usage
   /?    ... show usage
   -h    ... show usage
   /h    ... show usage
::END
