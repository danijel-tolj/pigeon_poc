#!/bin/bash

dart pub get 

echo "Generating pigeons..."
dart run pigeon --input pigeons/pigeons.dart   
echo "Generated pigeons"

exit 0