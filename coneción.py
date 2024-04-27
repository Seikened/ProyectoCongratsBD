# Coneccion desde un servidor a una base de datos PostgreSQL


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'gestor_propiedades',  # Nombre de tu base de datos
        'USER': 'seikened',            # Tu nombre de usuario de PostgreSQL
        'PASSWORD': 'flfyarmi343',   # Tu contraseña de PostgreSQL
        'HOST': '89.116.212.100',# La dirección IP pública de tu VPS
        'PORT': '5432',                # El puerto de PostgreSQL, el predeterminado es 5432
    }
}


#Para conectarse desde el mismo servidor a una base de datos PostgreSQL

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': 'gestor_propiedades',  # Nombre de tu base
#         'USER': 'seikened',            # Tu nombre de usuario de PostgreSQL
#         'PASSWORD': 'flfyarmi343',   # Tu contraseña de PostgreSQL
#         'HOST': 'localhost',          # localhost
#         'PORT': '5432',                # El puerto de PostgreSQL, el predeterminado es 5432
#     }
# }
