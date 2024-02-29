#!/bin/bash

echo ==INSTALLING DEPENDENCIES==
########################################
## INSTALL DEPENDENCIES AND CODE-SERVER
########################################
yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/libsecret-0.18.6-1.el7.x86_64.rpm

echo ==INSTALLING CODE-SERVER==
yum install -y https://github.com/coder/code-server/releases/download/v4.4.0/code-server-4.4.0-amd64.rpm
/home/ec2-user/anaconda3/envs/JupyterSystemEnv/bin/pip install -U keytar jupyter-server-proxy

echo ==UPDATING JUPYTER SERVER CONFIG==
#########################################
### INTEGRATE CODE-SERVER WITH JUPYTER
#########################################
cat >>/home/ec2-user/.jupyter/jupyter_notebook_config.py <<EOC
c.ServerProxy.servers = {
  'vscode': {
      'launcher_entry': {
            'enabled': True,
            'title': 'VS Code',
      },
      'command': ['code-server', '--auth', 'none', '--disable-telemetry', '--bind-addr', '127.0.0.1:{port}'],
      'environment' : {'XDG_DATA_HOME' : '/home/ec2-user/SageMaker/vscode-config'},
      'absolute_url': False,
      'timeout': 30
  }
}
EOC

echo ==INSTALL SUCCESSFUL. RESTARTING JUPYTER==
# RESTART THE JUPYTER SERVER
systemctl restart jupyter-server