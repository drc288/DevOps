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

  plural=$(echo ${2})
  cat <<EOF


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

