# bash text bank
raw data management script like SQL and databases - wtitten in bash 5.14

![image](https://user-images.githubusercontent.com/54551308/172411545-14515cf7-468b-487d-b268-df59ff9fe223.png)

### What is Bash Text Bank?
text banks allow you to store and retrieve any data or move data in a single file, this way you can create permanent configurations and use that data.

### Installation
```bash
git clone "https://github.com/themispkg/bashtextbank"
cd bashtextbank
bash configure.sh && sudo make install
```

### Usage
Normally, documentation is important in such projects, but the purpose of bash text bank is light and portable, so I will leave a text that we can show as documentation, it won't be too long. It already has 11 features.

* #### create bank
Create compressed banks in gzip format,
maximum one parameter can be entered, 
a gzip file with .btb extension is
given with the entered parameter name.
```bash
btbshell --create-bank test
```

* #### create table
create tables inside the text bank.
```bash
btbshell --create-table --bank test.btb table1 table2
```

* #### create file
create files inside tables from text bank.
```bash
btbshell --create-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss
```

* #### remove table
delete tables from text bank.
```bash
btbshell --remove-table --bank test.btb table1 table2
```

* #### remove file
remove files inside tables.
```bash
btbshell --remove-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss
```

* #### check table
check if exist tables form text bank.
```bash
btbshell --check-table --bank test.btb table1 table2
```
* #### check file
check if exist files inside of tables from text bank.
```bash
btbshell --check-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss
```

* #### list table
list tables of a text bank.
```bash
btbshell --list-table --bank test.btb
```

* #### list file
list files insade of tables in text bank.
```bash
btbshell --list-file --bank test.btb --table table1 table2
```

* #### write file
write string data in any file of any table.
```bash
btbshell --write-file --bank test.btb --table table1 --file test1 --data "hello world"
```

* #### print file
print the data inside of file in table.
```bash
btbshell --print-file --bank test.btb --table table1 --file test1
```

### Example
```bash
#!/bin/bash

export bank="deneme"

. delphi "bashtextbank"

btb:create:bank "${bank}"
btb:create:table --bank "${bank}.btb" test1 test2
btb:create:file --bank "${bank}.btb" --table test1 --file example1 --table test2 --file example1
btb:write:file --bank "${bank}.btb" --table test1 --file example1 --data "Hello From Text Bank ;)"
btb:print:file --bank "${bank}.btb" --table test1 --file example1
btb:remove:file --bank "${bank}.btb" --table test1 --file example1
btb:remove:table --bank "${bank}.btb" test1
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
