#!/bin/bash

case "$(uname -s)" in
    Linux*) CURA_CONFIG_ROOT="$HOME/.local/share/cura";;
    Darwin*) CURA_CONFIG_ROOT="$HOME/Library/Application Support/cura";;
esac

[ -d "$CURA_CONFIG_ROOT" ] && CURA_DIR=$(find "$CURA_CONFIG_ROOT" -maxdepth 1 -type d | grep -E "/[0-9]+\.[0-9]+$" | sort | tail -n 1)

if [ -z "$CURA_DIR" ]
then
    echo "Can't find Cura configuration, aborting"
    exit 1
fi

echo "Found Cura configuration directory at $CURA_DIR"

# create  directories
if [ -d "$CURA_DIR/definitions" ]
then
    echo "No need to create definitions directory"
else
    echo "Creating $CURA_DIR/definitions"
    mkdir "$CURA_DIR/definitions"
fi

if [ -d "$CURA_DIR/extruders" ]
then
    echo "No need to create extruders directory"
else
    echo "Creating $CURA_DIR/extruders"
    mkdir "$CURA_DIR/extruders"
fi

if [ -d "$CURA_DIR/meshes" ]
then
    echo "No need to create meshes directory"
else
    echo "Creating $CURA_DIR/meshes"
    mkdir "$CURA_DIR/meshes"
fi

# copy files
echo "Copying resources into $CURA_DIR..."
cp resources/definitions/* "$CURA_DIR/definitions/"
cp resources/extruders/* "$CURA_DIR/extruders/"
cp resources/meshes/* "$CURA_DIR/meshes/"

echo "All done! Please launch Cura to complete configuration."
