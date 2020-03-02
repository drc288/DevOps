#!/usr/bin/env bash
# This script create template base for the class in the api
plural="./pluralize.sh"
plural=$(eval $plural $1)
class=$(echo ${1^})
cat <<EOF
#!/usr/bin/python3
from flask import jsonify
from api.v1.views import app_views
from models import storage
from models.${1} import ${class}


@app_views.route('/${plural}', methods=['GET'])
def get_${plural}():
    pass


@app_views.route('/${plural}/<${1}_id>', methods=['GET'])
def get_${1}(${1}_id):
    pass


@app_views.route('/${plural}/<${1}_id>', methods=['DELETE'])
def delete_${1}(${1}_id):
    pass


@app_views.route('/${plural}', methods=['POST'])
def create_${1}(${1}_id):
    pass


@app_views.route('/${plural}/<${1}_id>', methods=['PUT'])
def update_${1}(${1}_id):
    pass
EOF
