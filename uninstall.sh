#!/bin/bash
#调用此脚本的用法   "?.sh config文件路径"；如果传入的是目录，默认读取该目录下的config文件；如果传入的是文件则为指定的文件

set -u -e 

dir=$(dirname $0)
ANSIBLE_HOSTS=${1}

if [ -d ${ANSIBLE_HOSTS} ]
then
  ANSIBLE_HOSTS=${ANSIBLE_HOSTS}/config
fi
sh ${dir}/shell/install-ansible.sh
ansible-playbook -i ${ANSIBLE_HOSTS} ${dir}/ansible/06* --tags=uninstall --become  --become-method=sudo --become-user=root
ansible-playbook -i ${ANSIBLE_HOSTS} ${dir}/ansible/05* --tags=uninstall --become  --become-method=sudo --become-user=root
sleep 3
echo -e "\033[32m>>>>卸载成功，清除了全部数据目录"
