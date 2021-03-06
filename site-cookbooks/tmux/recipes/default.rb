#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "libevent" do
    action :install
end

package "libevent-devel" do
    action :install
end

package "glibc-static" do
    action :install
end
package "tmux" do
    action :install
    options "--enablerepo=rpmforge"
end

bash "tmux.conf" do
    user "testname"
    group "test"
    cwd "/home/testname"
    environment "HOME" => "/home/testname"
    code <<-EOC
        cp dotfiles/.tmux.conf .tmux.conf
    EOC
end
