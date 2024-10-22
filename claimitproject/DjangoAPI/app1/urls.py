from django.urls import path
from .views import register, login
from .views import ItemList, get_lost_items

from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register, name='register'),
    path('login/', views.login, name='login'),
    path('items/', ItemList.as_view(), name='item-list'),
    path('lost-items/<str:username>/', views.get_lost_items, name='get_lost_items'),
]





