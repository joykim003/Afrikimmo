from django.urls import path
from . import views

app_name = 'properties'

urlpatterns = [
    path('', views.property_list, name='list'),
    path('search/', views.property_search, name='search'),
    path('<int:pk>/', views.property_detail, name='detail'),  # URL pour les détails
]
