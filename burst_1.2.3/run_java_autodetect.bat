@echo off
echo Checking Path only
for %%f in (javaw.exe) do if exist %%~$path:f (
echo Java found at: %%~$path:f
start "BURST" %%~$path:f -cp burst.jar;lib\*;conf nxt.Nxt
goto startbrowser
) else (
echo Not found in Path, Searching full C drive
for /F "tokens=*" %%f in ('where /F /R C:\ javaw.exe') do (
echo Java found at: %%f
start "BURST" %%f -cp burst.jar;lib\*;conf nxt.Nxt
goto startbrowser
)
)
echo No Java Found on this Computer
stop