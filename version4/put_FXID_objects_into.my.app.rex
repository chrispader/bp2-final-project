#!/usr/bin/env rexx

parse source . . thisProg
thisProg=filespec("Name", thisProg)

   -- make sure global Rexx .environment has an entry MY.APP (a Rexx directory)
if \.environment~hasEntry("my.app") then           -- not there?
   .environment~setEntry("my.app", .directory~new) -- create it!

bDebug=(.my.app~bDebug=.true)    -- set debug mode
if bDebug then say .dateTime~new " ==> ---> arrived in Rexx program" pp(thisProg) "..."

slotDir=arg(arg())  -- get slotDir argument (BSF4ooRexx adds this as the last argument)
scriptContext=slotDir~scriptContext   -- get entry "SCRIPTCONTEXT"

GLOBAL_SCOPE=200
   -- "location" will have the URL for the FXML-file
url=scriptContext~getAttribute("location",GLOBAL_SCOPE)
fxmlFileName=filespec("name",url~getFile) -- make sure we only use the filename portion
dir2obj =.directory~new          -- will contain all GLOBAL_SCOPE entries
.my.app~setEntry(fxmlFileName,dir2obj) -- add to .My.APP

bindings=scriptContext~getBindings(GLOBAL_SCOPE)
keys=bindings~keySet~makearray   -- get the kay values as a Rexx array
do key over keys
   val=bindings~get(key)         -- fetch the keys value
   dir2obj ~setEntry(key,val)    -- save it in our directory
end

if bDebug then
do
   say "all GLOBAL_SCOPE attributes now available via:" pp(".MY.App~"fxmlFileName)
   say
      -- show all the currently defined attributes in all ScriptContexts scopes
   say "getting all attributes from all ScriptContext's scopes..."
   dir=.directory~new   -- known constant names
   dir[100]="ENGINE_SCOPE"
   dir[200]="GLOBAL_SCOPE"
   arr=scriptContext~getScopes~makearray  -- get all scopes, turn them into a Rexx array
   do sc over arr                --
       str="ScriptContext scope" pp(sc)
       if dir~hasEntry(sc) then str=str "("dir~entry(sc)")"
       say str", available attributes:"
       say
       bin=scriptContext~getBindings(sc)
       if bin=.nil then iterate  -- inexistent scope
       keys=bin~keySet           -- get kay values
       it=keys~makearray         -- get the keys as a Rexx array
       do key over it~sortWith(.CaselessComparator~new)  -- sort caselessly
          val=bin~get(key)       -- fetch the keys value
          str=""
          if val~isA(.bsf) then str="~toString:" pp(val~toString)
          say "  " pp(key)~left(35,".") pp(val) str
       end
       if sc<>arr~lastItem then say "-"~copies(89)
                           else say "="~copies(89)
   end
end

if bDebug then
do
   say .dateTime~new " <== <--- returning from program" pp(thisProg) "."
   say
end
