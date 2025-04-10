@echo off
setlocal enabledelayedexpansion

set FRONTEND_DIR=frontend
set BACKEND_NAME=realestate_backend
set VENV_NAME=env

echo 🚀 INSTALLATION DU PROJET FULLSTACK DJANGO + HTMX + TAILWINDCSS (Windows)

REM === STRUCTURE DE BASE ===
echo 📁 Création de la structure globale...
mkdir real-estate-app
cd real-estate-app
mkdir %FRONTEND_DIR% backend

REM === BACKEND ===
echo 🐍 Création de l’environnement virtuel Python...
python1.exe -m venv %VENV_NAME%
call %VENV_NAME%\Scripts\activate

echo 📦 Installation de Django et dépendances...
pip install --upgrade pip
pip install django djangorestframework python-decouple ^
pip Pillow djangorestframework-simplejwt django-cors-headers ^
pip django-htmx whitenoise

echo 🏗️ Création du projet Django...
cd backend
django-admin startproject %BACKEND_NAME%
cd %BACKEND_NAME%

cd ..
django-admin startapp core
django-admin startapp properties
mkdir media static templates

REM Créer sous-dossiers
mkdir core\templates\core core\forms core\urls
type nul > core\urls\__init__.py
type nul > core\forms\__init__.py

mkdir properties\templates\properties properties\forms properties\urls
type nul > properties\urls\__init__.py
type nul > properties\forms\__init__.py

REM Modification du fichier settings.py
set SETTINGS_FILE=%BACKEND_NAME%\settings.py

REM Ajout dans INSTALLED_APPS et MIDDLEWARE
powershell -Command "(Get-Content %SETTINGS_FILE%) -replace 'INSTALLED_APPS = \[', 'INSTALLED_APPS = [\n    ''rest_framework'',\n    ''corsheaders'',\n    ''core'',\n    ''properties'',\n    ''django_htmx'',' | Set-Content %SETTINGS_FILE%"
powershell -Command "(Get-Content %SETTINGS_FILE%) -replace 'MIDDLEWARE = \[', 'MIDDLEWARE = [\n    ''corsheaders.middleware.CorsMiddleware'',\n    ''django_htmx.middleware.HtmxMiddleware'',' | Set-Content %SETTINGS_FILE%"

REM Ajout config DB et autres à la fin
echo. >> %SETTINGS_FILE%
echo REM === CONFIGURATION SQLITE ET AUTRES === >> %SETTINGS_FILE%
echo DATABASES = { >> %SETTINGS_FILE%
echo     'default': { >> %SETTINGS_FILE%
echo         'ENGINE': 'django.db.backends.sqlite3', >> %SETTINGS_FILE%
echo         'NAME': BASE_DIR / 'db.sqlite3', >> %SETTINGS_FILE%
echo     } >> %SETTINGS_FILE%
echo } >> %SETTINGS_FILE%
echo. >> %SETTINGS_FILE%
echo STATIC_URL = '/static/' >> %SETTINGS_FILE%
echo STATICFILES_DIRS = [BASE_DIR / 'static'] >> %SETTINGS_FILE%
echo MEDIA_URL = '/media/' >> %SETTINGS_FILE%
echo MEDIA_ROOT = BASE_DIR / 'media' >> %SETTINGS_FILE%
echo. >> %SETTINGS_FILE%
echo TEMPLATES[0]['DIRS'] = [BASE_DIR / 'templates'] >> %SETTINGS_FILE%
echo. >> %SETTINGS_FILE%
echo CORS_ALLOW_ALL_ORIGINS = True >> %SETTINGS_FILE%
echo. >> %SETTINGS_FILE%
echo REST_FRAMEWORK = { >> %SETTINGS_FILE%
echo     'DEFAULT_AUTHENTICATION_CLASSES': ( >> %SETTINGS_FILE%
echo         'rest_framework_simplejwt.authentication.JWTAuthentication', >> %SETTINGS_FILE%
echo     ) >> %SETTINGS_FILE%
echo } >> %SETTINGS_FILE%

REM .env exemple
echo DEBUG=True> .env
echo SECRET_KEY=changeme>> .env

deactivate
cd ..

REM === FRONTEND SETUP ===
echo 🎨 Installation Tailwind CSS + HTMX + Alpine.js...
cd %FRONTEND_DIR%
npm init -y
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

REM Tailwind config
(
echo module.exports = {
echo   content: ["../backend/templates/**/*.html"],
echo   theme: {
echo     extend: {},
echo   },
echo   plugins: [],
echo }
) > tailwind.config.js

mkdir css js
(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
) > css/style.css

REM HTMX + Alpine.js (via CDN)
mkdir cdn
curl -o cdn\htmx.min.js https://unpkg.com/htmx.org@1.9.10
curl -o cdn\alpine.min.js https://unpkg.com/alpinejs@3.13.0/dist/cdn.min.js

cd ..

echo ✅ Projet initialisé avec succès sous Windows !
echo.
echo 📁 %FRONTEND_DIR%\ : Tailwind CSS + HTMX + Alpine.js
echo 📁 backend\ : Projet Django avec apps "core" et "properties"
echo 🗂️ Base de données SQLite (db.sqlite3)
echo.
echo 🚀 Pour démarrer :
echo 1. Compile Tailwind :
echo    cd %FRONTEND_DIR% && npx tailwindcss -i ./css/style.css -o ../backend/static/style.css --watch
echo 2. Active l'env et démarre Django :
echo    call %VENV_NAME%\Scripts\activate && cd backend\%BACKEND_NAME% && python manage.py migrate && python manage.py runserver

pause
