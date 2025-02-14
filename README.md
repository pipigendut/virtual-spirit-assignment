# Virtual Spirit Assignment

## Description
This script scans a directory and counts the number of files with identical content, regardless of their filenames. It uses SHA256 hashing to compare file contents efficiently, making it suitable for handling large files.

## How to Run
Run the script using the following command:

```sh
ruby count_files.rb <directory_path>
ruby count_files.rb ./public
```

## Output
The script will display the number of duplicate files based on their content. It also highlights the most common content with the highest file count.

```sh
abcdef 3
xyz123 4
Most common content: xyz123 with 4 files
```