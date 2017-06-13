# delete branch which already merge into develop&master
This script delete easily every remote branch which merged into origin/develop or origin/master.
You specify repository path only in script.


# How to add target repository?
open clean.sh by editor. then you can see variable REPOSITORY_NAME_LIST, REPOSITORY_ROOT_DIR.  
REPOSITORY_ROOT_DIR is base directory path of many repository.  
REPOSITORY_NAME_LIST is repository directory name list.  

## example
```bash
REPOSITORY_NAME_LIST="jays-project toy-project work-item"
REPOSITORY_ROOT_DIR="/home/user/jays/works/"
```

run clean.sh