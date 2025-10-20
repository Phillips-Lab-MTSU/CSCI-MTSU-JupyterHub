#!/bin/bash

export HOME=/home/${NB_USER}
echo "Running hook to prepare home directory: ${HOME}"

if [ ! -f ${HOME}/.profile ]; then
   echo "Adding .profile"
   if [ "$(id -u)" == 0 ]; then
      su -c "cp /etc/skel/.profile ${HOME}/." ${NB_USER}
   else
      cp /etc/skel/.profile ${HOME}/.
   fi
fi

if [ ! -f ${HOME}/.bash_logout ]; then
   echo "Adding .bash_logout"
   if [ "$(id -u)" == 0 ]; then
      su -c "cp /etc/skel/.bash_logout ${HOME}/." ${NB_USER}
   else
      cp /etc/skel/.bash_logout ${HOME}/.
   fi
fi

if [ ! -f ${HOME}/.bashrc ]; then
   echo "Adding .bashrc"
   if [ "$(id -u)" == 0 ]; then
      su -c "cp /etc/skel/.bashrc ${HOME}/." ${NB_USER}
      su -c "/opt/conda/bin/mamba shell init" ${NB_USER}
      su -c "/opt/conda/bin/conda init" ${NB_USER}
   else
      cp /etc/skel/.bashrc ${HOME}/.
      /opt/conda/bin/mamba shell init
      /opt/conda/bin/conda init
   fi
   echo -e "export NVM_DIR=\"/opt/nvm\"" >> ${HOME}/.bashrc
   echo -e "[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"  # This loads nvm" >> ${HOME}/.bashrc
   echo -e "[ -s \"$NVM_DIR/bash_completion\" ] && \\. \"$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" >> ${HOME}/.bashrc
fi

echo "Finished hook to prepare home directory: ${HOME}"

