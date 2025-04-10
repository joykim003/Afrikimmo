
# Create your views here.
from django.shortcuts import render, redirect
from .models import Property
from .forms import PropertyForm

from .forms import ReservationForm
from .models import Reservation
from django.contrib.auth.decorators import login_required

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


@login_required
def create_reservation(request):
    if request.method == 'POST':
        form = ReservationForm(request.POST)
        if form.is_valid():
            reservation = form.save(commit=False)
            reservation.user = request.user
            reservation.save()
            return redirect('properties:list')
    else:
        form = ReservationForm()
    return render(request, 'properties/create_reservation.html', {'form': form})


@login_required
def dashboard(request):
    user = request.user
    reservations = Reservation.objects.filter(user=user).order_by('-created_at')
    return render(request, 'dashboard/dashboard.html', {
        'reservations': reservations,
    })