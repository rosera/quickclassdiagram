# quickclassdiagram
Create graphical class diagrams based on text files

## Set up a directory to process the files

.
├── input

The input directory is used to hold the configuration file. Add a sample configuration to the directory e.g. test.sc

```
# User class
User

# User members
  nick
  numberCompleted
  email
  permission

# User methods
  recordPassword()

Forum
# Forum members
  number

# Forum methods
  accessPermission

Message
# Message members
  title

# Relationships
User -<> Messages
Forum -<> Messages
```

## Run the command to create the diagram

```
docker run --rm -v ${PWD}/input:/tmp/input --user $(id -u):$(id -g) quickclassdiagram:0.1 -i /tmp/input/test.sc
```

## Output 

The command should ouput a diagram similar to below:

![sample quickclassdiagram image](images/test.png?raw=true)

