# Generated by Django 4.2.11 on 2024-05-25 03:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('honorarios_api', '0005_alter_file_model_binary'),
    ]

    operations = [
        migrations.AlterField(
            model_name='file_model',
            name='binary',
            field=models.CharField(default='', max_length=500000),
        ),
    ]
