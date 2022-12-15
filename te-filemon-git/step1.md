
This scenario demonstrates use of ***Check Point SANDBLAST***
to automatically discover, inspect and move
files uploaded with SFTP on "dirty side" (port 2222)

Benign files are available to internal users
on "clean side" via SFTP on port 3333
or via browser on port 8888.

Check out app source
`git clone https://github.com/mkol5222/te-filemon.git`{{execute}}

Start app using Docker Compose
`cd te-filemon; mkdir ~/in; docker-compose up`{{execute}}

Wait to see container logs once app is fully ready.
You should see investigator monitoring started:
`main_1        | addDir /files/in`

Open one more Terminal tab and continue.