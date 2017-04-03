# Maya Data Visualization

A Docker container for running Autodesk Maya through its
interactive Python scripting API with 
[Nimble](https://github.com/sernst/Nimble).

## Install Docker

You must have Docker installed and running before you can use this
container. You can find the installers for your system at the
[Docker Community Editition](https://www.docker.com/community-edition) 
site.

## Get Container

Once Docker is installed and running, you can install the Maya Data Vis 
container by executing the command:

```bash
$ docker pull swernst/maya-data-vis
```

## Start Container

To start the container use the docker run command with the following
arguments:

```bash
$ docker run \
    -di \
    --rm \
    -p 7800:7800 \
    -p 7801:7801 \
    -p 8000:8000 \
    swernst/maya-data-vis
```

When the container is started, it will start Maya in command line mode with an
active Python interpreter that is running a 
[Nimble](https://github.com/sernst/Nimble) server.

It will also start a static-file web server on port 8000 where you
can view your rendered files.

## Hello Maya Data Vis

```python

from nimble import cmds
from nimble import actions

# Create a polygon cube in the center of the screen
cmds.polyCube()

# Render the scene to the /output/test.png folder in the container
actions.render(directory='/output', name='test')
```

Once the render is complete, the file _test.png_ will be saved to the 
container's output folder. You can view the file in your browser by opening
the file with the url:

__http://localhost:8000/test.png__


## Shared Libraries

If you want to share Python libraries between the host and container so that
you can edit those libraries on the host and view the changes in the container
you will need to mount a volume to the container with an additional argument
in the run command specified above:

```bash
$ docker run \
    -di \
    --rm \
    -p 7800:7800 \
    -p 7801:7801 \
    -p 8000:8000 \
    -v /path/to/my/libraries:/libraries
    swernst/maya-data-vis
```

The _/libraries_ directory in the container is part of the Python path for the
container. Therefore, any Python libraries you mount within this directory
will be available inside Maya. Just replace _/path/to/my/libraries_ with the
actual path to a directory that contains your Python libraries in the command
above and your container will have access to those libraries and any changes
you make to them.

## Stop Container

The container will continue to run with Maya active until you manually
shut it down. The run command included the _--rm_ flag, so once you shut the
container down it will be deleted automatically.
