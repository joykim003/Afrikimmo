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

class PropertySearchForm(forms.Form):
    PROPERTY_TYPES = [('', 'Tous types')] + Property.PROPERTY_TYPES

    min_price = forms.DecimalField(
        required=False,
        widget=forms.NumberInput(attrs={
            'class': 'w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400',
            'placeholder': 'Prix minimum'
        })
    )
    
    max_price = forms.DecimalField(
        required=False,
        widget=forms.NumberInput(attrs={
            'class': 'w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400',
            'placeholder': 'Prix maximum'
        })
    )
    
    location = forms.CharField(
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400',
            'placeholder': 'Localisation'
        })
    )
    
    property_type = forms.ChoiceField(
        choices=PROPERTY_TYPES,
        required=False,
        widget=forms.Select(attrs={
            'class': 'w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400'
        })
    )
    
    bedrooms = forms.IntegerField(
        required=False,
        widget=forms.NumberInput(attrs={
            'class': 'form-input rounded-lg'
        })
    )
