# How to Use the Ansible Lab

This guide explains how to write your first Ansible inventory, playbook, and roles, and how to execute them against the simulated lab environment. All of these steps should be performed **inside the `host` container**, which acts as your Ansible Control Node.

## 1. Access the Ansible Control Node
First, ensure your lab is running:
```bash
./ansible-lab.sh --start
```
Once the containers are up, access the `host` node:
```bash
docker exec -it host bash
```

## 2. Create the Inventory File (`inventory.ini`)
The inventory file tells Ansible what target servers exist, which group they belong to, and how to connect to them. 

Create a file named `inventory.ini`:
```ini
[databases]
server_1 ansible_host=172.20.0.10 ansible_user=root

[load_balancers]
server_2 ansible_host=172.20.0.20 ansible_user=root

[app_servers]
server_3 ansible_host=172.20.0.5 ansible_user=root

[all:vars]
ansible_ssh_pass=ansible-lab
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```
*(Note: Using passwords in plain text is fine for a local lab, but in production, you would use SSH keys or Ansible Vault).*

## 3. Create your First Playbook (`ping.yml`)
A playbook defines the tasks you want to execute against the target hosts. Let's start with a simple ping test.

Create a file named `ping.yml`:
```yaml
---
- name: Ping all servers to verify connectivity
  hosts: all
  tasks:
    - name: Ensure target machines are responding
      ansible.builtin.ping:
```

## 4. Execute the Playbook
Now, run the playbook referencing the inventory file you created:
```bash
ansible-playbook -i inventory.ini ping.yml
```
You should see all three servers respond with a `pong`.

## 5. Working with Roles
As your infrastructure grows, maintaining a single giant playbook becomes messy. Roles allow you to break down playbooks into reusable components.

Generate a new role for Nginx using the built-in `ansible-galaxy` tool:
```bash
ansible-galaxy init roles/nginx
```

This generates a folder structure under `roles/nginx/`. You would place your tasks inside `roles/nginx/tasks/main.yml`, for example:
```yaml
---
# roles/nginx/tasks/main.yml
- name: Install Nginx
  ansible.builtin.apt:
    name: nginx
    state: present
    update_cache: yes
```

Then, you can create a master playbook (e.g., `site.yml`) that maps roles to specific server groups:
```yaml
---
- name: Configure Load Balancers
  hosts: load_balancers
  become: yes
  roles:
    - nginx
```

Execute it identically:
```bash
ansible-playbook -i inventory.ini site.yml
```
