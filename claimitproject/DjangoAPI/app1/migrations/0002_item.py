# Generated by Django 5.1.1 on 2024-10-21 15:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app1', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Item',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('category', models.CharField(max_length=50)),
                ('color', models.CharField(max_length=30)),
                ('location', models.CharField(max_length=100)),
                ('description', models.TextField()),
                ('image_path', models.CharField(blank=True, max_length=255, null=True)),
                ('item_type', models.CharField(max_length=20)),
            ],
        ),
    ]
