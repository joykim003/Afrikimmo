from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Property
from .models import Reservation

@admin.register(Property)
class PropertyAdmin(admin.ModelAdmin):
    list_display = ('title', 'property_type', 'price', 'location', 'created_at')
    search_fields = ('title', 'location')
    list_filter = ('property_type',)


@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ('user', 'property', 'start_date', 'end_date', 'created_at')
    list_filter = ('start_date', 'end_date')
