@echo off
setlocal

set BGEXE=..\..\Binaries\Boogie.exe
rem set BGEXE=mono ..\..\Binaries\Boogie.exe

echo ----- Running regression test f1.bpl
%BGEXE% %* /noinfer /stratifiedInline:1 /stratifiedInlineOption:1 /typeEncoding:m /prover:z3api f1.bpl
echo -----
