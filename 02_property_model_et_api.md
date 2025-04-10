
# 🧱 Étape 2 – Modèle Property, Vue, Formulaire et API

## 🎯 Objectif
Créer la structure de gestion des biens immobiliers dans notre app :
- Modèle `Property`
- Vue de création et de liste
- Formulaire Django
- API REST pour consultation et création

---

## 1️⃣ Modèle `Property`

### 📄 Fichier : `properties/models.py`

```python
from django.db import models

class Property(models.Model):
    PROPERTY_TYPES = [
        ('house', 'Maison'),
        ('apartment', 'Appartement'),
        ('land', 'Terrain'),
    ]

    title = models.CharField(max_length=200)
    description = models.TextField()
    property_type = models.CharField(max_length=20, choices=PROPERTY_TYPES)
    price = models.DecimalField(max_digits=12, decimal_places=2)
    location = models.CharField(max_length=255)
    image = models.ImageField(upload_to='properties/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
```

---

## 2️⃣ Enregistrement dans l’admin

### 📄 Fichier : `properties/admin.py`

```python
from django.contrib import admin
from .models import Property

@admin.register(Property)
class PropertyAdmin(admin.ModelAdmin):
    list_display = ('title', 'property_type', 'price', 'location', 'created_at')
    search_fields = ('title', 'location')
    list_filter = ('property_type',)
```

---

## 3️⃣ Formulaire Django

### 📄 Fichier : `properties/forms.py`

```python
from django import forms
from .models import Property

class PropertyForm(forms.ModelForm):
    class Meta:
        model = Property
        fields = ['title', 'description', 'property_type', 'price', 'location', 'image']
```

---

## 4️⃣ Vues classiques (HTMX)

### 📄 Fichier : `properties/views.py`

```python
from django.shortcuts import render, redirect
from .models import Property
from .forms import PropertyForm

def property_list(request):
    properties = Property.objects.all().order_by('-created_at')
    return render(request, 'properties/list.html', {'properties': properties})

def property_create(request):
    if request.method == 'POST':
        form = PropertyForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('properties:list')
    else:
        form = PropertyForm()
    return render(request, 'properties/create.html', {'form': form})
```

---

## 5️⃣ Templates HTML

### 📄 `templates/properties/list.html`

```html
{% extends 'base/base.html' %}
{% block title %}Biens disponibles{% endblock %}
{% block content %}
  <h2 class="text-2xl font-bold mb-4">Biens disponibles</h2>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
    {% for property in properties %}
      <div class="border p-4 bg-white rounded shadow">
        <img src="{{ property.image.url }}" class="mb-2 w-full h-48 object-cover" />
        <h3 class="font-semibold">{{ property.title }}</h3>
        <p>{{ property.location }}</p>
        <p class="text-green-600 font-bold">{{ property.price }} FCFA</p>
      </div>
    {% endfor %}
  </div>
{% endblock %}
```

---

### 📄 `templates/properties/create.html`

```html
{% extends 'base/base.html' %}
{% block title %}Ajouter un bien{% endblock %}
{% block content %}
  <h2 class="text-2xl font-bold mb-4">Ajouter un bien</h2>
  <form method="post" enctype="multipart/form-data" class="space-y-4 bg-white p-6 rounded shadow">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded">Ajouter</button>
  </form>
{% endblock %}
```

---

## 6️⃣ Routes Django

### 📄 Fichier : `properties/urls.py`

```python
from django.urls import path
from . import views

app_name = 'properties'

urlpatterns = [
    path('', views.property_list, name='list'),
    path('ajouter/', views.property_create, name='create'),
]
```

### 📄 Inclusion dans `realestate_backend/urls.py`

```python
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    ...
    path('biens/', include('properties.urls', namespace='properties')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

---

## 7️⃣ API REST (DRF)

### 📄 `properties/serializers.py`

```python
from rest_framework import serializers
from .models import Property

class PropertySerializer(serializers.ModelSerializer):
    class Meta:
        model = Property
        fields = '__all__'
```

### 📄 `properties/api_views.py`

```python
from rest_framework import generics
from .models import Property
from .serializers import PropertySerializer

class PropertyListCreateAPIView(generics.ListCreateAPIView):
    queryset = Property.objects.all().order_by('-created_at')
    serializer_class = PropertySerializer
```

### 📄 `properties/api_urls.py`

```python
from django.urls import path
from .api_views import PropertyListCreateAPIView

urlpatterns = [
    path('biens/', PropertyListCreateAPIView.as_view(), name='api-properties'),
]
```

### 📄 Inclusion dans `realestate_backend/urls.py`

```python
urlpatterns += [
    path('api/', include('properties.api_urls')),
]
```

---

## ✅ Cette étape est validée si :

- [ ] Le modèle `Property` est opérationnel
- [ ] Les vues fonctionnent et affichent les biens
- [ ] On peut créer un bien depuis l'interface web
- [ ] Une API REST retourne la liste et permet la création
