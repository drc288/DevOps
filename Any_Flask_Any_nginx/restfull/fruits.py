#!/usr/bin/python3
from flask import jsonify
from api.v1.views import app_views
from models import storage
from models.fruit import Fruit

@app_views.route('/fruits', methods=['GET'])
def get_fruits():
    data = storage.all()
    return jsonify([x.to_dict() for x in data])


@app_views.route('/fruits/<fruit_id>', methods=['GET'])
def get_fruit(fruit_id):
    data = storage.get('', fruit_id)
    if data is None:
        abort(404)
    return jsonify(data.to_dict())


@app_views.route('/fruits/<fruit_id>', methods=['DELETE'])
def delete_fruit(fruit_id):
    data = storage.get('', fruit_id)
    if data is None:
        abort(404)
    storage.delete(data)
    storage.save()
    return jsonify(data.to_dict)


@app_views.route('/fruits', methods=['POST'])
def create_fruit():
    data = request.get_json(silent=True)
    if data is None:
        abort(404, "Not a JSON")
    elif "name" not in data.keys():
        abort(404, "Missing Name")
    else:
        new_fruit = (**data)
        storage.new(new_fruit)
        storage.save()
    return jsonify(new_fruit.to_dict()), 201


@app_views.route('/fruits/<fruit_id>', methods=['PUT'])
def update_fruit(fruit_id=None):
    data = storage.get('', fruit_id)
    if data is None:
        abort(404)

    r = request.get_json(silent=True)
    if r is None:
        abort(404, "Not a JSON")
    else:
        for key, value in r.items():
            if key in ['id', 'created_at', 'updated_at']:
                pass
            else:
                setattr(data, key, value)
        storage.save()
        return jsonify(data.to_dict()), 200
