#!/bin/bash
dir=$(dirname $0)

if which ansible && which ansible-playbook; then
    echo "Ansible is already installed."
else
    if [ -f /etc/redhat-release ]; then
        echo "Detected Red Hat-based Linux. Installing RPM packages..."
        rpm -ivh --nodeps --force --nosignature ${dir}/ansible_rpm/*.rpm
        ansible-galaxy collection install ${dir}/ansible_rpm/ansible-posix-1.3.0.tar.gz
    elif [ -f /etc/debian_version ]; then
        echo "Detected Debian-based Linux. Installing DEB packages..."
        dpkg -i ${dir}/ansible_deb/*.deb
        apt-get install -f -y
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
fi
\cp ${dir}/ansible.cfg /etc/ansible/

