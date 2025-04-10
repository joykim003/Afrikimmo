from django.urls import path
from . import views
from .views import dashboard
app_name = 'properties'

urlpatterns = [
    path('', views.property_list, name='list'),
    path('ajouter/', views.property_create, name='create'),
    path('dashboard/', dashboard, name='dashboard'),

]
