from django import forms
from .models import Property
from .models import Reservation

class PropertyForm(forms.ModelForm):
    class Meta:
        model = Property
        fields = ['title', 'description', 'property_type', 'price', 'location', 'image']

class ReservationForm(forms.ModelForm):
    class Meta:
        model = Reservation
        fields = ['property', 'start_date', 'end_date', 'message']
