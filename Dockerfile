FROM rastasheep/ubuntu-sshd:18.04
MAINTAINER 131alexx@gmail.com
RUN apt-get update && apt-get install -y openssh-server net-tools vim sudo 
#RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN useradd -ms /bin/bash  alex
RUN echo 'alex:alex' | chpasswd
RUN sed -i s/\#\ *PasswordAuthentication\ yes/\ \ \ \ PasswordAuthentication\ no/g /etc/ssh/ssh_config
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir -p /root/.ssh
RUN mkdir -p /home/alex/.ssh
RUN usermod -a -G sudo alex
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbqd+Bdfiog+18eA1oiH9D764M3bYYFUB9QIRPjPT1LIJ/HAWlarTJuRefcRFHeUsB7ruw+0bt32FB70cFJ6hCKz4OAfc0qoXANFp399qnSW1xOaMvqqa3C1IicnNuR/AliRcsMkfrxPrQ8eLrr0CeDoPbgdstaXp4mylJNawJqkxf+KmdZGLzHc6nXZpZFDBUqyYASK/+cXXEPd/FO+CE9z4uoBNNriB9gUuCKxoD52aAcm6So7wkvWZHVZSiUESlSa9X2EFMzn2oBgyn5WpRGKN+Gs9a6lWSvSuD6pmVXRcalQ49L7OaI50Q2F5C/G0Csc2ANMNb/3bu8X50H0o/ alex@mi-debian" > /root/.ssh/authorized_keys  
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbqd+Bdfiog+18eA1oiH9D764M3bYYFUB9QIRPjPT1LIJ/HAWlarTJuRefcRFHeUsB7ruw+0bt32FB70cFJ6hCKz4OAfc0qoXANFp399qnSW1xOaMvqqa3C1IicnNuR/AliRcsMkfrxPrQ8eLrr0CeDoPbgdstaXp4mylJNawJqkxf+KmdZGLzHc6nXZpZFDBUqyYASK/+cXXEPd/FO+CE9z4uoBNNriB9gUuCKxoD52aAcm6So7wkvWZHVZSiUESlSa9X2EFMzn2oBgyn5WpRGKN+Gs9a6lWSvSuD6pmVXRcalQ49L7OaI50Q2F5C/G0Csc2ANMNb/3bu8X50H0o/ alex@mi-debian" > /home/alex/.ssh/authorized_keys  
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
