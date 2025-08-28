@echo off
chcp 65001 > nul
set PYTHONIOENCODING=utf-8
set PYTHONUTF8=1
echo 啟動 GPT Researcher...
uvicorn main:app --reload
pause