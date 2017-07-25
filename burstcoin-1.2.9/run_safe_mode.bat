@echo on
echo Checking Path only
for %%f in (java.exe) do if exist %%~$path:f (
  echo Java found at: %%~$path:f
  set launch="BURST" %%~$path:f -cp burst.jar;lib\*;conf nxt.Nxt
  goto startup
  ) else (
  echo Not found in Path, Searching full C drive
  for /F "tokens=*" %%f in ('%systemroot%\system32\where /F /R C:\ java.exe') do (
   echo Java found at: %%f
   set launch="BURST" %%f -cp burst.jar;lib\*;conf nxt.Nxt
   goto startup
    )
  )
echo No Java Found on this Computer
goto done
:startup

REM Check for Burst jar 
if exist burst.jar ( 
  start /wait %launch%
) else (
  for /F "tokens=*" %%f in ('%systemroot%\system32\where /F /R C:\ burst.jar') do (
   echo Burst.Jar found at: %%f
   cd %%~pf
   start /wait %launch%
   )
)
:done
exit
