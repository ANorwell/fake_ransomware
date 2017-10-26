#!/usr/bin/env ruby

CORRUPT_DIR = "./Files"
BACKUP_DIR = "./Backup"

def run_cmd(cmd)
  puts "Running #{cmd}"
  out = `#{cmd}`
  out
end

def skull
%q{
 _( )                 ( )_      _( )                 ( )_      _( )                 ( )_
(_, |      __ __      | ,_)    (_, |      __ __      | ,_)    (_, |      __ __      | ,_)
   \'\    /  ^  \    /'/          \'\    /  ^  \    /'/          \'\    /  ^  \    /'/
    '\'\,/\      \,/'/'            '\'\,/\      \,/'/'            '\'\,/\      \,/'/'
      '\| []   [] |/'                '\| []   [] |/'                '\| []   [] |/'
        (_  /^\  _)                    (_  /^\  _)                    (_  /^\  _)
          \  ~  /                        \  ~  /                        \  ~  /
          /VOGON\                        /VOGON\                        /VOGON\
        /'/{^^^}\'\                    /'/{^^^}\'\                    /'/{^^^}\'\
    _,/'/'  ^^^  '\'\,_            _,/'/'  ^^^  '\'\,_            _,/'/'  ^^^  '\'\,_
   (_, |           | ,_)          (_, |           | ,_)          (_, |           | ,_)
     (_)           (_)              (_)           (_)              (_)           (_)
}
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
  colorize(text, 31)
end

def restore
  puts "Restoring all corrupted files"
  if Dir["#{BACKUP_DIR}/*"].size == 0
    puts "Backup dir is empty! Exiting!"
    exit
  end

  Dir["#{CORRUPT_DIR}/*"].each do |file|
    File.delete(file)
  end

  Dir["#{BACKUP_DIR}/*"].each do |file|
    File.rename(file, "#{CORRUPT_DIR}/#{File.basename(file)}")
  end
end

def corrupt
  puts red(skull)
  puts red("Encrypting all files in #{CORRUPT_DIR}. Proceed? [y/n]")
  if STDIN.gets.chomp == "y"
    Dir.mkdir(BACKUP_DIR) unless Dir.exists?(BACKUP_DIR)

    if Dir["#{BACKUP_DIR}/*"].size > 0
      puts "Backup dir is not empty! Exiting!"
      exit
    end

    counter = 0
    Dir["#{CORRUPT_DIR}/*"].each do |file|
      counter += 1
      File.rename(file, "#{BACKUP_DIR}/#{File.basename(file)}")
      random_contents = counter.to_s
      corrupt_file = "#{CORRUPT_DIR}/#{counter}"
      File.write(corrupt_file, random_contents)
    end
  end

  puts red(skull)
  puts red("All files have been encrypted!")
  puts "Push any key to quit..."
  STDIN.gets
end

if ARGV[0] == "corrupt"
  corrupt
end


if ARGV[0] == "restore"
  restore
end

##infer based on state if no args
if Dir["#{BACKUP_DIR}/*"].size > 0
  restore
else
  corrupt
end

puts "Exiting..."
