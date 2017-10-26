# Fake Ransomware

This is a script that simulates a single directory being hit by ransomware, but with the ability to easily restore any files affected.

## Usage Instructions

1. Make sure `ruby` is available on your system. On windows, you can run [RubyInstaller](https://rubyinstaller.org/). On MacOS and Linux it should be installed by default.
2. The ransomware tool is `fake_ransomware.rb`. It must be in a directory that has two child folders: `Files` and `Backup`. Initially, `Files` directory should contain the files which are to be encrypted (hit by ransomware), and the `Backup` directory should be empty.
3. Run `fake_ransomware.rb`. It should "encrypt" the files in `Files`, while backing them up in `Backup`.
4. Run `fake_ransomware.rb` again to restore from the backup directory.

## Caveats

Don't use this with the only copy of your files.
