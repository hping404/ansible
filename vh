- name: Service Web
  hosts: node1
  become: true
  tasks:
    - name: Installation des paquets
      ansible.builtin.apt:
        - update
        - apache2

    - name: Modifier le port dans le bloc VirtualHost
      ansible.builtin.lineinfile:
        path: /etc/apache2/sites-available/000-default.conf
        regexp: '^<VirtualHost \*:[0-9]+>'
        line: '<VirtualHost *:8987>'
        state: present

    - name: Redémarrer Apache2
      ansible.builtin.service:
        name: apache2
        state: restarted
