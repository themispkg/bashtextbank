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

### Example
```bash
#!/bin/bash

export bank="deneme"

. delphi "bashtextbank"

btb:create:bank "${bank}"
btb:create:table "${bank}.btb"

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
