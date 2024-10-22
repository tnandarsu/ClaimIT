from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

from claimit1 import settings

class CustomUserManager(BaseUserManager):
    def create_user(self, email, username, password=None):
        if not email:
            raise ValueError('The Email field is required')
        if not username:
            raise ValueError('The Username field is required')

        email = self.normalize_email(email)
        user = self.model(email=email, username=username)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username, password=None):
        user = self.create_user(email, username, password)
        user.is_admin = True
        user.save(using=self._db)
        return user

class CustomUser(AbstractBaseUser):
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=30, unique=True)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.email

class Item(models.Model):
    name = models.CharField(max_length=100)
    category = models.CharField(max_length=50)
    color = models.CharField(max_length=30)
    location = models.CharField(max_length=100)
    description = models.TextField()
    image_path = models.CharField(max_length=255, blank=True, null=True)  # Optional
    item_type = models.CharField(max_length=20)
    
    # Add a relationship to the CustomUser
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='items', null=True)

    def __str__(self):
        return f"{self.name} ({self.item_type})"



