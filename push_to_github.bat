@echo off
cd /d "%~dp0"
echo ==========================================
echo 🚀 Iniciando push automatico para o GitHub
echo ==========================================

REM Se ainda nao existir .git, cria
if not exist ".git" (
    echo 🔧 Criando repositorio local...
    git init
    git branch -M main
)

REM Marca o diretorio como seguro
git config --global --add safe.directory "%cd%"

REM Adiciona e commita tudo
git add .
git commit -m "Atualizacao automatica"

REM Adiciona o remoto se nao existir
git remote show origin >nul 2>&1
if errorlevel 1 (
    echo 🔗 Adicionando link remoto...
    git remote add origin https://github.com/leo-smi/hello_calc.git
)

REM Faz o push
echo 📤 Enviando para o GitHub...
git push -u origin main --force

echo ==========================================
echo ✅ Push concluido!
echo ==========================================

pause
