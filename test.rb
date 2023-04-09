i = 0
arr = []
pid = fork {
    arr.push(5)
    i = i + 1
    x = ""
    if pid == nil;
        x = "nil"
    end
    puts "In Child: Current Process - " + Process.pid.to_s + " ppid - " + Process.ppid.to_s + " num-" + i.to_s 
}

if pid.nil?
    puts "Error? - " + pid.to_s
else 
    arr.push(10)
    i = i + 1
    puts "In Parent: Child Process - " + pid.to_s + " current process - " + Process.pid.to_s + " num-" + i.to_s
    pid2 = fork {
        puts "In Child2: Current Process - " + Process.pid.to_s + " ppid - " + Process.ppid.to_s
    }
end

# Process.waitall

# require_relative "Read_In.rb"

# Read_In.new("./data/fnma-dataset-group1.txt", "./data/fnma-dataset-group2.txt", "./data/fnma-dataset-group3.txt", "./data/fnma-dataset-group4.txt")