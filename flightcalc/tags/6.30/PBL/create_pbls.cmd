@echo off

:: determine the application target file
for /f "delims=" %%a in ('dir *.pbt /S /B') do (
	call set target=%%a
)

:: call the orca script to generate the pbls for that target
orcascr190 /D ApplicationTarget="%target%" create_pbls.orc

echo.
echo ---------------------------------
echo             ALL DONE!
echo.
echo PBLs generated / Project migrated
echo ---------------------------------
echo.

pause