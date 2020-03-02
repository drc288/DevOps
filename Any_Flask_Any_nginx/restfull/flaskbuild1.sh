#!/usr/bin/env bash
# This script create template base for the class in the api
NC='\033[0m'

throw()
{
  COLOR='\033[0;31m'
  >&2 echo -e ${COLOR}$1${NC}
}

print()
{
  COLOR='\033[0;32m'
  echo -e ${COLOR}$1${NC}
}

warn()
{
  COLOR='\033[0;33m'
  echo -e ${COLOR}$1${NC}
}

make_header(){
  class=$(echo ${1^})
  cat <<-EOF
#!/usr/bin/python3
from flask import jsonify
from api.v1.views import app_views
from models import storage
from models.${1} import ${class}


EOF
}

make_body(){
  class=$(echo ${1^})
  plural=$(echo ${2})
  cat <<EOF


@app_views.route('/${plural}', methods=['GET'])
def get_${plural}():
    data = storage.all(${class})
    return jsonify([x.to_dict() for x in data])


@app_views.route('/${plural}/<${1}_id>', methods=['GET'])
def get_${1}(${1}_id):
    data = storage.get('${class}', ${1}_id)
    if data is None:
        abort(404)
    return jsonify(data.to_dict())


@app_views.route('/${plural}/<${1}_id>', methods=['DELETE'])
def delete_${1}(${1}_id):
    data = storage.get('${class}', ${1}_id)
    if data is None:
        abort(404)
    storage.delete(data)
    storage.save()
    return jsonify(data.to_dict)


@app_views.route('/${plural}', methods=['POST'])
def create_${1}():
    data = request.get_json(silent=True)
    if data is None:
        abort(404, "Not a JSON")
    elif "name" not in data.keys():
        abort(404, "Missing Name")
    else:
        new_${1} = ${class}(**data)
        storage.new(new_${1})
        storage.save()
    return jsonify(new_${1}.to_dict()), 201


@app_views.route('/${plural}/<${1}_id>', methods=['PUT'])
def update_${1}(${1}_id=None):
    data = storage.get('${class}', ${1}_id)
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
EOF
}


check_class()
{
  while [ "$class" == "" ];
  do
    throw ">>> the class cannot be empty"
    read class
  done
}

main()
{
    local class

    print "Enter class name:"
    read class
    if [ "x$class" == "x"  ];then
      check_class
    fi

    plural="./pluralize.sh"
    plural=$(eval $plural "$class")

    header=$(make_header "$class")
    body=$(make_body "$class" "$plural")
    echo "$header" "$body" | tee "$plural".py
    chmod u+x "$plural".py
}

main

