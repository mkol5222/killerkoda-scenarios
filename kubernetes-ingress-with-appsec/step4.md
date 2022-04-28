
<br>

### Install helm

We will use [arkade](https://github.com/alexellis/arkade#getting-arkade) to install missing helm.

Install arkade first:
`curl -sLS https://get.arkade.dev | sh`{{exec}}

Grab helm and put it on path:
`arkade get helm; mv /root/.arkade/bin/helm /usr/local/bin/`{{exec}}

Check helm by asking about version:
`helm version`{{exec}}

Well played.


