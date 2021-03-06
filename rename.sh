# operator, can use sudo without password
export OPERATOR=vagrant
# create user, password
export USER=testname
export PASS=test
# create group
export GROUP=test
export SSH_NAME=webdb

sed -i -e "s|webdb|$SSH_NAME|" nodes/webdb.json
mv nodes/webdb.json nodes/$SSH_NAME.json

rename_testname(){    sed -i -e "s|testname|$USER|" site-cookbooks/$1/recipes/default.rb;         }
rename_webdb(){    sed -i -e "s|webdb|$GROUP|" site-cookbooks/$1/recipes/default.rb;     }
rename_vagrant(){    sed -i -e "s|vagrant|$OPERATOR|" site-cookbooks/$1/recipes/default.rb;     }

# rename data_bags/users/your_name.json
cp data_bags/users/testname.json data_bags/users/$USER.json
sed -i -e "s|testname|$USER|" data_bags/users/$USER.json

# rename site-cookbooks/cuda/recipes/default.rb
rename_testname cuda
rename_webdb cuda

# rename site-cookbooks/cvxopt/recipes/default.rb
rename_testname cvxopt
rename_webdb cvxopt

# rename site-cookbooks/mpi4py/recipes/default.rb
rename_testname mpi4py
rename_webdb mpi4py

# rename site-cookbooks/scipy/recipes/default.rb
rename_testname scipy
rename_webdb scipy

# rename site-cookbooks/pybrew/recipes/default.rb
rename_testname pybrew
rename_webdb pybrew
rename_vagrant pybrew

# rename site-cookbooks/tmux/recipes/default.rb
rename_testname tmux
rename_webdb tmux

# rename site-cookbooks/vim/recipes/default.rb
rename_vagrant vim

# rename site-cookbooks/testname/recipes/default.rb
# convert PASS to OPENSSL_PATH
openssl passwd -1 $PASS |while read i
do
    export PASSL=${i}
    sed -i -e "22s|YOUR_PASS|$PASSL|" site-cookbooks/add_user/recipes/default.rb
done
sed -i -e "18,52s|testname|$USER|" site-cookbooks/add_user/recipes/default.rb
sed -i -e "18,52s|webdb|$GROUP|" site-cookbooks/add_user/recipes/default.rb
