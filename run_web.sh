#!/bin/sh

# Prepare init migration.
venv/bin/python manage.py makemigrations

# Migrate db, so we have the latest db schema.
venv/bin/python manage.py migrate

# Collect static files into staticfiles folder.
venv/bin/python manage.py collectstatic --no-input

# Create a django admin
# Checks if user exists, if not creates a new user.
venv/bin/python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@myproject.com', 'password')"

# Based on environment run gunicorn
echo "ENVIRONMENT === $ENVIRONMENT"
exec venv/bin/python manage.py runserver 0.0.0.0:8080

