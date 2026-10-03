#!/bin/bash

#调用此脚本的用法   "?.sh config文件路径"；如果传入的是目录，默认读取该目录下的config文件；如果传入的是文件则为指定的文件

set -u -e 

dir=$(dirname $0)
ANSIBLE_HOSTS=${1}

if [ -d ${ANSIBLE_HOSTS} ]
then
  ANSIBLE_HOSTS=${ANSIBLE_HOSTS}/config
fi

echo -e "\033[32m>>>>部署ansible\033[0m"
sh ${dir}/shell/install-ansible.sh

ansible-playbook -i ${ANSIBLE_HOSTS} ${dir}/ansible/20* --tags=install --become  --become-method=sudo --become-user=root
ansible-playbook -i ${ANSIBLE_HOSTS} ${dir}/ansible/05* --tags=install --become  --become-method=sudo --become-user=root
ansible-playbook -i ${ANSIBLE_HOSTS} ${dir}/ansible/06* --tags=install --become  --become-method=sudo --become-user=root

echo -e "\033[32m>>>>部署成功"

