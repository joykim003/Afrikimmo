
# 🏗️ Construction d'une application d'agence immobilière – Guide Complet

## 🎯 Objectif
Mettre en place une application web moderne d'agence immobilière (version locale), avec :
- Backend en Django + DRF
- Frontend HTMX + TailwindCSS + Alpine.js
- Base de données SQLite
- Architecture claire pour évoluer

---

## 📁 STRUCTURE GÉNÉRALE DU PROJET

```
real-estate-app/
│
├── backend/
│   ├── realestate_backend/        # Projet Django principal
│   ├── core/                      # App de base (accueil, info)
│   ├── properties/                # App pour les biens immobiliers
│   ├── users/                     # App pour les utilisateurs
│   ├── templates/
│   │   ├── base/                  # Contient base.html, navbar, footer
│   │   ├── core/
│   │   ├── properties/
│   │   └── users/
│   ├── static/
│   │   ├── css/style.css
│   │   ├── js/
│   │   └── cdn/
│   ├── media/                     # Uploads d’images
│   ├── db.sqlite3
│   └── .env
│
├── env/                           # Environnement virtuel
```

---

## ⚙️ FICHIERS À CRÉER MANUELLEMENT

### 🔹 `templates/base/base.html`

```html
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>{% block title %}ImmoBénin{% endblock %}</title>
  <link rel="stylesheet" href="{% static 'css/style.css' %}">
  <script src="{% static 'cdn/htmx.min.js' %}"></script>
  <script src="{% static 'cdn/alpine.min.js' %}" defer></script>
</head>
<body class="bg-gray-50 text-gray-900">
  {% include 'base/navbar.html' %}

  <main class="container mx-auto py-8">
    {% block content %}{% endblock %}
  </main>

  {% include 'base/footer.html' %}
</body>
</html>
```

---

### 🔹 `templates/base/navbar.html`

```html
<nav class="bg-white shadow-md">
  <div class="container mx-auto px-4 py-4 flex justify-between">
    <a href="/" class="font-bold text-xl">🏠 ImmoBénin</a>
    <div class="space-x-4">
      <a href="{% url 'properties:list' %}">Biens</a>
      <a href="{% url 'core:about' %}">À propos</a>
      {% if user.is_authenticated %}
        <a href="{% url 'users:dashboard' %}">Tableau de bord</a>
        <a href="{% url 'logout' %}">Déconnexion</a>
      {% else %}
        <a href="{% url 'login' %}">Connexion</a>
        <a href="{% url 'users:signup' %}">Inscription</a>
      {% endif %}
    </div>
  </div>
</nav>
```

---

### 🔹 `templates/base/footer.html`

```html
<footer class="bg-gray-800 text-white text-center py-6 mt-12">
  <p>© 2025 ImmoBénin. Tous droits réservés.</p>
</footer>
```

---

### 🔹 `static/css/style.css`

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

---

## 🧪 CONFIGURATION DJANGO

### 1. 📍 Dans `settings.py` :
#### Ajouter les dossiers de templates :

```python
TEMPLATES[0]['DIRS'] = [BASE_DIR / 'templates']
```

#### Ajouter les fichiers statiques :

```python
STATIC_URL = '/static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
```

#### Ajouter le dossier média :

```python
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
```

---

### 2. 📍 Ajouter les apps installées :

```python
INSTALLED_APPS = [
    ...
    'core',
    'users',
    'properties',
    'django.contrib.staticfiles',
]
```

---

### 3. 📍 Ajouter HTMX et Alpine.js (dans `static/cdn/` ou via CDN en ligne)

- HTMX : https://unpkg.com/htmx.org@1.9.2
- Alpine.js : https://unpkg.com/alpinejs@3.12.0

---

## ✅ OBJECTIF DE CETTE ÉTAPE ATTEINT SI :

- [ ] Projet Django initialisé avec apps `core`, `users`, `properties`
- [ ] `base.html` créé avec `navbar` et `footer`
- [ ] Tailwind est prêt via `style.css`
- [ ] HTMX et Alpine fonctionnent
- [ ] `settings.py` correctement configuré
- [ ] Dossier `static/`, `media/`, `templates/` bien placés

---

🔜 **Étape suivante : création du modèle `Property`, ses vues, formulaires et API.**
